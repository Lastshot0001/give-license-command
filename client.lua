-- add chat suggestion
TriggerEvent('chat:addSuggestion', '/grantlicense', 'Grant a license to a player', {
	{ name="id", help="Player ID" },
	{ name="license", help="License type" }
})