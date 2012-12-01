from fabric.api import *
from fabric.utils import *
from fabric.colors import *
import os
from os import path
import errno
import shutil
import functools
import fileinput

def generate_conf(name, email):
    """
    """
    with open('dotfiles-conf.sh','w') as conf_file:
        conf_file.write(
'''
export FULLNAME='{name}'
export EMAIL='{email}'
''' )



def print_acting(message, has_result=False, type='info', level=0):
    """

    Arguments:
    - `message`:
    """
    if has_result:
        end = ' ... '
    else:
        end = '\n'

    if type == 'info':
        head = green(' * ')
    elif type == 'warn':
        head = yellow(' ! ')
    elif type == 'err':
        head = red('!! ')

    puts(' '*level*3 + head + message ,  end = end, flush=True)

def print_result(message):
    """

    Arguments:
    - `message`:
    """
    fastprint(message, end='\n')

class AnsError(Exception):
    def __init__(self, expects, ans):
        self.expects = expects
        self.ans = ans
        self.message = 'AnsError: expecting {expects}, wrong answer `{ans}\''.format(ans = self.ans, expects =  '('+', '.join(self.expects) +')' )
    def __str__(self):
        return 'AnsError: expecting {expects}, wrong answer `{ans}\''.format(ans = self.ans, expects =  '('+', '.join(self.expects) +')' )

def pprompt(message, expects = '', level = 0,   *args, **kwargs):
    """

    Arguments:
    - `message`:
    - `expects`:
    - `default`:
    """
    head = magenta('>>> ')
    if expects == '':
        expects_txt = ''
    else:
        expects_txt = magenta('('+', '.join(expects) +')')
    def validate(ans):
        """

        Arguments:
        - `expects`:
        - `ans`:
        """
        if expects == '' or ans in expects:
            return ans
        raise AnsError(expects, ans)


    return prompt(  head + message + ' ' + expects_txt , validate = validate, *args, **kwargs)



def symlink(src, tgt):
    """

    Arguments:
    - `src`: symbolic link source
    - `tgt`: symbolic link target
    """
    print_acting('Symlinking {src} to {tgt}'.format(src = blue(src), tgt = blue(tgt))
                 , has_result=True)
    try:
        os.symlink(src, tgt)
        print_result(green('done'))
    except OSError, e:
        if e.errno == errno.EEXIST:
            ret = pprompt('exists. Replace it?'.format(tgt = tgt), expects = ['y', 'n'], default='y', level = 1)
            if ret == 'y':
                print_acting('Replacing {tgt}'.format(tgt = blue(tgt))
                             , type='warn', level = 1
                             , has_result = True)
                def rmtree_onerror(func, path, excinfo):
                    """

                    Arguments:
                    - `func`:
                    - `path`:
                    - `excinfo`:
                    """
                    if func == os.path.islink:
                        os.remove(path)

                shutil.rmtree(tgt, onerror = rmtree_onerror )
                os.symlink(src, tgt)
                print_result(green('done'))
            elif ret == 'n':
                print_acting('Ignored'.format(tgt = blue(tgt))
                             , type='warn', level = 1
                             , has_result = False)


def deploy_submodule():
    """
    """
    local('git submodule init')
    local('git submodule update')




@task
def deploy(name = '', email = ''):
    """

    Arguments:
    - `name`: Full Name
    - `email`: Email
    """
    if not name : name = pprompt('Full Name:')
    if not email: email = pprompt('Email:')

    generate_conf(name, email)

    local("sed 's:^export DOTFILES_ROOT=.*$:export DOTFILES_ROOT={root}:'  <  {shrc} > {shrc}.new".format(
        shrc = "dotfiles/.zshrc", root = path.abspath(path.dirname(__file__))))
    local('mv {shrc}.new {shrc}'.format(shrc = "dotfiles/.zshrc"))
    local("sed 's:^export DOTFILES_ROOT=.*$:export DOTFILES_ROOT={root}:'  <  {shrc} > {shrc}.new".format(
        shrc = "dotfiles/.bashrc", root = path.abspath(path.dirname(__file__))))
    local('mv {shrc}.new {shrc}'.format(shrc = "dotfiles/.bashrc"))

    slink_srcs = map(functools.partial(os.path.join, 'dotfiles'), os.listdir('dotfiles'))
    slink_srcs += ['bin']
    slink_srcs = map(functools.partial(os.path.relpath, start=os.getenv('HOME')), slink_srcs)
    for slink_src in slink_srcs:
        slink_tgt = os.path.abspath(os.path.join(os.getenv('HOME'), os.path.basename(slink_src)))
        symlink(slink_src, slink_tgt)

    deploy_submodule()
