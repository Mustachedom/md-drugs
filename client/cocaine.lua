local QBCore = exports['qb-core']:GetCoreObject()
local CocaPlant = {}
local cuttingcoke = nil
local baggingcoke = nil

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
                        if not progressbar(Lang.Coke.picking, 4000, 'uncuff') then return end
                        TriggerServerEvent("coke:pickupCane", loc)   
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
                           if not progressbar(Lang.Coke.picking, 4000, 'uncuff') then  return end
                            TriggerServerEvent("coke:pickupCane", k)
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
	local options = {
		{ type = "client", event = "md-drugs:client:cutcokeone", icon = "fas fa-sign-in-alt", label = "cut up", canInteract = function()
				if cuttingcoke == nil and baggingcoke == nil then return true end
			end			
		},
	}
    local options2 = {
		{ type = "client", event = "md-drugs:client:bagcoke", icon = "fas fa-sign-in-alt", label = "bagging", canInteract = function()
				if baggingcoke == nil and cuttingcoke == nil then return true end end }, }
    if Config.oxtarget then
        exports.ox_target:addBoxZone({coords = vector3(1093.17, -3195.74, -39.19 -1), size = vec3(1,1,1), options = options})
        exports.ox_target:addBoxZone({coords = vector3(1093.17, -3195.74, -39.19 -1), size = vec3(1,1,1), options = options2})
    else
        exports['qb-target']:AddBoxZone("cutcokepowder",vector3(1093.17, -3195.74, -39.19 -1),1.5, 1.75, {name = "cutcokepowder", minZ = -40.0,maxZ = -38.0,}, { options = options, distance = 2.0 })
	    exports['qb-target']:AddBoxZone("bagcokepowder",vector3(1090.29, -3195.66, -39.13 - 1),1.5, 1.75, {name = "bagcokepowder", minZ = -40, maxZ = -38,}, {options = options2, distance = 2.0})
    end
    if Config.FancyCokeAnims == false then 
        for k, v in pairs (Config.CuttingCoke) do 
            if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
             local options = {
                {	type = "client",	event = "md-drugs:client:cutcokeone",	icon = "fas fa-sign-in-alt",	label = "Cut Coke", data = k,  distance = 2.0,
                    canInteract = function()
                        if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
                },
            }
            if Config.oxtarget then
                exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
            else
                exports['qb-target']:AddBoxZone("cutcoke"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="cutcoke"..k, heading = 156.0,minZ = v.loc.z-1, maxZ = v.loc.z+1, }, {options = options, distance = 1.5})
            end
        end
        for k, v in pairs (Config.BaggingCoke) do 
            if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
             local options = {
                {	type = "client",	event = "md-drugs:client:bagcoke",	icon = "fas fa-sign-in-alt",	label = "Bag Coke", data = k,  distance = 2.0,
                    canInteract = function()
                        if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
                },
            }
            if Config.oxtarget then
                exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
            else
                exports['qb-target']:AddBoxZone("bagcoke"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="bagcoke"..k, heading = 156.0,minZ = v.loc.z-1, maxZ = v.loc.z+1, }, {options = options, distance = 1.5})
            end
        end
    end
end)