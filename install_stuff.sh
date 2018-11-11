#/bin/bash

sudo -v


if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

tools=(
    fish
    iterm2
    kubectl
    minikube
    coreutils
    findutils
    git
    qlmarkdown
    qlprettypatch
    qlstephen
    quicklook-json
    qlcolorcode
    qlimagesize
    qlvideo
    vscodium
    golang
)

casks=(
    sourcetree
    spotify
    spectacle
    slack
    suspicious-package
    minikube
    google-chrome
    chromium
    brave-browser
    bitwarden
    telegram
    whatsapp
)


tools2=(
    docker-completion
    docker-compose-completion
)

fonts=(
  font-clear-sans
  font-roboto
)


echo "installing tools..."
brew install ${tools[@]}
echo "installing apps..."
brew cask install ${casks[@]}
echo "installing tools..."
brew install ${tools2[@]}
echo "installing fonts..."
brew cask install ${fonts[@]}


brew cleanup


touch ~/.config/fish/config.fish

mkdir -p ~/Code/golang
echo "set -gx GOPATH $HOME/Code/golang" >>  ~/.config/fish/config.fish
echo "set -gx PATH $PATH $HOME/Code/golang/bin" >>  ~/.config/fish/config.fish

echo "set -gx MANPATH \$MANPATH /usr/local/opt/findutils/libexec/gnuman" >>  ~/.config/fish/config.fish
echo "set -gx PATH /usr/local/opt/findutils/libexec/gnubin \$PATH" >>  ~/.config/fish/config.fish

echo "set -gx PATH /usr/local/opt/coreutils/libexec/gnubin \$PATH" >>  ~/.config/fish/config.fish
echo "set -gx MANPATH \$MANPATH /usr/local/opt/coreutils/libexec/gnuman" >>  ~/.config/fish/config.fish

osascript -e 'tell application "System Preferences" to quit'


while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

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

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Increase sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write com.visualstudio.code.oss ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 13

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# Finder                                                                      #
###############################################################################

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "cfprefsd" \
	"Dock" \
  "Finder" \
  "SystemUIServer"; do
  killall "${app}" &> /dev/null
done




echo "Host *" | tee $HOME/.ssh/config
echo "  ServerAliveInterval 60" | tee $HOME/.ssh/config
echo "  StrictHostKeyChecking no" | tee $HOME/.ssh/config
echo "  UseKeychain yes" | tee $HOME/.ssh/config



###############################################################################
# VSCodium
###############################################################################

# $HOME/Library/Application Support/VSCodium/User

modules=(
    2gua.rainbow-brackets
    eamodio.gitlens
    ms-vscode.Go
    PKief.material-icon-theme
)
for module in $modules; do
    vscodium --install-extension "$module" || true
done


###############################################################################
# Dock                                                                        #
###############################################################################

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Dont show recents
defaults write com.apple.dock show-recents -bool false

# Icon size of Dock items
defaults write com.apple.dock tilesize -in 34
defaults write com.apple.dock largesize -int 77

# Dock magnification
defaults write com.apple.dock magnification -bool true

# Prefer tabs when opening documents: 'always', 'fullscreen', 'manual'
defaults write NSGlobalDomain AppleWindowTabbingMode -string 'always'

# Dock orientation: 'left', 'bottom', 'right'
defaults write com.apple.dock 'orientation' -string 'bottom'

# Dock pinning: 'start', 'middle', 'end'
# defaults write com.apple.dock pinning -string 'middle'

# Double-click a window's title bar to:
# None
# Mimimize
# Maximize (zoom)
defaults write NSGlobalDomain AppleActionOnDoubleClick -string "Maximize"

# Minimize to application
defaults write com.apple.dock minimize-to-application -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Auto-hide delay
defaults write com.apple.dock autohide-delay -float 0

# Auto-hide animation duration
defaults write com.apple.dock autohide-time-modifier -float 0

# Spring loaded Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Highlight hover effect for the grid view of a stack
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# Apple may use this preference to automatically add Launchpad to the Dock
defaults write com.apple.dock 'checked-for-launchpad' -bool true

# Remove all (default) app icons from the Dock
defaults write com.apple.dock persistent-apps -array


###############################################################################
# Finder                                                                      #
###############################################################################

# New window target
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other…       : `PfLo`
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Path bar
defaults write com.apple.finder ShowPathbar -bool true

# Search scope
# This Mac       : `SCev`
# Current Folder : `SCcf`
# Previous Scope : `SCsp`
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Setup new window and tab behvior
# 0: Homepage
# 1: Empty Page
# 2: Same Page
# 3: Bookmarks
# 4: Top Sites
defaults write com.apple.Safari NewTabBehavior -int 3
defaults write com.apple.Safari NewWindowBehavior -int 4

# Remove downloads list items
# 0: Manually
# 1: When Safari Quits
# 2: Upon Successful Download
defaults write com.apple.Safari DownloadsClearingPolicy -int 2

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# Disable AutoFill
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Show status bar
defaults write com.apple.Safari ShowStatusBar -bool true


###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
    General -bool true \
    OpenWith -bool true \
    Privileges -bool true

# Group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool true

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Week should start on Monday
defaults write com.apple.ical "first day of the week" 1

# Day starts at 9AM
defaults write com.apple.ical "first minute of work hours" 540


###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
    "Dock" "Finder" "Mail" "Messages" "Photos" "Safari" "SystemUIServer" \
    "Terminal" "Tweetbot" "iCal"; do
    killall "${app}" &> /dev/null
done