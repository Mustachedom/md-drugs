local tableout = false
local dirtylsd = false
repeat Wait(100) until GlobalState.MDDrugsRecipes.LSD ~= nil
local locations = GlobalState.MDDrugsLocations.LSD


local function createLabKit(coord, head)
    requestModel("v_ret_ml_tablea")
    local labkit = CreateObject("v_ret_ml_tablea", coord.x, coord.y, coord.z - 1, true, false)
    SetEntityHeading(labkit, head)
    PlaceObjectOnGroundProperly(labkit)
    FreezeEntityPosition(labkit, true)
    tableout = true
    local options = {
        {
            icon = Bridge.Language.Locale('lsd.targetHeatIcon'),
            label = Bridge.Language.Locale('lsd.targetHeat'),
            action = function()
	            if not minigame() then
                    local coords = GetEntityCoords(labkit)
                    AddExplosion(coords.x, coords.y, coords.z-1.0, 34, 0.0, true, false, true)
                    dirtylsd = true
                    TriggerServerEvent("md-drugs:server:failheating")
                    return
                end
                if not progressbar(Bridge.Language.Locale('lsd.heating'), 7000) then return end
                TriggerServerEvent("md-drugs:server:heatliquid")
            end,
            canInteract = function()
                if not dirtylsd then return true end
            end
        },
        {
            icon = Bridge.Language.Locale('lsd.targetRefineIcon'),
            label = Bridge.Language.Locale('lsd.targetRefine'),
            action = function()
                if not itemCheck('lsd_one_vial') then return end
                if not minigame() then TriggerServerEvent("md-drugs:server:failrefinequality") return end
                if not progressbar(Bridge.Language.Locale('lsd.refining')) then return end
                TriggerServerEvent("md-drugs:server:refinequalityacid")
            end,
            canInteract = function()
                if not dirtylsd then return true end
            end
        },
        {
            icon = Bridge.Language.Locale('lsd.targetDippingIcon'),
            label = Bridge.Language.Locale('lsd.targetDipping'),
            action = function()
                if not itemCheck('tab_paper') then return end
                if not minigame() then TriggerServerEvent("md-drugs:server:failtabs") return end
                if not progressbar(Bridge.Language.Locale('lsd.dipping')) then return end
                TriggerServerEvent("md-drugs:server:maketabpaper")
            end,
            canInteract = function()
                if not dirtylsd then return true end
            end
        },
        {
            icon = Bridge.Language.Locale('lsd.targetPickupIcon'),
            label = Bridge.Language.Locale('lsd.targetPickup'),
            action = function()
                if not progressbar(Bridge.Language.Locale('lsd.packup')) then return end
	            DeleteObject(labkit)
	            TriggerServerEvent('md-drugs:server:getlabkitback')
                tableout = false
            end,
            canInteract = function()
                if not dirtylsd then return true end
            end
        },
        {
            icon = Bridge.Language.Locale('lsd.targetCleanIcon'),
            label = Bridge.Language.Locale('lsd.targetClean'),
            action = function()
                if not itemCheck('cleaningkit') then return end
                if not progressbar(Bridge.Language.Locale('lsd.cleaning'), 4000, 'clean') then return end
                local check = Bridge.Callback.Trigger('md-drugs:server:removecleaningkit')
                if check then
                    dirtylsd = false
                end
            end,
            canInteract = function() if dirtylsd then return true end end
        }
    }
    Bridge.Target.AddLocalEntity(labkit, options)
end

for k, v in pairs (locations.lysergicacid) do 
    Bridge.Target.AddBoxZone('lysergicacid'..k,v.loc, v.size, v.loc.w or 180.0, {
        {
            label = Bridge.Language.Locale('lsd.targetLys'),
            icon = Bridge.Language.Locale('lsd.targetLysIcon'),
            action = function()
                if not minigame() then TriggerServerEvent("md-drugs:server:faillysergic") return end
                if not progressbar(Bridge.Language.Locale('lsd.stealLys')) then return end
                TriggerServerEvent("md-drugs:server:getlysergic", k)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                return true
            end
        }
    })
end

for k, v in pairs (locations.diethylamide) do 
    Bridge.Target.AddBoxZone('diethylamide'..k, v.loc, v.size, v.loc.w or 180.0, {
        {
            label = Bridge.Language.Locale('lsd.targetDie'),
            icon = Bridge.Language.Locale('lsd.targetDieIcon'),
            action = function()
                if not minigame() then TriggerServerEvent("md-drugs:server:faildiethylamide") return end
                if not progressbar(Bridge.Language.Locale('lsd.stealDie')) then return end
                TriggerServerEvent("md-drugs:server:getdiethylamide", k)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                return true
            end
        }
    })
end

for k, v in pairs (locations.gettabs) do
    Bridge.Target.AddBoxZone('gettabs'..k, v.loc, v.size, v.loc.w or 180.0, {
        {
            label = Bridge.Language.Locale('lsd.targetBuyTab'),
            icon = Bridge.Language.Locale('lsd.targetBuyTabIcon'),
            action = function()
                TriggerServerEvent("md-drugs:server:gettabpaper", k)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                return true
            end
        }
    })
end

local seller = {}
for k, v in pairs (locations.buyLSDkit) do
    requestModel(v.ped, 1000)
    seller[k] = CreatePed(4, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
    Freeze(seller[k], true, v.loc.w)
    Bridge.Target.AddLocalEntity(seller[k], {
        {
            label = Bridge.Language.Locale('lsd.targetBuyKit'),
            icon = Bridge.Language.Locale('lsd.targetBuyKitIcon'),
            action = function()
                if Bridge.Inventory.HasItem('lsdlabkit') then
                    Bridge.Notify.SendNotify(Bridge.Language.Locale('lsd.alreadyOwn'), 'error')
                    return
                end
                if not progressbar(Bridge.Language.Locale('lsd.buyingKit')) then return end
                TriggerServerEvent('md-drugs:server:getlabkit', k)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                return true
            end
        }
    })
end

Bridge.Callback.Register("md-drugs:client:setlsdlabkit", function()
    if tableout then
        Bridge.Notify.SendNotify(Bridge.Language.Locale('lsd.tableout'), 'error')
        return false
    else
        tableout = true
        local loc, head = StartRay()
        if not loc then tableout = false return end
        if not progressbar(Bridge.Language.Locale('lsd.placing')) then return end
        createLabKit(loc, head)
        return true, loc
    end

end)
