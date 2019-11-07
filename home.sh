brew cask install osxfuse
brew cask install filebot

#TODO get filebot license and put in ~/Downloads

#TODO set up filebot parsing (maybe keep on rpi?)
# TODO add to cron:
#   filebot -script fn:amc --output ~/mount/putio -non-strict --def clean=y subtitles=en artwork=y --conflict auto ~/mount/putio/_To\ Rename
#   filebot -script fn:amc --output ~/mount/putio -non-strict --def clean=y subtitles=en artwork=y --conflict auto ~/mount/putio/Movies
#   filebot -script fn:configure
#
#   filebot -script ~/Library/Application\ Support/Filebot/Scripts/artwork.tvdb.groovy ~/mount/putio/TV\ Shows
#   filebot -script fn:artwork.tmdb ~/mount/putio/Movies
#   filebot -script fn:suball ~/mount/putio/Movies -non-strict --def
#   filebot -script fn:suball ~/mount/putio/TV\ Shows -non-strict --def

# TODO add exclude list 

curl https://rclone.org/install.sh | sudo bash
rclone config # configure rclone putio 

#TODO add putio rclone config and automount
