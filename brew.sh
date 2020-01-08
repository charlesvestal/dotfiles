echo "Installing homebrew and associated common casks and applications..."
echo "..."

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

brew cask install tunnelblick
brew cask install wavebox
brew cask install visual-studio-code

brew cask install cleanmymac
brew cask install obinslab-starter
brew cask install xld

brew install zsh
brew tap sambadevi/powerlevel9k
brew install powerlevel9k
brew tap homebrew/cask-fonts

brew cask install font-raleway # Resumé font
brew cask install font-firacode-nerd-font # Code font 2

brew install mackup
brew install npm

npm install --global surge

brew cleanup    

echo "Finished installing homebrew and associated casks and applications..."