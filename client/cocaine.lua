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
        ps.entityTarget(CocaPlant[loc], {
            {
                icon = "fa-solid fa-seedling",
                label = ps.lang('targets.coke.pick'),
                action = function()
                    if not pick(loc) then return end
                end
            }
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
        ps.requestModel(hash)
        if not v.taken then
            CocaPlant[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            Freeze(CocaPlant[k], true, v.heading)
            ps.entityTarget(CocaPlant[k], {
                {
                    icon = "fa-solid fa-seedling",
                    label = ps.lang('targets.coke.pick'),
                    action = function()
                        if not pick(k) then return end
                    end
                }
            })
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

for k, v in pairs (GlobalState.MDDrugsLocs.MakePowder) do
    ps.boxTarget('cocaplant'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('.targets.coke.pick'),
            icon = 'fa-solid fa-seedling',
            action = function()
                if not ps.hasItem('coca_leaf') then return end
                if not ps.progressbar(ps.lang('Coke.makepow'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:makepowder", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

for k, v in pairs (GlobalState.MDDrugsLocs.CuttingCoke) do
    ps.boxTarget('cutcoke'..k, v.loc, {length = 1.0, width = 1.0, height = 1.0, rotation = 180.0}, {
        {
            label = ps.lang('targets.coke.cut'),
            icon = 'fa-solid fa-mortar-pestle',
            action = function()
                CutCoke(v.loc, v.offset, v.rotation)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                if cuttingcoke ~= nil or baggingcoke ~= nil then return false end
                return true
            end,
        }
    })
end
for k, v in pairs (GlobalState.MDDrugsLocs.BaggingCoke) do
    ps.boxTarget('bagcoke'..k, v.loc, {length = 1.0, width = 1.0, height = 1.0, rotation = 180.0}, {
        {
            label = ps.lang('targets.coke.bag'),
            icon = 'fa-solid fa-sack-xmark',
            action = function()
                BagCoke(v.loc, v.offset, v.rotation)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                if cuttingcoke ~= nil or baggingcoke ~= nil then return false end
                return true
            end
        }
    })
end
