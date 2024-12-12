local PoppyPlants = {}
local herointable = false

 local function createLabKit(coord, head)
    local heroinlabkit = CreateObject("v_ret_ml_tablea", coord.x, coord.y, coord.z - 1, true, false,false)
    SetEntityHeading(heroinlabkit, head)
    PlaceObjectOnGroundProperly(heroinlabkit)
    AddMultiModel(heroinlabkit, {
        { event = "md-drugs:client:heatliquidheroin", icon = "fa-solid fa-temperature-high", label = Lang.targets.heroin.cook, data = heroinlabkit},
        { event = "md-drugs:client:getheroinkitback", icon = "fas fa-box-circle-check", label = Lang.targets.heroin.up,   data = heroinlabkit, canInteract = function() if herointable then return true end end}},
    heroinlabkit)
end

local function pickher(loc)
    if not progressbar(Lang.Heroin.pick, 4000, 'uncuff') then return end
    TriggerServerEvent("heroin:pickupCane", loc)
end

RegisterNetEvent('heroin:respawnCane', function(loc)
    local v = GlobalState.PoppyPlants[loc]
    local hash = GetHashKey(v.model)
    if not PoppyPlants[loc] then
        PoppyPlants[loc] = CreateObject(hash, v.location, false, true, true)
        Freeze(PoppyPlants[loc], true, v.heading)
        AddSingleModel(PoppyPlants[loc], {icon = "fa-solid fa-seedling", label = Lang.targets.heroin.pick, action = function() pickher(loc) end}, loc )
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
            AddSingleModel(PoppyPlants[k], {icon = "fa-solid fa-seedling", label = Lang.targets.heroin.pick, action = function() pickher(k) end}, k )
        end
    end
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

lib.callback.register("md-drugs:client:setheroinlabkit", function() 
    if herointable then   
       Notify(Lang.Heroin.tableout, 'error')
       return false
    else
        herointable = true
        local location, head = StartRay()
        if not location then herointable = false return end
        if not progressbar(Lang.Heroin.table, 4000, 'uncuff') then return end
    	createLabKit(location, head)
        return true, location
    end
end)

RegisterNetEvent("md-drugs:client:heatliquidheroin", function(data) 
    local loc, head = GetEntityCoords(data.data), GetEntityHeading(data.data)
    if not ItemCheck('emptyvial') then return end
    if not minigame() then
        TriggerServerEvent("md-drugs:server:failheatingheroin")
		DeleteObject(data.data)
		local dirtylabkitheroin = CreateObject("v_ret_ml_tablea", loc.x, loc.y, loc.z-1, true, false)
        SetEntityHeading(dirtylabkitheroin, head)
        PlaceObjectOnGroundProperly(dirtylabkitheroin)
		loadParticle("core")
	    local heroinkit = StartParticleFxLoopedOnEntity("exp_air_molotov", dirtylabkitheroin, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
        SetParticleFxLoopedAlpha(heroinkit, 3.0)
		SetPedToRagdoll(PlayerPedId(), 1300, 1300, 0, 0, 0, 0)
        AddMultiModel(dirtylabkitheroin, {{event = "md-drugs:client:cleanheroinlabkit",icon = "fa-solid fa-hand-sparkles",label = Lang.targets.heroin.clean, data = dirtylabkitheroin}}, nil )
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
    local location,head = GetEntityCoords(data), GetEntityHeading(data)
    DeleteObject(data)
	createLabKit(location, head)
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