local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-drugs:client:makecrackone", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Cooking Crack", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makecrackone")       
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failcrackone")
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)


RegisterNetEvent("md-drugs:client:bagcrack", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "bagging some good good", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:bagcrack")
        ClearPedTasks(PlayerPedId())
    end)
end)

