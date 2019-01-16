# Adds ~/bin to PATH
set PATH $PATH $HOME/.local/bin/


# git but for dot files
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dot-commit='dot commit -am'
alias dot-ls='dot ls-tree -r HEAD --name-only'
alias dot-remove='dot rm --cached'
