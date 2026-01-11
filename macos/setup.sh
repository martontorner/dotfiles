#!/usr/bin/env sh

# Special thanks to the original source of this script:
# https://mths.be/macos
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript << EOF
tell application "System Preferences" to quit
EOF

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

mkdir -p "${HOME}/data" "${HOME}/git" "${HOME}/tmp" "${HOME}/Documents/actual" "${HOME}/Documents/screenshots"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set the timezone; see `sudo systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "Europe/Budapest" > /dev/null

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

################################################################################
# Language, Localization and Input                                             #
################################################################################

# Set language and text formats
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, `en_GB` with `en_US`, and `true` with `false`.
defaults write NSGlobalDomain AppleLanguages -array "en-US" "hu-HU"
defaults write NSGlobalDomain AppleLocale -string "en_US@rg=huzzzz"
defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
defaults write NSGlobalDomain AppleMetricUnits -bool true

# Set the keyboard layouts
defaults write com.apple.HIToolbox AppleEnabledInputSources -array \
  '<dict>
     <key>InputSourceKind</key><string>Keyboard Layout</string>
     <key>KeyboardLayout ID</key><integer>30767</integer>
     <key>KeyboardLayout Name</key><string>Hungarian-QWERTY</string>
   </dict>' \
  '<dict>
     <key>InputSourceKind</key><string>Keyboard Layout</string>
     <key>KeyboardLayout ID</key><integer>252</integer>
     <key>KeyboardLayout Name</key><string>ABC</string>
   </dict>' \
  '<dict>
     <key>InputSourceKind</key><string>Non Keyboard Input Method</string>
     <key>Bundle ID</key><string>com.apple.CharacterPaletteIM</string>
   </dict>' \
  '<dict>
     <key>InputSourceKind</key><string>Non Keyboard Input Method</string>
     <key>Bundle ID</key><string>com.apple.PressAndHold</string>
   </dict>'

################################################################################
# General UI/UX                                                                #
################################################################################

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

################################################################################
# Screen                                                                       #
################################################################################

# Save screenshots to a dedicated folder
defaults write com.apple.screencapture location -string "${HOME}/Documents/screenshots"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

################################################################################
# Finder                                                                       #
################################################################################

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Documents/"

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "icnv"

# Show the ~/Library folder
chflags nohidden ~/Library && xattr -d com.apple.FinderInfo ~/Library

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

################################################################################
# Dock, Dashboard, and hot corners                                             #
################################################################################

# Set the icon size of Dock items (normal size and magnified size) and allow magnification
defaults write com.apple.dock tilesize -int 32
defaults write com.apple.dock largesize -int 64
defaults write com.apple.dock magnification -int 1

# Set Dock orientation to left
defaults write com.apple.dock orientation -string "left"

# Clear dock of all default app icons
# defaults write com.apple.dock persistent-apps -array
# defaults write com.apple.dock recent-apps -array
# defaults write com.apple.dock persistent-others -array

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen
# Top left screen corner
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0
# Top right screen corner
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
# Bottom left screen corner
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0
# Bottom right screen corner
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0

################################################################################
# Safari & WebKit                                                              #
################################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Set Safari’s home page to ``
defaults write com.apple.Safari HomePage -string ""

# Prevent Safari from opening previous windows/tabs at launch
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool false

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool true
defaults write com.apple.Safari AutoFillPasswords -bool true
defaults write com.apple.Safari AutoFillCreditCardData -bool true
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari "ShowFavoritesBar-v2" -bool false

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

defaults write com.apple.Safari ShowSidebarInNewWindows -bool false
defaults write com.apple.Safari ShowFrequentlyVisitedSites -bool false
defaults write com.apple.Safari ShowOverlayStatusBar -bool true
defaults write com.apple.Safari ShowTabGroupFavoritesPreferenceKey -bool false
defaults write com.apple.Safari ShowRecentlyClosedTabsPreferenceKey -bool false
defaults write com.apple.Safari ShowSiriSuggestionsPreference -bool false

defaults write com.apple.Safari ShowBackgroundImageInFavorites -bool false
defaults write com.apple.Safari ShowCloudTabsInFavorites -bool false
defaults write com.apple.Safari ShowHighlightsInFavorites -bool false
defaults write com.apple.Safari ShowPrivacyReportInFavorites -bool false

# Open pages in tabs instead of windows - always
defaults write com.apple.Safari TabCreationPolicy -integer 2

# Always show website titles in tabs
defaults write com.apple.Safari EnableNarrowTabs -integer 0

################################################################################
# Mail                                                                         #
################################################################################

# Disable send and reply animations in Mail.app
# defaults write com.apple.mail DisableReplyAnimations -bool true
# defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "no"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

################################################################################
# Terminal & iTerm 2                                                           #
################################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal AutoMarkPromptLines -int 0


# Use a modified version of the Solarized Dark theme by default in Terminal.app
osascript << EOF
tell application "Terminal"

	local allOpenedWindows
	local initialOpenedWindows
	local windowID
	set themeName to "GitHub Dark Dimmed"

	(* Store the IDs of all the open terminal windows. *)
	set initialOpenedWindows to id of every window

	(* Open the custom theme so that it gets added to the list
	   of available terminal themes (note: this will open two
	   additional terminal windows). *)
	do shell script "open '$DOTFILES/terminal/" & themeName & ".terminal'"

	(* Wait a little bit to ensure that the custom theme is added. *)
	delay 1

	(* Set the custom theme as the default terminal theme. *)
	set default settings to settings set themeName

	(* Get the IDs of all the currently opened terminal windows. *)
	set allOpenedWindows to id of every window

	repeat with windowID in allOpenedWindows

		(* Close the additional windows that were opened in order
		   to add the custom theme to the list of terminal themes. *)
		if initialOpenedWindows does not contain windowID then
			close (every window whose id is windowID)

		(* Change the theme for the initial opened terminal windows
		   to remove the need to close them in order for the custom
		   theme to be applied. *)
		else
			set current settings of tabs of (every window whose id is windowID) to settings set themeName
		end if

	end repeat

end tell
EOF

################################################################################
# Activity Monitor                                                             #
################################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

################################################################################
# TextEdit                                                                     #
################################################################################

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

################################################################################
# Desktop                                                                      #
################################################################################

# Set desktop background to a solid gray color
osascript << EOF
tell application "Finder"
  set desktop picture to POSIX file "${DOTFILES}/macos/bg.png"
end tell
EOF

################################################################################
# Kill affected applications                                                   #
################################################################################

for app in "Activity Monitor" \
	"Address Book" \
	"Calendar" \
	"cfprefsd" \
	"Contacts" \
	"Dock" \
	"Finder" \
	"Google Chrome" \
	"Mail" \
	"Messages" \
	"Photos" \
	"Safari" \
	"SystemUIServer" \
	"Terminal"; do
	killall "${app}" &> /dev/null
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
