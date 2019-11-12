echo "Installing Mac App Store applications..."

if which mas >/dev/null; then
    echo mas is installed
else
    brew install mas
fi

mas install 824183456   # Affinity Photo
mas install 443987910   # 1Password Legacy
mas install 1448316680  # TranslateMe
mas install 1160374471  # PiPifier
mas install 409203825   # Numbers

echo "Get the license key for AirBuddy from your email and proceed with installation. "
read -p "Press [Enter] to open the AirBuddy site to download, then install."
echo ""

open https://su.airbuddy.app/index.html #download airbuddy