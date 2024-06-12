export EDITOR=nvim
export CMAKE_GENERATOR=Ninja

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[0;33m\]$(__git_ps1 " (🌿 %s)")\[\033[00m\]\$ '
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\W  \$(dirname '\w')\a\]$PS1"

alias vim='nvim'
alias bat='batcat --theme Coldark-Cold'
alias delta='delta --syntax-theme=gruvbox-light'
alias human='numfmt --to=si'

# Get ancestor build directory
bdir() {
    pwd | sed 's#\(/build[^/]*\)/.*#\1#'
}
alias cb='cmake --build `bdir` --parallel'

function ask() {
    echo "   $@"
    read -p "Run this command? [Y/n]" WORD
    if [ "$WORD" = "Y" -o "$WORD" = "y" -o -z "$WORD" ]; then
        "$@"
    fi
}

function prune() {
    local branches="$(git branch -v | awk '/\w+\s+\w+.* \[gone\]/ { print $1 }')"
    if [ -n "$branches" ]; then
        ask git branch -d $branches
    fi
}
