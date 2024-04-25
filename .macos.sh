#!/usr/bin/env bash

#!/usr/bin/env bash

# ~/.macos — Custom setup script based on current settings

# Close any open System Preferences panes to prevent conflicts
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Show all hidden files in Finder
defaults write com.apple.Finder AppleShowAllFiles true  # Forces Finder to show hidden files
defaults write com.apple.finder AppleShowAllFiles TRUE  # Same setting as above, ensuring consistency across potential case-sensitivity
killall Finder  # Restarts Finder to apply visibility changes

# Enable light appearance system-wide and manage hotkeys for theme switching
defaults write -g NSRequiresAquaSystemAppearance -bool false  # Forces all applications to use the light theme
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool true  # Enables a hotkey for switching between light and dark themes
sudo defaults write /Library/Preferences/.GlobalPreferences.plist _HIEnableThemeSwitchHotKey -bool false  # Disables the hotkey immediately after enabling it

# Configure appearance settings for REAPER, a digital audio workstation
defaults write com.cockos.reaper NSRequiresAquaSystemAppearance 1  # Enables the system's light/dark appearance settings for REAPER
# Miscellaneous appearance settings
defaults write -g NSRequiresAquaSystemAppearance -bool No  # Disables the enforcement of system appearance settings across all applications
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"  # Sets Finder's default view style to Column View ('clmv' for column)
killall Finder  # Restarts Finder to apply view style and hidden file visibility settings

# Accent and highlight color settings
defaults write -globalDomain "AppleAquaColorVariant" -int 1
defaults write -globalDomain "AccentColor" -int 0
defaults write -globalDomain "AppleHighlightColor" -string "1.000000 0.733333 0.721569 Red"
defaults write -g NSTableViewDefaultSizeMode -int 2  # Adjusts the size mode of table views within the system UI
defaults write -g AppleShowScrollBars -string "Automatic"  # Sets the scroll bars to appear automatically based on mouse or trackpad interaction
defaults write -g AppleScrollerPagingBehavior -bool true  # Enables pagination behavior when clicking the scroll bar

# Configure press-and-hold behavior for VS Code and variants
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false  # Disables the press-and-hold key repeat functionality in VS Code to enhance typing performance
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false  # Same setting for VS Code Insiders
defaults write com.vscodium ApplePressAndHoldEnabled -bool false  # Same setting for VSCodium, an open source version of VS Code
defaults write com.microsoft.VSCodeExploration ApplePressAndHoldEnabled -bool false  # Same setting for VS Code Exploration builds
defaults delete -g ApplePressAndHoldEnabled  # Resets the global press-and-hold setting to default

# Dock modification settings
defaults write com.apple.dock autohide-time-modifier -float 2; killall Dock  # Modifies the animation time for Dock auto-hiding to 2 seconds
# Continues with similar settings for other time durations
defaults write com.apple.dock mineffect suck; killall Dock  # Changes the minimize effect for windows in the Dock to 'suck'
defaults write com.apple.dock static-only -bool TRUE; killall Dock  # Restricts the Dock to only include applications that have been explicitly added by the user
defaults write com.apple.dock persistent-others -array-add \n'{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }' && \nkillall Dock  # Adds a 'recent items' tile to the Dock for quick access

# Finder behavioral settings
defaults write com.apple.finder QuitMenuItem -bool false  # Removes the 'Quit Finder' option from the Finder menu
defaults write com.apple.finder QuitMenuItem -bool true  # Re-enables the 'Quit Finder' option in the Finder menu
defaults write com.apple.finder DisableAllAnimations -bool true  # Disables all animations within Finder to potentially speed up the interface
# Enable debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true  # Unlocks additional options in Disk Utility for advanced users

# Expand save and print panels by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true  # Always shows the expanded save panel
defaults write -g PMPrintingExpandedStateForPrint -bool true  # Always shows the expanded print dialog

# Disable automatic termination of idle apps
defaults write -g NSDisableAutomaticTermination -bool true  # Prevents macOS from automatically closing applications that are not actively being used

# Show additional system info at the login screen
defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName  # Displays the IP address and hostname on the login screen

# Add a spacer to the Dock
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}' && killall Dock  # Adds a draggable space in the Dock, useful for organizing apps

# Enable the developer mode for Dashboard widgets
defaults write com.apple.dashboard devmode -bool true  # Allows you to drag Dashboard widgets onto the desktop

# Use verbose boot mode (shows detailed status information while booting)
sudo nvram boot-args="-v"  # Enables verbose mode for system startup, useful for troubleshooting boot issues
