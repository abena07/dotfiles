#!/bin/bash

# macos settings. safe to run more than once, defaults write just sets the same value again

set -e

if [ "$(uname)" != "Darwin" ]; then
    echo "not a mac, skipping macos settings"
    exit 0
fi

echo "applying macos settings"

# screenshots go to the clipboard, not the desktop
defaults write com.apple.screencapture target -string clipboard

# hide all desktop icons
defaults write com.apple.finder CreateDesktop -bool false

# don't show external disks or removable media (like mounted dmgs) on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# restart finder and systemuiserver so the changes kick in
killall Finder >/dev/null 2>&1 || true
killall SystemUIServer >/dev/null 2>&1 || true

echo "macos settings done"
