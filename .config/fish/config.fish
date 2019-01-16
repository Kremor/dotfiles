# Adds ~/bin to PATH
set PATH $PATH /home/kremor/bin/ /home/kremor/.local/bin/


# git but for dot files
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias dot-remove='dot rm --cached'
