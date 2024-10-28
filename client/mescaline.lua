local QBCore = exports['qb-core']:GetCoreObject()
local Mescaline = {}

local function pick(loc)
    if not progressbar(Lang.mescaline.pick, 4000, 'uncuff') then return end    
    TriggerServerEvent("Mescaline:pickupCane", loc)
end

RegisterNetEvent('Mescaline:respawnCane', function(loc)
    local v = GlobalState.Mescaline[loc]
    local hash = GetHashKey(v.model)
    if not Mescaline[loc] then
        Mescaline[loc] = CreateObject(hash, v.location, false, true, true)
        Freeze(Mescaline[loc], true, v.heading)
        AddSingleModel(Mescaline[loc], {icon = "fa-solid fa-seedling",label = Lang.targets.mescaline.pick, action = function()  pick(loc) end}, loc )
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
            Freeze(Mescaline[k], true, v.heading)
            AddSingleModel(Mescaline[k], {icon = "fa-solid fa-seedling",label = Lang.targets.mescaline.pick,action = function()  pick(k) end}, k)
        end
    end
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
    local chance, chance2 = math.random(1,100), math.random(1,100)
    local weapon = ''
    if chance2 == 100 then weapon = 'weapon_rpg' else weapon = 'weapon_flaregun' end
    if not progressbar(Lang.mescaline.eat, 4000, 'uncuff') then return end
	if chance <= Config.Badtrip then 
		AlienEffect()
		local clone = ClonePed(PlayerPedId(), false, false, true)
		SetEntityAsMissionEntity(clone)
		SetPedFleeAttributes(clone, false)
		GiveWeaponToPed(clone, weapon, 1, false, true)
		TaskCombatPed(clone, PlayerPedId(), 0, 16)
		SetPedCombatAttributes(clone, 46, true)
		Wait(1000 * 30)
        DeleteEntity(clone)
	else
		AlienEffect()
	end
end)
