
local DrugPlants = {
    {model = 'prop_plant_01a', label = 'coke', langs = ps.lang('coke.targetPick'), tbl = GlobalState.CocaPlant, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('coke.picking'), 4000, 'uncuff') then return end
                TriggerServerEvent("coke:pickupCane", loc)
            return true
        end,
        allow = Config.Drugs.cocaine,
    },
    {model = 'prop_plant_01b', label = 'heroin',langs = ps.lang('heroin.targetPick'), tbl = GlobalState.PoppyPlants, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('heroin.picking'), 4000, 'uncuff') then return end
                TriggerServerEvent("heroin:pickupCane", loc)
            return true
        end,
        allow = Config.Drugs.heroin,
    },
    {model = 'prop_cactus_03', label = 'Mescaline', langs = ps.lang('mesc.targetPick'), tbl = GlobalState.Mescaline, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('mesc.picking'), 4000, 'uncuff') then return end
                TriggerServerEvent("Mescaline:pickupCane", loc)
            return true
        end,
        allow = Config.Drugs.mescaline,

    },
    {model = 'prop_weed_01', label = 'weed', langs = ps.lang('weed.targetPick'), tbl = GlobalState.WeedPlant, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('weed.picking'), 4000, 'uncuff') then return end
                TriggerServerEvent("weed:pickupCane", loc)
            return true
        end,
        allow = Config.Drugs.weed,
    },
    {model = 'mushroom', label = 'shrooms', langs = ps.lang('shrooms.targetPick'), tbl = GlobalState.shrooms, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('shrooms.picking'), 4000, 'uncuff') then return end
                TriggerServerEvent("shrooms:pickupCane", loc)
            return true
        end,
        allow = Config.Drugs.shrooms,
    },
}

for k, v in pairs (DrugPlants) do
    if not v.allow then goto continue end
    RegisterNetEvent(v.label ..':respawnCane', function(loc)
        local plant = v.tbl[loc]
        local hash = GetHashKey(plant.model)
        if not v.plantTbl[loc] then
            ps.requestModel(hash)
            v.plantTbl[loc] = CreateObject(hash, plant.location, false, true, true)
            Freeze(v.plantTbl[loc], true, plant.heading)
            ps.entityTarget(v.plantTbl[loc], {
                {
                    icon = v.icon,
                    label = v.langs,
                    action = function()
                        if not v.pick(loc) then return end
                    end
                }
            })
        end
    end)

    RegisterNetEvent(v.label ..':removeCane', function(loc)
        DeleteEntity(v.plantTbl[loc])
        v.plantTbl[loc] = nil
    end)

    RegisterNetEvent(v.label ..":init", function()
        if not v.plantTbl then v.plantTbl = {} end
        for key, value in pairs (v.tbl) do
            local hash = GetHashKey(value.model)
            if not value.taken then
                v.plantTbl[key] = CreateObject(hash, value.location.x, value.location.y, value.location.z, false, true, true)
                Freeze(v.plantTbl[key], true, v.heading)
                ps.entityTarget(v.plantTbl[key], {
                    {
                        icon = v.icon,
                        label = v.langs,
                        action = function()
                            if not v.pick(key) then return end
                        end
                    }
                })
            end
        end
    end)
    TriggerEvent(v.label ..":init")
    ::continue::
    
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('prop_plant_01a'))
        for k, v in pairs(DrugPlants) do
            for key, plant in pairs(v.plantTbl) do
                if DoesEntityExist(plant) then DeleteEntity(plant) end
                v.plantTbl[key] = nil
            end
        end
    end
end)