export EDITOR=nvim
export CMAKE_GENERATOR=Ninja
export NINJA_STATUS="[%f/%t, %e] "

export PATH="$PATH:$HOME/.local/bin:$HOME/.dotfiles/bin"

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[0;33m\]$(__git_ps1 " (🌿 %s)")\[\033[00m\]\$ '
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\W  \$(dirname '\w')\a\]$PS1"

alias nvim='PATH="$(build_path.lua)" nvim'
alias vim='nvim'
if command batcat --version &> /dev/null ; then
    alias bat='batcat'
fi
alias delta='delta --syntax-theme=gruvbox-light'
alias human='numfmt --to=si'

alias gd='git diff'
alias gs='git status'
alias gw='git worktree'
alias gdd='git diff | delta'
alias gds='git diff --staged'
alias gdds='git diff --staged | delta'
alias gss='git diff --staged | delta -s'
alias d='delta'

# Open man pages inside neovim by default. Use `env man` to use the default one.
man() { { echo ":only" | nvim "+Man $1 $2 $3 $4 $5" -s - ; } || env man "$@"; }

# Get ancestor build directory
bdir() {
    pwd | sed 's#\(/build[^/]*\)/.*#\1#'
}
alias cb='cmake --build `bdir` --parallel'
alias cbb='cmake --build'

function ask() {
    echo "   $@"
    read -p "Run this command? [Y/n]" WORD
    if [ "$WORD" = "Y" -o "$WORD" = "y" -o -z "$WORD" ]; then
        "$@"
    fi
}

function prune() {
    local branches="$(git branch -v | awk '/^  .* [[:xdigit:]]+ \[gone\]/ { print $1 }')"
    if [ -n "$branches" ]; then
        ask git branch -d $branches
    fi
}

function faketty() {
    script -qefc "$(printf "%q " "$@")" /dev/null
}
