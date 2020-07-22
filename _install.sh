echo "First things first, go to settings and enable right click for your pointing device. "
read -p "Press [Enter] to continue."
echo ""

echo "Let's get some stuff set up! First, we'll ask for your administrator password up front so we can install all the things we need to."

# Ask for the administrator password upfront.
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

sh brew.sh
sh mas.sh

read -p "Are this machine for home use? (y/n)" choice
case "$choice" in
y | Y)
  echo "Proceeding with home.sh..."
  sh home.sh
  ;;
n | N)
  echo "Proceeding with work.sh..."
  sh work.sh
  ;;
*) echo "invalid" ;;
esac

brew install mackup
read -p "Would you like to restore your settings for supported applictions from mackup? If you've just set up this machine, iCloud probably hasn't synced yet." choice
case "$choice" in
y | Y)
  echo "Restoring from mackup..."
  echo "[storage]\nengine = icloud" > ~/.mackup.cfg
  mackup restore -f
  ;;
n | N) echo "Skipping restore. Proceeding..." ;;
*) echo "invalid" ;;
esac
echo ""

sh defaults.sh

killall Finder
killall Dock

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
echo 'ZSH_THEME="powerlevel9k/powerlevel9k"' >>~/.zshrc

# TODO add Gmailinator https://github.com/wwwjfy/GMailinator
# defaults write com.apple.mail EnableBundles -bool true

echo "Done!"
