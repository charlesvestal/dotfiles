echo "Installing home specific applications..."
echo "..."

mas install lucky Paprika
mas install 443987910  # 1Password Legacy

brew cask install private-internet-access_token
echo "Installing osxfuse..."

brew cask install osxfuse
read -p "osxfuse has been installed. Head to System Preferences -> Security and Privacy and enable the extension. Press [Enter] to continue."
echo ""

echo "Installing filebot..."
brew cask install filebot
read -p "Download your filebot license from your email to ~/Downloads and rename to 'filebot.psm'.
Press [Enter] to continue."
echo ""

sudo spctl --master-disable
filebot --license ~/Downloads/filebot.psm
sudo spctl --master-enable
rm ~/Downloads/filebot.psm
filebot -script fn:configure

read -p "Next, get your rclone putio access_token from your email and enter it here without quotes: " rclone_token
echo "Installing rclone..."
echo ""
curl https://rclone.org/install.sh | sudo bash
echo '\n[putio]\ntype = putio\ntoken = {"access_token":"'$rclone_token'","expiry":"0001-01-01T00:00:00Z"}' >~/.config/rclone/rclone.conf

echo "Adding rclone and filebot aliases to .zshrc..."
echo ""

echo 'alias putmount="rclone mount putio: ~/mount/putio --daemon"' >>~/.zshrc
echo 'alias putrename="filebot -script fn:amc --output ~/mount/putio -non-strict --def clean=y subtitles=en --conflict auto ~/mount/putio/_To\ Rename"' >>~/.zshrc
echo 'alias putrenameorson="filebot -script fn:amc --output ~/mount/putio/Orson -non-strict --def clean=y --conflict auto ~/mount/putio/Orson/_Parse"' >>~/.zshrc

source ~/.zshrc

mkdir ~/mount/putio
putmount

# TODO add putio automount

echo "Finished with home specific appliactions."
