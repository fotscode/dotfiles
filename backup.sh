#!/bin/bash
if [[ -d /mnt/backupfiles ]]
then
    MSG="`date +"%d %m %Y %H:%M"`"
    [ -z "$1" ] || MSG=$1
    echo "last backup: `date +"%d-%m-%Y %H:%M"`" > /mnt/backupfiles/backup.log
    echo "Progress 0%"
    cp  ~/.bashrc /mnt/backupfiles/dotfiles/
    echo "Progress 1%"
    cp  ~/.vimrc /mnt/backupfiles/dotfiles/
    echo "Progress 2%"
    cp  ~/.scripts/echo_info.sh /mnt/backupfiles/dotfiles/
    echo "Progress 3%"
    cp  ~/.scripts/colors.sh /mnt/backupfiles/dotfiles/
    echo "Progress 4%"
    cp  ~/backup.sh /mnt/backupfiles/dotfiles/
    echo "Progress 5%"
    cp  ~/.zshrc /mnt/backupfiles/dotfiles/
    echo "Progress 6%"
    cp  ~/.config/i3/config /mnt/backupfiles/dotfiles/
    echo "Progress 7%"
    cp  ~/.config/i3status/config /mnt/backupfiles/dotfiles/
    echo "Progress 8%"
    cp  ~/.oh-my-zsh/themes/fots.zsh-theme /mnt/backupfiles/dotfiles/
    echo "Progress 9%"
    git -C "/mnt/backupfiles/dotfiles/" add --all  > /dev/null 2>&1
    git -C "/mnt/backupfiles/dotfiles/" commit -m "$MSG" > /dev/null 2>&1
    git -C "/mnt/backupfiles/dotfiles/" push origin master > /dev/null 2>&1
    echo "Progress 15%"
    cp -rT ~/Videos /mnt/backupfiles/Videos
    echo "Progress 20%"
    cp -rT ~/Pictures /mnt/backupfiles/Pictures
    echo "Progress 25%"
    cp -rT ~/Documents /mnt/backupfiles/Documents
    echo "Progress 27%"
    cp -rT ~/Books /mnt/backupfiles/Books
    echo "Progress 30%"
    find ~/facultad -size +512M -printf "%f\n" > /tmp/exclude.txt
    rsync -av ~/facultad /mnt/backupfiles/facultad --exclude-from=/tmp/exclude.txt --quiet
    echo "Progress 100%"
fi

