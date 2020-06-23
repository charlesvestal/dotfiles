echo "Installing work specific applications..."
echo "..."

brew cask install google-chrome
brew cask install zoomus
killall zoom.us
brew cask install proxyman
brew cask install microsoft-teams
brew cask install microsoft-outlook

mas install 1510445899 # Meeter

echo "Finished with work specific appliactions."
