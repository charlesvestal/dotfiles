echo "Installing Mac App Store and other manually installed applications..."
echo "..."

if which mas >/dev/null; then
    echo mas is installed
else
    brew install mas
fi

mas install 824183456  # Affinity Photo
mas install 1448316680 # TranslateMe
mas install 1160374471 # PiPifier
mas install 1147396723 # Whatsapp
mas install 549083868 # Display Menu
mas lucky "1Password 7" # Assuming you have a work account for 1pass

echo "Get the license key for AirBuddy from your email and proceed with installation. "
read -p "Press [Enter] to open the AirBuddy site to download the zip."
echo ""

open https://su.airbuddy.app/index.html #download airbuddy

read -p "Press [Enter] once AirBuddy is downloaded."
echo ""

# not necessary if we don't have "open safe files after downloading checked" yet
# unzip ~/Downloads/verify.zip -d /Applications
# rm ~/Downloads/verify.zip
mv ~/Downloads/AirBuddy.app /Applications/

echo "Finished with Mac App Store and other manually installed appliactions."
