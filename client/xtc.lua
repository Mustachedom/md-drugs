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
RegisterNetEvent("md-drugs:client:stampwhite")
AddEventHandler("md-drugs:client:stampwhite", function() 
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
        TriggerServerEvent("md-drugs:server:stampwhite")
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

RegisterNetEvent("md-drugs:client:stampred")
AddEventHandler("md-drugs:client:stampred", function() 
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
        TriggerServerEvent("md-drugs:server:stampred")
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

RegisterNetEvent("md-drugs:client:stamporange")
AddEventHandler("md-drugs:client:stamporange", function() 
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
        TriggerServerEvent("md-drugs:server:stamporange")
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

RegisterNetEvent("md-drugs:client:stampblue")
AddEventHandler("md-drugs:client:stampblue", function() 
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
        TriggerServerEvent("md-drugs:server:stampblue")
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

RegisterNetEvent("md-drugs:client:buypress")
AddEventHandler("md-drugs:client:buypress", function() 
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
        TriggerServerEvent("md-drugs:server:buypress")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
		end)
end)

CreateThread(function()
exports['qb-target']:AddBoxZone("stealisosafrole2",Config.isosafrole,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "stealisosafrole2",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.isosafrole-2,
	maxZ = Config.isosafrole+2,
}, {
	options = {
	   { 
		type = "client",
		event = "md-drugs:client:stealisosafrole",
		icon = 'fas fa-sign-in-alt',
		label = 'Steal Isosafrole',   
		},
	},
	distance = 2.5
 })
  exports['qb-target']:AddBoxZone("stealmdp2p",Config.mdp2p,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "stealmdp2p",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.mdp2p-2,
	maxZ = Config.mdp2p+2,
}, {
	options = {
	  { 
      type = "client",
      event = "md-drugs:client:stealmdp2p",
      icon = 'fas fa-eye',
      label = 'Steal mdp2p',  
	  },
	},
	distance = 2.5
 })
   exports['qb-target']:AddBoxZone("makerawxtc",Config.rawxtcloc,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "makerawxtc",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.rawxtcloc-2,
	maxZ = Config.rawxtcloc+2,
}, {
	options = {
		{ 
		type = "client",
		event = "md-drugs:client:makingrawxtc",
		icon = 'fas fa-eye',
		label = 'Make Raw XTC', 
		},
	},
	distance = 2.5
 })
 exports['qb-target']:AddBoxZone("buypress",Config.buypress,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "buypress",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.buypress-2,
	maxZ = Config.buypress+2,
}, {
	options = {
	   { 
      type = "client",
      event = "md-drugs:client:buypress",
      icon = 'fas fa-eye',
      label = 'Buy Press',  
		},
	},
	distance = 2.5
 })
  exports['qb-target']:AddBoxZone("makeunstampedwhite1",Config.makeunstampedwhite,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "makeunstampedwhite1",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.makeunstampedwhite-2,
	maxZ = Config.makeunstampedwhite+2,
}, {
	options = {
	{
      type = "client",
      event = "md-drugs:client:makextcsingle",
      icon = 'fas fa-eye',
      label = 'Make White Single Stack', 
	  item = "singlepress", 
    },
	{ 
	  
      type = "client",
      event = "md-drugs:client:makextcdual",
      icon = 'fas fa-eye',
      label = 'Make White dual Stack', 
	  item = "dualpress",
    },
	{ 
	  
      type = "client",
      event = "md-drugs:client:makextctriple",
      icon = 'fas fa-eye',
      label = 'Make White Triple Stack', 
	  item = "triplepress",
    },
	{ 
      type = "client",
      event = "md-drugs:client:makextcquad",
      icon = 'fas fa-eye',
      label = 'Make White Quad Stack', 
	  item = "quadpress",
    },
  },
	distance = 2.5
 })
   exports['qb-target']:AddBoxZone("makeunstampedred1",Config.makeunstampedred,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "makeunstampedred1",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.makeunstampedred-2,
	maxZ = Config.makeunstampedred+2,
}, {
options = {
	{
      type = "client",
      event = "md-drugs:client:makeredxtcsingle",
      icon = 'fas fa-eye',
      label = 'Make Red Single Stack', 
	  item = "singlepress", 
    },
	{ 
      type = "client",
      event = "md-drugs:client:makeredxtcdual",
      icon = 'fas fa-eye',
      label = 'Make Red dual Stack', 
	  item = "dualpress",
    },
	{ 
      type = "client",
      event = "md-drugs:client:makeredxtctriple",
      icon = 'fas fa-eye',
      label = 'Make Red Triple Stack', 
	  item = "triplepress",
    },
	{ 
      type = "client",
      event = "md-drugs:client:makeredxtcquad",
      icon = 'fas fa-eye',
      label = 'Make Red Quad Stack', 
	  item = "quadpress",
    },
  },
	distance = 2.5
 })
    exports['qb-target']:AddBoxZone("makeunstampedorange1",Config.makeunstampedorange,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "makeunstampedorange1",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.makeunstampedorange-2,
	maxZ = Config.makeunstampedorange+2,
}, {
options = {
	{ 
      type = "client",
      event = "md-drugs:client:makeorangextcsingle",
      icon = 'fas fa-eye',
      label = 'Make orange Single Stack', 
	  item = "singlepress", 
    },
	{ 
      type = "client",
      event = "md-drugs:client:makeorangextcdual",
      icon = 'fas fa-eye',
      label = 'Make orange dual Stack', 
	  item = "dualpress",
    },
	{ 
      type = "client",
      event = "md-drugs:client:makeorangextctriple",
      icon = 'fas fa-eye',
      label = 'Make orange Triple Stack', 
	  item = "triplepress",
    },
	{ 
	  
      type = "client",
      event = "md-drugs:client:makeorangextcquad",
      icon = 'fas fa-eye',
      label = 'Make orange Quad Stack', 
	  item = "quadpress",
    },
  },
	distance = 2.5
 })
     exports['qb-target']:AddBoxZone("makeunstampedblue1",Config.makeunstampedblue,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "makeunstampedblue1",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.makeunstampedblue-2,
	maxZ = Config.makeunstampedblue+2,
}, {
options = {
	{ 
      type = "client",
      event = "md-drugs:client:makebluextcsingle",
      icon = 'fas fa-eye',
      label = 'Make blue Single Stack', 
	  item = "singlepress", 
    },
	{ 
      type = "client",
      event = "md-drugs:client:makebluextcdual",
      icon = 'fas fa-eye',
      label = 'Make blue dual Stack', 
	  item = "dualpress",
    },
	{ 
      type = "client",
      event = "md-drugs:client:makebluextctriple",
      icon = 'fas fa-eye',
      label = 'Make blue Triple Stack', 
	  item = "triplepress",
    },
	{ 
      type = "client",
      event = "md-drugs:client:makebluextcquad",
      icon = 'fas fa-eye',
      label = 'Make blue Quad Stack', 
	  item = "quadpress",
    },
  },
	distance = 2.5
 })
      exports['qb-target']:AddBoxZone("stampwhite",Config.stamp,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "stampwhite",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.stamp-2,
	maxZ = Config.stamp+2,
}, {
options = {
	{ 
      type = "client",
      event = "md-drugs:client:stampwhite",
      icon = 'fas fa-eye',
      label = 'Make White Stamped Pills', 
    },
	{ 
      type = "client",
      event = "md-drugs:client:stampred",
      icon = 'fas fa-eye',
      label = 'Make Red Stamped Pills', 
    },
	{ 
      type = "client",
      event = "md-drugs:client:stamporange",
      icon = 'fas fa-eye',
      label = 'Make Orange Stamped Pills', 
    },
	{ 
      type = "client",
      event = "md-drugs:client:stampblue",
      icon = 'fas fa-eye',
      label = 'Make Blue Stamped Pills', 
    },
  },
	distance = 2.5
 })
 
 end)
 
