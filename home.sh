echo "Installing home specific applications..."

brew cask install osxfuse
brew cask install filebot

# TODO get filebot license and put in ~/Downloads
# TODO read filebot license
# TODO set up filebot parsing (maybe keep on rpi?)

# TODO add to cron:
#   filebot -script fn:amc --output ~/mount/putio -non-strict --def clean=y subtitles=en --conflict auto ~/mount/putio/_To\ Rename
#   

echo "Next we will install rclone and configure your put.io credentials"
read -p "Press [Enter] to continue."
echo ""

curl https://rclone.org/install.sh | sudo bash  
rclone config # configure rclone putio 

# TODO add putio rclone config and automount

