global frontApp, frontAppName

tell application "System Events"
	set frontApp to first application process whose frontmost is true
	set frontAppName to name of frontApp
end tell

tell application "Slack" to activate

tell application "System Events"
	keystroke "A" using command down
end tell

tell application frontAppName to activate
