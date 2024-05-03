local QBCore = exports['qb-core']:GetCoreObject()
local Mescaline = {}

function LoadModel(hash)
    hash = GetHashKey(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(3000)
    end
end 

RegisterNetEvent('Mescaline:respawnCane', function(loc)
    local v = GlobalState.Mescaline[loc]
    local hash = GetHashKey(v.model)
    if not Mescaline[loc] then
        Mescaline[loc] = CreateObject(hash, v.location, false, true, true)
        SetEntityAsMissionEntity(Mescaline[loc], true, true)
        FreezeEntityPosition(Mescaline[loc], true)
        SetEntityHeading(Mescaline[loc], v.heading)
        exports['qb-target']:AddTargetEntity(Mescaline[loc], {
        options = { 
            {icon = "fas fa-hand",label = "pick Cactus",action = function()    if not progressbar(Lang.mescaline.pick, 4000, 'uncuff') then return end    TriggerServerEvent("Mescaline:pickupCane", loc)end}
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
                options = { { icon = "fas fa-hand", label = "Pick Mescaline", action = function()  if not progressbar(Lang.mescaline.pick, 4000, 'uncuff') then return end  TriggerServerEvent("Mescaline:pickupCane", k) end}
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



RegisterNetEvent("md-drugs:client:drymescaline", function()
    if not ItemCheck('cactusbulb')  then return end 
	if not progressbar(Lang.mescaline.dry, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:drymescaline")
end)


RegisterNetEvent("md-drugs:client:takemescaline", function()
local chance = math.random(1,100)
local chance2 = math.random(1,100)
    if not progressbar(Lang.mescaline.eat, 4000, 'uncuff') then return end
	if chance <= Config.Badtrip then 
		AlienEffect()
		clone = ClonePed(PlayerPedId(), false, false, true)
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
