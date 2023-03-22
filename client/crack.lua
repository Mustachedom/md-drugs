local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-drugs:client:makecrackone")
AddEventHandler("md-drugs:client:makecrackone", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
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
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failcrackone")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)

RegisterNetEvent("md-drugs:client:makecracktwo")
AddEventHandler("md-drugs:client:makecracktwo", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Cooking Crack", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makecracktwo")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failcracktwo")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)

RegisterNetEvent("md-drugs:client:makecrackthree")
AddEventHandler("md-drugs:client:makecrackthree", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Cooking Crack", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makecrackthree")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failcrackthree")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)

RegisterNetEvent("md-drugs:client:bagcrack")
AddEventHandler("md-drugs:client:bagcrack", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "bagging some good good", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:bagcrack")
        Citizen.Wait(4000)
    
        ClearPedTasks(PlayerPedId())
    end)
end)

