local QBCore = exports['qb-core']:GetCoreObject()
local Mescaline = {}
local hallucinate = nil

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


---- plant spawns dont edit
RegisterNetEvent('Mescaline:respawnCane', function(loc)
    local v = GlobalState.Mescaline[loc]
    local hash = GetHashKey(v.model)
    --if not HasModelLoaded(hash) then LoadModel(hash) end
    if not Mescaline[loc] then
        Mescaline[loc] = CreateObject(hash, v.location, false, true, true)
        SetEntityAsMissionEntity(Mescaline[loc], true, true)
        FreezeEntityPosition(Mescaline[loc], true)
        SetEntityHeading(Mescaline[loc], v.heading)
        exports['qb-target']:AddTargetEntity(Mescaline[loc], {
            options = { {
                    icon = "fas fa-hand",
                    label = "pick Cactus",
                    action = function()
                        QBCore.Functions.Progressbar("pick_cane", "picking Cactus", 2000, false, true, {
                            disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                            { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                            {}, {}, function()
                            TriggerServerEvent("Mescaline:pickupCane", loc)
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



RegisterNetEvent('Mescaline:removeCane', function(loc)
    if DoesEntityExist(Mescaline[loc]) then DeleteEntity(Mescaline[loc]) end
    Mescaline[loc] = nil
end)



RegisterNetEvent("Mescaline:init", function()
    for k, v in pairs (GlobalState.Mescaline) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            Mescaline[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            SetEntityAsMissionEntity(Mescaline[k], true, true)
            FreezeEntityPosition(Mescaline[k], true)
            SetEntityHeading(Mescaline[k], v.heading)
            exports['qb-target']:AddTargetEntity(Mescaline[k], {
                options = { {
                        icon = "fas fa-hand",
                        label = "Pick Mescaline",
                        action = function()
                            QBCore.Functions.Progressbar("pick_cane", "Picking Mescaline", 2000, false, true, {
                                disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                                { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                                {}, {}, function()
                                TriggerServerEvent("Mescaline:pickupCane", k)
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
        LoadModel('prop_cactus_03')
        TriggerEvent('Mescaline:init')
    end
 end)
 
 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('prop_cactus_03')
     TriggerEvent('Mescaline:init')
 end)
 
 AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('prop_cactus_03'))
        for k, v in pairs(Mescaline) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)

CreateThread(function()
exports['qb-target']:AddBoxZone("drymescaline",Config.DryOut,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "drymescaline",
	heading = 11.0,
	debugPoly = false,
	minZ = Config.DryOut-2,
	maxZ = Config.DryOut+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:drymescaline",
			icon = "fas fa-sign-in-alt",
			label = "Dry Out",
			
		},
	},
	distance = 2.5
 })
			
end)
RegisterNetEvent("md-drugs:client:drymescaline")
AddEventHandler("md-drugs:client:drymescaline", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Drying Out", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:drymescaline")
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:takemescaline")
AddEventHandler("md-drugs:client:takemescaline", function()
local chance = math.random(1,10)
local chance2 = math.random(1,100)
    QBCore.Functions.Progressbar("drink_something", "Taking Mescaline", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
		if chance <= Config.Badtrip then 
			AlienEffect()
			clone = ClonePed(PlayerPedId(), false, false, true)
			NetworkRegisterEntityAsNetworked(clone)
			networkID = NetworkGetNetworkIdFromEntity(clone)
			SetNetworkIdCanMigrate(networkID, true)
			SetNetworkIdExistsOnAllMachines(networkID, true)
			SetEntityAsMissionEntity(clone)
			SetEntityVisible(clone, true)
			SetPedRelationshipGroupHash(clone)
			SetPedAccuracy(clone)
			SetPedArmour(clone)
			SetPedCanSwitchWeapon(clone, true)
			SetPedFleeAttributes(clone, false)
			if chance2 <= 99 then
				GiveWeaponToPed(clone, "weapon_flaregun", 1, false, true)
				TaskCombatPed(clone, PlayerPedId(), 0, 16)
				SetPedCombatAttributes(clone, 46, true)
				Wait(1000 * 30)
				DeleteEntity(clone)
			else
				GiveWeaponToPed(clone, "weapon_rpg", 1, false, true)
				TaskCombatPed(clone, PlayerPedId(), 0, 16)
				SetPedCombatAttributes(clone, 46, true)
				Wait(1000 * 30)
				DeleteEntity(clone)
			end
		else
			AlienEffect()
		end	
    end)
end)
