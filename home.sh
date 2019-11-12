echo "Installing home specific applications..."

brew cask install osxfuse
brew cask install filebot

#TODO get filebot license and put in ~/Downloads

#TODO set up filebot parsing (maybe keep on rpi?)
# TODO add to cron:
#   filebot -script fn:amc --output ~/mount/putio -non-strict --def clean=y subtitles=en --filter '!readLines('~/mount/putio/excludes.txt').contains(n)' --conflict auto ~/mount/putio/_To\ Rename
#   filebot -script fn:amc --output ~/mount/putio -non-strict --def clean=y subtitles=en --filter '!readLines('~/mount/putio/excludes.txt').contains(n)' --conflict auto ~/mount/putio/Movies
#   filebot -script fn:configure
#
#   filebot -script ~/Library/Application\ Support/Filebot/Scripts/artwork.tvdb.groovy ~/mount/putio/TV\ Shows
#   filebot -script fn:artwork.tmdb ~/mount/putio/Movies
#   filebot -script fn:suball ~/mount/putio/Movies -non-strict --def
#   filebot -script fn:suball ~/mount/putio/TV\ Shows -non-strict --def

# TODO add exclude list 

echo "Next we will install rclone and configure your put.io credentials"
read -p "Press [Enter] to continue."
echo ""

curl https://rclone.org/install.sh | sudo bash  
rclone config # configure rclone putio 

#TODO add putio rclone config and automount

