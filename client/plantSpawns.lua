
local DrugPlants = {
    {model = 'prop_plant_01a', label = 'coke', tbl = GlobalState.CocaPlant, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('Coke.picking'), 4000, 'uncuff') then return end
                TriggerServerEvent("coke:pickupCane", loc)
            return true
        end,
        target = {
            icon = "fa-solid fa-seedling",
            label = ps.lang('targets.coke.pick'),
        },
        allow = Config.Drugs.cocaine,
    },
    {model = 'prop_plant_01b', label = 'heroin', tbl = GlobalState.PoppyPlants, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('Heroin.pick'), 4000, 'uncuff') then return end
                TriggerServerEvent("heroin:pickupCane", loc)
            return true
        end,
        target = {
            icon = "fa-solid fa-seedling",
            label = ps.lang('targets.heroin.pick'),
        },
        allow = Config.Drugs.heroin,
    },
    {model = 'prop_cactus_03', label = 'Mescaline', tbl = GlobalState.Mescaline, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('mescaline.pick'), 4000, 'uncuff') then return end
                TriggerServerEvent("Mescaline:pickupCane", loc)
            return true
        end,
        target = {
            icon = "fa-solid fa-seedling",
            label = ps.lang('targets.mescaline.pick'),
        },
        allow = Config.Drugs.mescaline,

    },
    {model = 'prop_weed_01', label = 'weed', tbl = GlobalState.WeedPlant, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('Weed.picking'), 4000, 'uncuff') then return end
                TriggerServerEvent("weed:pickupCane", loc)
            return true
        end,
        target = {
            icon = "fa-solid fa-seedling",
            label = ps.lang('targets.weed.pick'),
        },
        allow = Config.Drugs.weed,
    },
    {model = 'mushroom', label = 'shrooms', tbl = GlobalState.shrooms, plantTbl = {},
        pick = function(loc)
            if not ps.progressbar(ps.lang('Shrooms.pick'), 4000, 'uncuff') then return end
                TriggerServerEvent("shrooms:pickupCane", loc)
            return true
        end,
        target = {
            icon = "fa-solid fa-hand",
            label = ps.lang('targets.shrooms.pick'),
        },
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
                    label = v.label,
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
                        label = v.label,
                        action = function()
                            if not v.pick(key) then return end
                        end
                    }
                })
            end
        end
    end)
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