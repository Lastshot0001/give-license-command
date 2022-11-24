RegisterCommand('grantlicense', function(source, args, showError)
	local playerId = source
    local targetPlayer = (args[1] and tonumber(args[1]) or false)
    local licenseType = args[2]
	local xPlayer = ESX.GetPlayerFromId(playerId)
	local isPolice = (xPlayer and xPlayer.job.name == 'police' or false)
	if not isPolice then
		TriggerClientEvent("esx:showNotification", source, "You are not a police officer")
		return
	end
	if not targetPlayer or not licenseType then
		TriggerClientEvent("esx:showNotification", source, "You need to specify a player and a license")
		return
	end
	local tPlayer = ESX.GetPlayerFromId(targetPlayer)
	if not tPlayer then
		TriggerClientEvent("esx:showNotification", source, "Player is not online")
		return
	end
	TriggerEvent('esx_license:getLicensesList', function(licenses)
		local license;
		for i=1, #licenses, 1 do
			if licenses[i].type == licenseType then
				license = licenses[i]
				break
			end
		end

		if not license then
			TriggerClientEvent("esx:showNotification", source, "License does not exist")
			return
		end
		
		TriggerEvent('esx_license:checkLicense', tPlayer.source, licenseType, function(isExist)
			if isExist then
				TriggerClientEvent("esx:showNotification", source, "Player already has this license")
				return
			end
			TriggerEvent('esx_license:addLicense', tPlayer.source, licenseType)
			TriggerClientEvent("esx:showNotification", source, "You gave "..license.label.." to "..tPlayer.name)
			TriggerClientEvent("esx:showNotification", tPlayer.source, "You got "..license.label.." from "..xPlayer.name)
		end)
	end)
end)