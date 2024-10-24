local QBCore = exports['qb-core']:GetCoreObject()
local PoppyPlants = {}
local herointable = false

local function pickher(loc)
    if not progressbar(Lang.Heroin.pick, 4000, 'uncuff') then return end
    TriggerServerEvent("heroin:pickupCane", loc)
end

CreateThread(function() 
local Ped = "g_m_y_famdnf_01"
	lib.requestModel("g_m_y_famdnf_01", Config.RequestModelTime)
	local labkitlocation = Config.buyheroinlabkit
	local heroinkitdealer = CreatePed(0, Ped, labkitlocation.x, labkitlocation.y, labkitlocation.z-1, labkitlocation.w, false, false)
    Freeze(heroinkitdealer, true, labkitlocation.w)
    AddSingleModel(heroinkitdealer, { label = Lang.targets.heroin.kit, icon = "fas fa-eye", event = "md-drugs:client:buyheroinlabkit", distance = 2.0}, nil )
end)

---- plant spawns dont edit
RegisterNetEvent('heroin:respawnCane', function(loc)
    local v = GlobalState.PoppyPlants[loc]
    local hash = GetHashKey(v.model)
    if not PoppyPlants[loc] then
        PoppyPlants[loc] = CreateObject(hash, v.location, false, true, true)
        Freeze(PoppyPlants[loc], true, v.heading)
        AddSingleModel(PoppyPlants[loc], {icon = "fas fa-hand",    label = Lang.targets.heroin.pick,    action = function()        pickher(loc)    end}, loc )
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
            Freeze(PoppyPlants[k], true, v.heading)
            AddSingleModel(PoppyPlants[k], {icon = "fas fa-hand",    label = Lang.targets.heroin.pick,    action = function()        pickher(k)    end}, k )
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


RegisterNetEvent("md-drugs:client:dryplant", function(data) 
    if not progressbar(Lang.Heroin.dryout, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:dryplant",data.data)
end)

RegisterNetEvent("md-drugs:client:cutheroin", function(data) 
    if not ItemCheck('bakingsoda') then return end
	if not progressbar(Lang.Heroin.cutting, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:cutheroin", data.data)   
end)

RegisterNetEvent("md-drugs:client:buyheroinlabkit", function()
   if not progressbar(Lang.Heroin.secret, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:getheroinlabkit")
end)


RegisterNetEvent("md-drugs:client:setheroinlabkit", function() 
if herointable then   
   Notify(Lang.Heroin.tableout, 'error')
else
    herointable = true
    local location, head = StartRay()
    if not location then herointable = false TriggerServerEvent('md-drugs:server:getheroinlabkitback') return end
    if not progressbar(Lang.Heroin.table, 4000, 'uncuff') then TriggerServerEvent('md-drugs:server:getheroinlabkitback') return end
	local heroinlabkit = CreateObject("v_ret_ml_tablea", location.x, location.y, location.z, true, false)
    SetEntityHeading(heroinlabkit, head)
	PlaceObjectOnGroundProperly(heroinlabkit)
    local  options = {
        { event = "md-drugs:client:heatliquidheroin", icon = "fas fa-box-circle-check", label = Lang.targets.heroin.cook, data = heroinlabkit},
        { event = "md-drugs:client:getheroinkitback", icon = "fas fa-box-circle-check", label = Lang.targets.heroin.up,   data = heroinlabkit, canInteract = function() if herointable then return true end end},
     }
    AddMultiModel(heroinlabkit, options, heroinlabkit)
end
end)


RegisterNetEvent("md-drugs:client:heatliquidheroin", function(data) 
    local loc = GetEntityCoords(data.data)
    local head = GetEntityHeading(data.data)
    if not ItemCheck('emptyvial') then return end
    if not minigame() then
        TriggerServerEvent("md-drugs:server:failheatingheroin")
		DeleteObject(data.data)
		local dirtylabkitheroin = CreateObject("v_ret_ml_tablea", loc.x, loc.y, loc.z-1, true, false)
        SetEntityHeading(dirtylabkitheroin, head)
        PlaceObjectOnGroundProperly(dirtylabkitheroin)
		loadParticle("core")
	    heroinkit = StartParticleFxLoopedOnEntity("exp_air_molotov", dirtylabkitheroin, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
        SetParticleFxLoopedAlpha(heroinkit, 3.0)
		SetPedToRagdoll(PlayerPedId(), 1300, 1300, 0, 0, 0, 0)
        AddMultiModel(dirtylabkitheroin, {event = "md-drugs:client:cleanheroinlabkit",icon = "fas fa-box-circle-check",label = Lang.target.heroin.clean, data = dirtylabkitheroin}, nil )
	return end
   if not progressbar(Lang.Heroin.success, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:heatliquidheroin")
end)


RegisterNetEvent("md-drugs:client:cleanheroinlabkit", function(data)
    if not ItemCheck('cleaningkit') then return end
    if not progressbar(Lang.Heroin.clean, 4000, 'clean') then return end
	TriggerServerEvent("md-drugs:server:removecleaningkitheroin", data.data)
end)

RegisterNetEvent("md-drugs:client:deletedirtyheroin", function(data)
local location = GetEntityCoords(data)
local head = GetEntityHeading(data)
    DeleteObject(data)
	local heroinlabkit = CreateObject("v_ret_ml_tablea", location.x, location.y, location.z-1, true, false)
    SetEntityHeading(heroinlabkit, head)
	PlaceObjectOnGroundProperly(heroinlabkit)
    local  options = {
        { event = "md-drugs:client:heatliquidheroin", icon = "fas fa-box-circle-check", label = Lang.targets.heroin.cook, data = heroinlabkit},
        { event = "md-drugs:client:getheroinkitback", icon = "fas fa-box-circle-check", label = Lang.targets.heroin.up,   data = heroinlabkit, canInteract = function() if herointable then return true end end},
     }
    AddMultiModel(heroinlabkit, options, heroinlabkit)
end)



RegisterNetEvent("md-drugs:client:getheroinkitback", function(data) 
   if not progressbar(Lang.Heroin.pickup, 4000, 'uncuff') then return end
    herointable = false
    DeleteObject(data.data)
    TriggerServerEvent("md-drugs:server:getheroinlabkitback")
end)


RegisterNetEvent("md-drugs:client:fillneedle", function(data)
    if not minigame() then TriggerServerEvent("md-drugs:server:failheroin", data.data) return end
    if not progressbar(Lang.Heroin.needles, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:fillneedle", data.data)
end)


