#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/projects/github/dotfiles        # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
linkfiles="vimrc vim zshrc zcompctl zshenv zsh-func colorsdb"    # list of files/folders to symlink in homedir
newdirs="ssh vim-backup"    # folders that should exist, not symlinked
existfiles="ssh/known_hosts ssh/known_hosts2"    # files that should exist not symlinked

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $linkfiles
for file in $linkfiles; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/$olddir/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

for ndir in $newdirs; do
    echo "Making $ndir"
    mkdir -p ~/.$ndir
done
for file in $existfiles; do
    echo "Making $existfiles"
    touch ~/.$file
done

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install zsh
        install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh
