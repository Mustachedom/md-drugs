local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent("md-drugs:client:stealisosafrole")
AddEventHandler("md-drugs:client:stealisosafrole", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Stealing Isosafrole", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:stealisosafrole")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:stealmdp2p")
AddEventHandler("md-drugs:client:stealmdp2p", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Stealing MDP2P", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:stealmdp2p")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makingrawxtc")
AddEventHandler("md-drugs:client:makingrawxtc", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Raw Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makingrawxtc")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
---------------------------- unstamped just xtc
RegisterNetEvent("md-drugs:client:makextcsingle")
AddEventHandler("md-drugs:client:makextcsingle", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Single Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makextcsingle")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 4, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makextcdual")
AddEventHandler("md-drugs:client:makextcdual", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Dual Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makextcdual")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makextctriple")
AddEventHandler("md-drugs:client:makextctriple", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Triple Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makextctriple")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makextcquad")
AddEventHandler("md-drugs:client:makextcquad", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Quad Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makextcquad")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
------------------------------------------------- 
RegisterNetEvent("md-drugs:client:makeredxtcsingle")
AddEventHandler("md-drugs:client:makeredxtcsingle", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Red Single Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeredxtcsingle")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 4, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeredxtcdual")
AddEventHandler("md-drugs:client:makeredxtcdual", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Red Dual Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeredxtcdual")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeredxtctriple")
AddEventHandler("md-drugs:client:makeredxtctriple", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Red Triple Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeredxtctriple")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeredxtcquad")
AddEventHandler("md-drugs:client:makeredxtcquad", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Red Quad Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeredxtcquad")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
--------------------------------------------------------------- making orange unstamped
RegisterNetEvent("md-drugs:client:makeorangextcsingle")
AddEventHandler("md-drugs:client:makeorangextcsingle", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Single Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeorangextcsingle")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 4, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeorangextcdual")
AddEventHandler("md-drugs:client:makeorangextcdual", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Dual Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeorangextcdual")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeorangextctriple")
AddEventHandler("md-drugs:client:makeorangextctriple", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Triple Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeorangextctriple")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeorangextcquad")
AddEventHandler("md-drugs:client:makeorangextcquad", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Quad Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeorangextcquad")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
--------------------------------------- blue unstamped
RegisterNetEvent("md-drugs:client:makebluextcsingle")
AddEventHandler("md-drugs:client:makebluextcsingle", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Single Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makebluextcsingle")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 4, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makebluextcdual")
AddEventHandler("md-drugs:client:makebluextcdual", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Blue Dual Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makebluextcdual")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makebluextctriple")
AddEventHandler("md-drugs:client:makebluextctriple", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Blue Triple Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makebluextctriple")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makebluextcquad")
AddEventHandler("md-drugs:client:makebluextcquad", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Blue Quad Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makebluextcquad")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
------------------------------------------------------------------ Stamping
RegisterNetEvent("md-drugs:client:stamppills")
AddEventHandler("md-drugs:client:stamppills", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Making Stamped Pills", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:stamppills")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

