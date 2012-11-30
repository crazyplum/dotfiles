script_dir="$(dirname "$(readlink -f $0)")"
source "$script_dir/zsh_basic.zsh"

alias ..="cd .."
alias ...="cd ../.."

function ..() {
        num=$1
    test $1 || num=1
    seq=`seq $num`
    next=`../%. {$seq}`
    cd $next
    ls  
}
