local QBCore = exports['qb-core']:GetCoreObject()
local CocaPlant = {}
local PoppyPlants = {}

function LoadModel(hash)
    hash = GetHashKey(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(3000)
    end
end 



RegisterNetEvent('heroin:respawnCane', function(loc)
    local v = GlobalState.PoppyPlants[loc]
    local hash = GetHashKey(v.model)
    --if not HasModelLoaded(hash) then LoadModel(hash) end
    if not PoppyPlants[loc] then
        PoppyPlants[loc] = CreateObject(hash, v.location, false, true, true)
        SetEntityAsMissionEntity(PoppyPlants[loc], true, true)
        FreezeEntityPosition(PoppyPlants[loc], true)
        SetEntityHeading(PoppyPlants[loc], v.heading)
        exports['qb-target']:AddTargetEntity(PoppyPlants[loc], {
            options = { {
                    icon = "fas fa-hand",
                    label = "pick Poppies",
                    action = function()
                        QBCore.Functions.Progressbar("pick_cane", "picking heroin", 2000, false, true, {
                            disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                            { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                            {}, {}, function()
                            TriggerServerEvent("heroin:pickupCane", loc)
                            ClearPedTasks(PlayerPedId())
                        end, function() -- Cancel
                            ClearPedTasks(PlayerPedId())
                        end)
                    end
                }
            },
            distance = 3.0
        })
    end
end)



RegisterNetEvent('heroin:removeCane', function(loc)
    if DoesEntityExist(PoppyPlants[loc]) then DeleteEntity(PoppyPlants[loc]) end
    PoppyPlants[loc] = nil
end)



RegisterNetEvent("heroin:init", function()
    for k, v in pairs (GlobalState.PoppyPlants) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            PoppyPlants[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            SetEntityAsMissionEntity(PoppyPlants[k], true, true)
            FreezeEntityPosition(PoppyPlants[k], true)
            SetEntityHeading(PoppyPlants[k], v.heading)
            exports['qb-target']:AddTargetEntity(PoppyPlants[k], {
                options = { {
                        icon = "fas fa-hand",
                        label = "Pick Poppies",
                        action = function()
                            QBCore.Functions.Progressbar("pick_cane", "Picking Heroin", 2000, false, true, {
                                disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                                { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                                {}, {}, function()
                                TriggerServerEvent("heroin:pickupCane", k)
                                ClearPedTasks(PlayerPedId())
                            end, function() -- Cancel
                                ClearPedTasks(PlayerPedId())
                            end)
                        end
                    }
                },
                distance = 3.0
            })
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        LoadModel('prop_plant_01b')
        TriggerEvent('heroin:init')
    end
 end)
 
 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('prop_plant_01b')
     TriggerEvent('heroin:init')
 end)
 
 AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('prop_plant_01b'))
        for k, v in pairs(PoppyPlants) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)

RegisterNetEvent("md-drugs:client:dryplant")
AddEventHandler("md-drugs:client:dryplant", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "drying out these poppies!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:dryplant")
        Citizen.Wait(4000)
    
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:cutheroin")
AddEventHandler("md-drugs:client:cutheroin", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "cutting the heroin!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:cutheroin")
        Citizen.Wait(4000)
    
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:cutherointwo")
AddEventHandler("md-drugs:client:cutherointwo", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "cutting the heroin!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:cutherointwo")
        Citizen.Wait(4000)
    
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:cutherointhree")
AddEventHandler("md-drugs:client:cutherointhree", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "cutting the heroin!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:cutherointhree")
        Citizen.Wait(4000)
    
        ClearPedTasks(PlayerPedId())
    end)
end)


RegisterNetEvent("md-drugs:client:buyheroinlabkit")
AddEventHandler("md-drugs:client:buyheroinlabkit", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Shhhhh!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:getheroinlabkit")
        Citizen.Wait(4000)
    
        ClearPedTasks(PlayerPedId())
    end)
end)


RegisterNetEvent("md-drugs:client:heatliquidheroin")
AddEventHandler("md-drugs:client:heatliquidheroin", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Heating Heroin!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:heatliquidheroin")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failheatingheroin")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, 
    end)
end)

RegisterNetEvent("md-drugs:client:fillneedle")
AddEventHandler("md-drugs:client:fillneedle", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Filling Needles!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:fillneedle")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failheroin")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, 
    end)
end)


