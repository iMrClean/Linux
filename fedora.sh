DIR_APP="$HOME/.local/applications"
DIR_GIT="$HOME/git"
directories=($DIR_APP $DIR_GIT)
RPM_FUSIN_FREE="https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
RPM_FUSIN_NONFREE="https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
RPM_SIMPLENOTE="https://github.com/Automattic/simplenote-electron/releases/download/v1.21.1/Simplenote-linux-1.21.1-x86_64.rpm"

# Bring back minimize buttons
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"

# Check and Install Updates
sudo dnf upgrade -y

# Make Directories
for dir in "${directories[@]}"
do
    mkdir -p $dir
done

# Enable RMP Fusion repos
sudo dnf install $RPM_FUSIN_FREE $RPM_FUSIN_NONFREE -y

# Install and remove appications from Reposetories
INSTALL_APPS="curl gnome-tweaks gparted htop krita mc micro powerline powerline-fonts vim-enhanced wget unzip zip"
sudo dnf install $INSTALL_APPS $RPM_SIMPLENOTE -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.sublimetext.three -y
flatpak install flathub com.skype.Client -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub org.kde.kdenlive -y

# Theme for bash
cat >> $HOME/.bashrc <<EOF
# PowerLine
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi
EOF

# VIM settings
cat > $HOME/.vimrc <<EOF
syntax on
set number
EOF

# Gnome Plugins for disabling
GNOME_EXT_01="apps-menu@gnome-shell-extensions.gcampax.github.com"
GNOME_EXT_02="background-logo@fedorahosted.org"
GNOME_EXT_03="horizontal-workspaces@gnome-shell-extensions.gcampax.github.com"
GNOME_EXT_04=launch-new-instance@gnome-shell-extensions.gcampax.github.com
GNOME_EXT_05="places-menu@gnome-shell-extensions.gcampax.github.com"
GNOME_EXT_06="window-list@gnome-shell-extensions.gcampax.github.com"
gnomeExtentions=($GNOME_EXT_01 $GNOME_EXT_02 $GNOME_EXT_03 $GNOME_EXT_04 $GNOME_EXT_05 $GNOME_EXT_06)
for gnomeExt in "${gnomeExtentions[@]}"
do
	gnome-extensions disable $gnomeExt
done
