tell application "System Events"
	if not autohide menu bar of dock preferences then
		set autohide menu bar of dock preferences to true
	else
		set autohide menu bar of dock preferences to false
	end if
end tell
