local QBCore = exports['qb-core']:GetCoreObject()
local CocaPlant = {}
local cuttingcoke = nil
local baggingcoke = nil

local function pick(loc)
    if not progressbar(Lang.Coke.picking, 4000, 'uncuff') then return end
        TriggerServerEvent("coke:pickupCane", loc)  
    return true
end

RegisterNetEvent('coke:respawnCane', function(loc)
    local v = GlobalState.CocaPlant[loc]
    local hash = GetHashKey(v.model)
    if not CocaPlant[loc] then
        CocaPlant[loc] = CreateObject(hash, v.location, false, true, true)
        Freeze(CocaPlant[loc], true, v.heading)
        AddSingleModel(CocaPlant[loc], {icon = "fa-solid fa-seedling", label = Lang.targets.coke.pick, action = function() if not pick(loc) then return end end}, loc)
    end
end)

RegisterNetEvent('coke:removeCane', function(loc)
    if DoesEntityExist(CocaPlant[loc]) then DeleteEntity(CocaPlant[loc]) end
    CocaPlant[loc] = nil
end)

RegisterNetEvent("coke:init", function()
    for k, v in pairs (GlobalState.CocaPlant) do
        local hash = GetHashKey(v.model)
        LoadModel(hash) 
        if not v.taken then
            CocaPlant[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            Freeze(CocaPlant[k], true, v.heading)
            AddSingleModel(CocaPlant[k], {icon = "fa-solid fa-seedling", label = Lang.targets.coke.pick, action = function() if not pick(k) then return end end}, k)
        end
    end
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

RegisterNetEvent("md-drugs:client:makepowder", function(data)
    if not ItemCheck('coca_leaf') then return end
    if not progressbar(Lang.Coke.makepow, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:makepowder", data.data)
end)

RegisterNetEvent("md-drugs:client:cutcokeone", function()
    if not ItemCheck('bakingsoda') then return end
	cuttingcoke = true
    if Config.FancyCokeAnims then
	    CutCoke()
    else
         if not progressbar(Lang.Coke.cutting, 5000, 'uncuff') then cuttingcoke = nil return end
    end
	TriggerServerEvent("md-drugs:server:cutcokeone")
	cuttingcoke = nil
end)

RegisterNetEvent("md-drugs:client:bagcoke", function() 
    if not ItemCheck('empty_weed_bag') then return end
	baggingcoke = true
    if Config.FancyCokeAnims then
	    BagCoke()
    else
        if not progressbar(Lang.Coke.bagging, 5000, 'uncuff') then baggingcoke = nil return end
    end
	TriggerServerEvent("md-drugs:server:bagcoke")
	baggingcoke = nil
end)

CreateThread(function()
    if Config.FancyCokeAnims == false then 
        AddBoxZoneMulti('cuttcoke', Config.CuttingCoke,  {	type = "client",	event = "md-drugs:client:cutcokeone",	icon = "fa-solid fa-mortar-pestle",	label = Lang.targets.coke.cut}) 
        AddBoxZoneMulti('baggcoke', Config.BaggingCoke,  {	type = "client",	event = "md-drugs:client:bagcoke",	    icon = "fa-solid fa-sack-xmark",	label = Lang.targets.coke.bag})
    else
        AddBoxZoneSingle('cutcoke', vector3(1093.17, -3195.74, -39.19),
		    { type = "client", event = "md-drugs:client:cutcokeone", icon = "fa-solid fa-mortar-pestle", label = Lang.targets.coke.cut, canInteract = function()if cuttingcoke == nil and baggingcoke == nil then return true end end })
        AddBoxZoneSingle('bagcokepowder', vector3(1090.29, -3195.66, -39.13),
		    { type = "client", event = "md-drugs:client:bagcoke",    icon = "fa-solid fa-sack-xmark", label = Lang.targets.coke.bag, canInteract = function() if baggingcoke == nil and cuttingcoke == nil then return true end end })
    end
end)
