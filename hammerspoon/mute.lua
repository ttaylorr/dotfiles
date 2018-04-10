prefix.bind('', 'm', function()
  hs.osascript.applescript([[
    tell application "System Events"
      tell process "FaceTime"
        set frontmost to true
        click menu item "Mute" of menu "Video" of menu bar 1
      end tell
    end tell
  ]])
end)
