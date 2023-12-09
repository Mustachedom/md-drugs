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

local function loadParticle(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
    end
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
    end
    SetPtfxAssetNextCall(dict)
end

CreateThread(function() 
local Ped = "g_m_y_famdnf_01"
	lib.requestModel("g_m_y_famdnf_01", 500)
	labkitlocation = Config.buyheroinlabkit
	heroinkitdealer = CreatePed(0, Ped,labkitlocation.x, labkitlocation.y, labkitlocation.z-1, 180.0, false, false)
    FreezeEntityPosition(heroinkitdealer, true)
    SetEntityInvincible(heroinkitdealer, true)
	exports['qb-target']:AddTargetEntity(heroinkitdealer, {
           options = {
               {
                   type = "client",
                   label = "Buy Heroin Lab Kit",
                   icon = "fas fa-eye",
                   event = "md-drugs:client:buyheroinlabkit"
               },
           }
          
	})
end)

---- plant spawns dont edit
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
                            ClearPedTasks(cache.ped)
                        end, function() -- Cancel
                            ClearPedTasks(cache.ped)
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
                                ClearPedTasks(cache.ped)
                            end, function() -- Cancel
                                ClearPedTasks(cache.ped)
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
	DeleteObject(heroinlabkit)
	DeleteObject(dirtylabkitheroin)
end)
---- plant stop end

RegisterNetEvent("md-drugs:client:dryplant", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "drying out these poppies!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:dryplant")
        ClearPedTasks(cache.ped)
    end)
end)

RegisterNetEvent("md-drugs:client:cutheroin", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "cutting the heroin!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:cutheroin")
        ClearPedTasks(cache.ped)
    end)
end)

RegisterNetEvent("md-drugs:client:buyheroinlabkit", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Shhhhh!", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:getheroinlabkit")
        ClearPedTasks(cache.ped)
    end)
end)

RegisterNetEvent("md-drugs:client:setheroinlabkit", function() 
local PedCoords = GetEntityCoords(cache.ped)
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
	ClearPedTasks(cache.ped)
	heroinlabkit = CreateObject("v_ret_ml_tablea", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
	SetVehicleOnGroundProperly(heroinlabkit)
	exports['qb-target']:AddTargetEntity(heroinlabkit, {
    options = {
        {
         
            event = "md-drugs:client:heatliquidheroin",
            icon = "fas fa-box-circle-check",
            label = "Cook Heroin",
        },
		{
         
            event = "md-drugs:client:getheroinkitback",
            icon = "fas fa-box-circle-check",
            label = "Pick Up",
        },
    }
   })
end)

RegisterNetEvent("md-drugs:client:heatliquidheroin", function() 
local PedCoords = GetEntityCoords(cache.ped)
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:heatliquidheroin")
        ClearPedTasks(cache.ped)
	else
		TriggerServerEvent("md-drugs:server:failheatingheroin")
        ClearPedTasks(cache.ped)
		DeleteObject(heroinlabkit)
		Wait(100)
		dirtylabkitheroin = CreateObject("v_ret_ml_tablea", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
		loadParticle("core")
	    heroinkit = StartParticleFxLoopedOnEntity("exp_air_molotov", dirtylabkitheroin, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
        SetParticleFxLoopedAlpha(heroinkit, 3.0)
		 ClearPedTasks(cache.ped)
		 SetPedToRagdoll(cache.ped, 1300, 1300, 0, 0, 0, 0)
		 
		exports['qb-target']:AddTargetEntity(dirtylabkitheroin, {
		 options = {
        {
         
            event = "md-drugs:client:cleanheroinlabkit",
            icon = "fas fa-box-circle-check",
            label = "Clean It",
        }
    }
	})
	end
end, 1, 8) -- NumberOfCircles, MS
end)


RegisterNetEvent("md-drugs:client:cleanheroinlabkit", function() 
    exports["rpemotes"]:EmoteCommandStart("clean", 0)
    QBCore.Functions.Progressbar("drink_something", "Cleaning", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
		TriggerServerEvent("md-drugs:server:removecleaningkitheroin")
		 ClearPedTasks(cache.ped)
	end)
end)

RegisterNetEvent("md-drugs:client:deletedirtyheroin", function() 
DeleteObject(dirtylabkitheroin)
Wait(1000)
TriggerEvent("md-drugs:client:setheroinlabkit")
end)


RegisterNetEvent("md-drugs:client:getheroinkitback", function() 
DeleteObject(heroinlabkit)
TriggerServerEvent("md-drugs:server:getheroinlabkitback")
ClearPedTasks(cache.ped)
end)

RegisterNetEvent("md-drugs:client:fillneedle", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
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
        ClearPedTasks(cache.ped)
	else
		TriggerServerEvent("md-drugs:server:failheroin")
        ClearPedTasks(cache.ped)
	end
end, 2, 8) -- NumberOfCircles, 
    end)
end)


