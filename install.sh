#!/usr/bin/env bash

####################################
## Setup
####################################

dotfile_exact=(
  ".config/ghostty"
  ".config/starship.toml"
  ".gitconfig"
  ".zshrc"
)

# from dotfiles repo to absolute path
dotfile_map=(
  ".gitignore_global::$HOME/.gitignore"
)

code_directories=(
  "rcrowe"
  "thirdfort"
)

####################################
## Install
####################################

# Check for Oh My Zsh and install if we don't have it
printf "Installing Oh My Zsh...\n"
if [[ -z "${ZSH}" ]]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# Check for Homebrew and install if we don't have it
printf "\nSetting up Homebrew...\n"
if [[ -z "${HOMEBREW_PREFIX}" ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # temp load homebrew so further commands work
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew update
brew bundle

# Symlink files
printf "\nLinking config files...\n"
for file in ${dotfile_exact[@]}; do
  rm -rf $HOME/$file
  ln -s $HOME/.dotfiles/$file $HOME/$file
  echo "> $HOME/$file"
done

for index in ${dotfile_map[@]}; do
  FROM="${index%%::*}"
  TO="${index##*::}"

  rm -rf $TO
  ln -s $HOME/.dotfiles/$FROM $TO
  echo "> $TO"
done

# Code
printf "\nSetting up code directories...\n"
mkdir -p ~/code

for dir in ${code_directories[@]}; do
  mkdir -p ~/code/$dir
  echo "> ~/code/$dir"
done

printf "\nSetting up git...\n"
git config --global core.excludesfile ~/.gitignore
git config --global user.name "Rob Crowe"
git config --global user.email "nobby.crowe@gmail.com"

####################################
## OSX
####################################

printf "\nSetting up OSX...\n"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# ~~~~~~~~~~~~~
# General UI/UX
# ~~~~~~~~~~~~~
printf "> general ui/ux\n"

if [[ -v COMPUTER_NAME ]]; then
  sudo scutil --set ComputerName $COMPUTER_NAME
  sudo scutil --set HostName $COMPUTER_NAME
  sudo scutil --set LocalHostName $COMPUTER_NAME
  sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
fi

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
printf "> trackpad, mouse, keyboard, bluetooth accessories, and input\n"

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# ~~~~~~~~~~~~~
# Screen
# ~~~~~~~~~~~~~
printf "> screen\n"

# Re-enable subpixel antialiasing
defaults write -g CGFontRenderingFontSmoothingDisabled -bool FALSE

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Disable thumbnail preview and eliminate the wait time before the screenshot is saved
defaults write com.apple.screencapture show-thumbnail -bool false

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# ~~~~~~~~~~~~~
# Finder
# ~~~~~~~~~~~~~
printf "> finder\n"

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dock, Dashboard, and hot corners
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
printf "> dock, dashboard, and hot corners\n"

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 44

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool false

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Hot corners
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-br-corner -int 0

####################################
## Rectangle
####################################

# Gap between windows
defaults write com.knollsoft.Rectangle gapSize -int 5

# Start at login
defaults write com.knollsoft.Rectangle launchOnLogin -bool true

# Cycle sizes on half actions
defaults write com.knollsoft.Rectangle subsequentExecutionMode -int 0

# Check for updates automatically
defaults write com.knollsoft.Rectangle SUAutomaticallyUpdate -bool true

####################################
## Kill affected applications
####################################

for app in \
	"Dock" \
	"Finder" \
  "Rectangle"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
