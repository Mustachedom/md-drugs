local QBCore = exports['qb-core']:GetCoreObject()
local CocaPlant = {}

function LoadModel(hash)
    hash = GetHashKey(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(3000)
    end
end 

RegisterNetEvent('coke:respawnCane', function(loc)
    local v = GlobalState.CocaPlant[loc]
    local hash = GetHashKey(v.model)
    --if not HasModelLoaded(hash) then LoadModel(hash) end
    if not CocaPlant[loc] then
        CocaPlant[loc] = CreateObject(hash, v.location, false, true, true)
        SetEntityAsMissionEntity(CocaPlant[loc], true, true)
        FreezeEntityPosition(CocaPlant[loc], true)
        SetEntityHeading(CocaPlant[loc], v.heading)
        exports['qb-target']:AddTargetEntity(CocaPlant[loc], {
            options = { {
                    icon = "fas fa-hand",
                    label = "pick Cocaine",
                    action = function()
                        QBCore.Functions.Progressbar("pick_cane", "picking Cocaine Leaves", 2000, false, true, {
                            disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                            { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                            {}, {}, function()
                            TriggerServerEvent("coke:pickupCane", loc)
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

RegisterNetEvent('coke:removeCane', function(loc)
    if DoesEntityExist(CocaPlant[loc]) then DeleteEntity(CocaPlant[loc]) end
    CocaPlant[loc] = nil
end)

RegisterNetEvent("coke:init", function()
    for k, v in pairs (GlobalState.CocaPlant) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            CocaPlant[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            SetEntityAsMissionEntity(CocaPlant[k], true, true)
            FreezeEntityPosition(CocaPlant[k], true)
            SetEntityHeading(CocaPlant[k], v.heading)
            exports['qb-target']:AddTargetEntity(CocaPlant[k], {
                options = { {
                        icon = "fas fa-hand",
                        label = "pick cocaine",
                        action = function()
                            QBCore.Functions.Progressbar("pick_cane", "picking Cocaine Leaves", 2000, false, true, {
                                disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                                { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                                {}, {}, function()
                                TriggerServerEvent("coke:pickupCane", k)
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
        LoadModel('prop_plant_01a')
        TriggerEvent('coke:init')
    end
 end)
 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('prop_plant_01a')
     TriggerEvent('coke:init')
 end)
 
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('prop_plant_01a'))
        for k, v in pairs(CocaPlant) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)

RegisterNetEvent("md-drugs:client:makepowder")
AddEventHandler("md-drugs:client:makepowder", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "chopping plants to powder", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:makepowder")
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:cutcokeone")
AddEventHandler("md-drugs:client:cutcokeone", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "cutting coke to increase profits yeeee!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:cutcokeone")
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:bagcoke")
AddEventHandler("md-drugs:client:bagcoke", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Bilbo Baggin this bitch!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:bagcoke")
        ClearPedTasks(PlayerPedId())
    end)
end)