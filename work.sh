echo "Installing work specific applications..."
echo "..."

brew install cocoapods

brew tap phrase/brewed
brew install phraseapp

brew cask install Agenda
brew cask install figma
brew cask install sourcetree
brew cask install google-chrome

brew cask install charles

mas install 824171161   # Affinity Designer
mas install 409203825   # Numbers
mas install 409201541   # Pages
mas install 497799835   # Xcode

echo "Finished with work specific appliactions."