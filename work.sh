echo "Installing work specific applications..."
echo "..."

brew tap phrase/brewed
brew install phraseapp

brew cask install Agenda
brew cask install figma
brew cask install sourcetree
brew cask install google-chrome

brew cask install charles

mas install 824171161 # Affinity Designer
mas install 409203825 # Numbers
mas install 409201541 # Pages

# echo "Installing iOS development software..."

# mas install 497799835   # Xcode
# brew install cocoapods

# echo "Installing Android development software..."

# brew cask install homebrew/cask-versions/adoptopenjdk8
# brew cask install android-sdk

# echo "export ANDROID_HOME=/usr/local/share/android-sdk" >> ~/.bash_profile
# source ~/.bash_profile

# echo "" > ~/.android/repositories.cfg
# touch ~/.android/repositories.cfg
# sdkmanager --update
# sdkmanager "platform-tools" "platforms;android-28"

# brew cask install android-studio

echo "Finished with work specific appliactions."
