local QBCore = exports['qb-core']:GetCoreObject()
local CocaPlant = {}
local cuttingcoke = nil
local baggingcoke = nil
function LoadModel(hash)
    hash = GetHashKey(hash)
    lib.requestModel(hash, 500)
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
    TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
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
	cuttingcoke = true
	CutCoke()
	TriggerServerEvent("md-drugs:server:cutcokeone")
    ClearPedTasks(PlayerPedId())
	cuttingcoke = nil
   
end)

RegisterNetEvent("md-drugs:client:bagcoke")
AddEventHandler("md-drugs:client:bagcoke", function() 
	baggingcoke = true
	BagCoke()
	TriggerServerEvent("md-drugs:server:bagcoke")
    ClearPedTasks(PlayerPedId())
	baggingcoke = nil
   
end)

CreateThread(function()
    local cut = vector3(1093.01, -3194.8, -39.99)
    local bagg = vector3(1090.70, -3195.91, -39.99)
    exports['qb-target']:AddBoxZone("cutcokepowder",vector3(cut.x, cut.y, cut.z),1.5, 1.75, { -- 963.37, -2122.95, 31.47
        name = "cutcokepowder",
        heading = 11.0,
        debugPoly = true,
        minZ = cut.z-1,
        maxZ = cut.z+1,
    }, {
        options = {
            {
                type = "client",
                event = "md-drugs:client:cutcokeone",
                icon = "fas fa-sign-in-alt",
                label = "cut up",
                canInteract = function()
                    if cuttingcoke == nil and baggingcoke == nil then return true end
                end            
            },
        },
        distance = 2.5
    })
    exports['qb-target']:AddBoxZone("bagcokepowder",vector3(bagg.x, bagg.y, bagg.z),1.5, 1.75, { -- 963.37, -2122.95, 31.47
        name = "bagcokepowder",
        heading = 11.0,
        debugPoly = true,
        minZ = bagg.z-1,
        maxZ = bagg.z+1,
    }, {
        options = {
            {
                type = "client",
                event = "md-drugs:client:bagcoke",
                icon = "fas fa-sign-in-alt",
                label = "bagging",
                canInteract = function()
                    if baggingcoke == nil and cuttingcoke == nil then return true end
                end
            },
        },
        distance = 2.5
    })
end)
