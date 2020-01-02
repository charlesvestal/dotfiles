echo "Installing work specific applications..."
echo "..."

brew tap phrase/brewed
brew install phraseapp

brew cask install Agenda
brew cask install figma
brew cask install sourcetree
brew cask install google-chrome

mas install 824171161   # Affinity Designer
mas install 409203825   # Numbers
mas install 409201541   # Pages

echo "Finished with work specific appliactions."