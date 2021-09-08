if [[ -d /media/fots/backupfiles ]]
then
    MSG="`date +"%d %m %Y %H:%M"`"
    [ -z "$1" ] || MSG=$1
    echo "last backup: `date +"%d-%m-%Y %H:%M"`" > /media/fots/backupfiles/backup.log
    echo "Progress 0%"
    cp  ~/.bashrc /media/fots/backupfiles/dotfiles/
    echo "Progress 1%"
    cp  ~/.vimrc /media/fots/backupfiles/dotfiles/
    echo "Progress 2%"
    cp  ~/.scripts/echo_info.sh /media/fots/backupfiles/dotfiles/
    echo "Progress 3%"
    cp  ~/.scripts/colors.sh /media/fots/backupfiles/dotfiles/
    echo "Progress 4%"
    cp  ~/backup.sh /media/fots/backupfiles/dotfiles/
    echo "Progress 5%"
    git -C "/media/fots/backupfiles/dotfiles/" add --all  > /dev/null 2>&1
    git -C "/media/fots/backupfiles/dotfiles/" commit -m "$MSG" > /dev/null 2>&1
    git -C "/media/fots/backupfiles/dotfiles/" push origin master > /dev/null 2>&1
    echo "Progress 15%"
    cp -rT ~/Videos /media/fots/backupfiles/Videos
    echo "Progress 20%"
    cp -rT ~/Pictures /media/fots/backupfiles/Pictures
    echo "Progress 25%"
    cp -rT ~/Documents /media/fots/backupfiles/Documents
    echo "Progress 30%"
    cp -rfT ~/facultad /media/fots/backupfiles/facultad
    echo "Progress 100%"
fi

