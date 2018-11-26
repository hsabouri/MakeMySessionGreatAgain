# Good read: https://github.com/pawelgrzybek/dotfiles/blob/master/setup-macos.sh
# Good read: https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/

# Github: https://github.com/hsabouri/MakeMySessionGrateAgain

wallpaper=\"/Users/${USER}/Documents/sombrero-galaxy.jpg\"

ask_password=true

dock_size=63
dock_magnification=true
dock_magnification_amount=35
# iTerm is already set !
dock_apps=("/Applications/System Preferences.app/" "/Applications/Visual Studio Code.app/" "/Users/"$USER"/Applications/Spotify.app/" "/Applications/Brave.app/" "/Applications/Managed Software Center.app/")

# Change wallpaper
osascript -e 'tell application "Finder" to set desktop picture to POSIX file '${wallpaper}

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -string YES

# Add mouse right-click
defaults write com.apple.driver.AppleHIDMouse Button2 -int 2 && defaults write com.apple.driver.AppleHIDMouse ButtonDominance -int 1

# Keyboard repeat speed and delay
defaults write -g KeyRepeat -int 2 && defaults write -g InitialKeyRepeat -int 15

# Require password
defaults write com.apple.screensaver askForPassword -bool $ask_password

# Dock size
defaults write com.apple.dock largesize -int $dock_size

# Dock Magnification
defaults write com.apple.dock magnification -bool $dock_magnification
defaults write com.apple.dock tilesize -int $dock_magnification_amount

# Dark style
defaults write -globalDomain AppleInterfaceStyle -string Dark

# Dock icons
 # iTerm
defaults write com.apple.dock persistent-apps -array "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
 # other apps
for app in $dock_apps; do
	defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>"$app"</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
done

for app in "Dock" "Finder"; do
  killall "${app}" > /dev/null 2>&1
done

# Done
echo "Log out for all changes to take effect"
echo "Don't forget to follow me on github !"
osascript -e 'tell app "System Events" to log out'
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome https://github.com/hsabouri &
