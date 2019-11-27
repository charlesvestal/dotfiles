echo "Installing homebrew and associated casks and applications..."

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
brew cask install figma

brew install zsh
brew tap sambadevi/powerlevel9k
brew install powerlevel9k

brew cask install tunnelblick

brew install mackup
brew install npm

brew tap homebrew/cask-fonts

brew cask install font-raleway # Resumé font
brew cask install font-firacode-nerd-font # Code font 2

npm install --global surge

brew cleanup    