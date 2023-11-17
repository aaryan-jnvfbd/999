#configure.sh

# Disable spotlight indexing
sudo mdutil -i off -a

# Create new account
sudo dscl . -create /Users/rhsalisu
sudo dscl . -create /Users/rhsalisu UserShell /bin/bash
sudo dscl . -create /Users/rhsalisu RealName "Rabiu Hadi Salisu"
sudo dscl . -create /Users/rhsalisu UniqueID 1001
sudo dscl . -create /Users/rhsalisu PrimaryGroupID 80
sudo dscl . -create /Users/rhsalisu NFSHomeDirectory /Users/rhsalisu
sudo dscl . -passwd /Users/rhsalisu Rabiu2004@
sudo dscl . -passwd /Users/rhsalisu Rabiu2004@
sudo createhomedir -c -u rhsalisu > /dev/null

# Enable VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 

# VNC password - http://hints.macworld.com/article.php?story=20071103011608872
echo rhsalisu | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt

# Start VNC/reset changes
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

# Install ngrok
brew install --cask ngrok

# Configure ngrok and start it
ngrok authtoken 2Hd7yeF4INCKbg2aP9rGMLnDqBX_5K7WhATjW8eUxS6UoHSRa
ngrok tcp 5900 &
