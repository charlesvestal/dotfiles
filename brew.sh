# Install brew
if which brew >/dev/null; then
    echo Brew is installed
else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# brew tap homebrew/cask-cask

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade 

brew cask install visual-studio-code
brew cask install wavebox
brew cask install sourcetree
brew cask install google-chrome
brew cask install ivpn
brew cask install Agenda
brew cask install cleanmymac
brew cask install obinslab-starter
brew cask install private-internet-access
brew cask install figma

brew install mackup
brew isntall npm

npm install --global surge


brew cleanup