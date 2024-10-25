local QBCore = exports['qb-core']:GetCoreObject()
local shrooms = {}

function LoadModel(hash)
    hash = GetHashKey(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(3000)
    end
end

local function pick(loc)
    if not progressbar(Lang.Shrooms.pick, 4000, 'uncuff') then return end  
    TriggerServerEvent("shrooms:pickupCane", loc)
end

RegisterNetEvent('shrooms:respawnCane', function(loc)
    local v = GlobalState.shrooms[loc]
    local hash = GetHashKey(v.model)
    if not shrooms[loc] then
        shrooms[loc] = CreateObject(hash, v.location, false, true, true)
        Freeze(shrooms[loc], true, v.heading)
        AddSingleModel(shrooms[loc],{ icon = "fas fa-hand", label = Lang.targets.shrooms.pick, action = function() pick(loc) end }, loc )
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
		Wait(3000)
        LoadModel('mushroom')
        TriggerEvent('shrooms:init')
    end
 end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('mushroom'))
        for k, v in pairs(shrooms) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)

RegisterNetEvent('shrooms:removeCane', function(loc)
    if DoesEntityExist(shrooms[loc]) then DeleteEntity(shrooms[loc]) end
    shrooms[loc] = nil
end)

 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('mushroom')
     TriggerEvent('shrooms:init')
 end)

 RegisterNetEvent("shrooms:init", function()
    for k, v in pairs (GlobalState.shrooms) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            shrooms[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            Freeze(shrooms[k], true, v.heading)
            AddSingleModel(shrooms[k],{ icon = "fas fa-hand", label = Lang.targets.shrooms.pick, action = function() pick(k) end }, k )
        end
    end
end)

RegisterNetEvent('md-drugs:client:takeshrooms', function()
    if not progressbar(Lang.Shrooms.eat, 500, 'eat')  then return end              
    TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
    EcstasyEffect()
end)
