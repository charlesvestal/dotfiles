# Ask for the administrator password upfront.
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sh brew.sh
sh mas.sh


read -p "Are you at home (y/n)?" choice
case "$choice" in 
  y|Y ) echo "Proceeding with home.sh."; sh home.sh;;
  n|N ) echo "Proceeding with work.sh."; sh work.sh;;
  * ) echo "invalid";;
esac

sh defaults.sh

killall Finder
killall Dock

echo "Done!"