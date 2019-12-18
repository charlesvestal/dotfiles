echo "Installing home specific applications..."

brew cask install osxfuse
brew cask install filebot

read -p "Download your filebot license from your email to ~/Downloads and rename to 'filebot.psm'.
Press [Enter] to continue."
echo ""

filebot --license ~/Downloads/filebot.psm 
rm ~/Downloads/filebot.psm 

read -p "Next, get your rclone putio access_token from your email and enter it here without quotes: " rclone_token
echo ""
curl https://rclone.org/install.sh | sudo bash  
echo '\n[putio]\ntype = putio\ntoken = {"access_token":"'$rclone_token'","expiry":"0001-01-01T00:00:00Z"}' > ~/.config/rclone/rclone.conf             
echo '\n[putio]\ntype = putio\ntoken = {"access_token":"MR5XLHNH7MHVYEAPQ43U","expiry":"0001-01-01T00:00:00Z"}' > ~/.config/rclone/rclone.conf             

echo "Adding rclone and filebot aliases to .zshrc"
echo ""

echo 'alias putmount="rclone mount putio: ~/mount/putio --daemon"' >> ~/.zshrc
echo 'alias putrename="filebot -script fn:amc --output ~/mount/putio -non-strict --def clean=y subtitles=en --conflict auto ~/mount/putio/_To\ Rename"' >> ~/.zshrc

source ~/.zshrc

putmount

# TODO add putio automount

