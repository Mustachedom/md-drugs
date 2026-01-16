
local herointable = false
local dirty = false
local locations = GlobalState.MDDrugsLocations.Heroin

local function createLabKit(coord, head)
    local heroinlabkit = CreateObject("v_ret_ml_tablea", coord.x, coord.y, coord.z - 1, true, false,false)
    SetEntityHeading(heroinlabkit, head)
    PlaceObjectOnGroundProperly(heroinlabkit)
    Bridge.Target.AddLocalEntity(heroinlabkit, {
        {
            icon = "fa-solid fa-temperature-high",
            label = Bridge.Language.Locale('heroin.targetCook'),
            action = function()
            if not Bridge.Inventory.HasItem('emptyvial') then
                Bridge.Notify.SendNotify(Bridge.Language.Locale('Catches.itemMissings', Bridge.Inventory.GetItemInfo('emptyvial').label), 'error')
                return
            end

            if not minigame() then
                dirty = true
                TriggerServerEvent("md-drugs:server:failheatingheroin")
                local coords = GetEntityCoords(heroinlabkit)
                AddExplosion(coords.x, coords.y, coords.z-1.0, 34, 0.0, true, false, true)
                SetParticleFxLoopedAlpha(heroinkit, 3.0)
	        	SetPedToRagdoll(PlayerPedId(), 1300, 1300, 0, 0, 0, 0)
	            return
            end
            if not progressbar(Bridge.Language.Locale('heroin.pbCook'), 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:heatliquidheroin")
        end,
        canInteract = function()
            if not dirty then return true end
        end
    },
    {
        icon = "fas fa-box-circle-check",
        label = Bridge.Language.Locale('heroin.targetPickup'),
        action = function()
            if not progressbar(Bridge.Language.Locale('heroin.pbPickup'), 4000, 'uncuff') then return end
            herointable = false
            DeleteObject(heroinlabkit)
            TriggerServerEvent("md-drugs:server:getheroinlabkitback")
        end,
        canInteract = function()
            if not dirty then return true end
            return false
        end
    },
    {
        icon = "fa-solid fa-hand-sparkles",
        label = Bridge.Language.Locale('heroin.targetClean'),
        action = function()
            if not Bridge.Inventory.HasItem('cleaningkit') then
                Bridge.Notify.SendNotify(Bridge.Language.Locale('Catches.itemMissings', Bridge.Inventory.GetItemInfo('cleaningkit').label), 'error')
                return
            end
            if not progressbar(Bridge.Language.Locale('heroin.pbClean'), 4000, 'clean') then return end
	        local done = Bridge.Callback.Trigger('md-drugs:server:removeCleaningKitHeroin', false)
            if done then dirty = false end
        end,
        canInteract = function()
            if dirty then return true end
            return false
        end
    }})
end

for k, v in pairs (locations.dryplant) do
    Bridge.Target.AddBoxZone('dryHeroin'..k,   v.loc, vector3(v.l, v.w, 2.0), v.loc.w or 180.0,   {
        {
            label = Bridge.Language.Locale('heroin.targetDry'),
            icon = 'fa-solid fa-temperature-high',
            action = function()
                if not progressbar(Bridge.Language.Locale('heroin.pbDry'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:dryplant", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

for k, v in pairs (locations.cutheroinone) do
    Bridge.Target.AddBoxZone('cutHeroin'..k, v.loc, vector3(v.l, v.w, 2.0), v.loc.w or 180.0,  {
        {
            label = Bridge.Language.Locale('heroin.targetCutHeroin'),
            icon = 'fa-solid fa-seedling',
            action = function()
                if not Bridge.Inventory.HasItem('bakingsoda') then
                    Bridge.Notify.SendNotify(Bridge.Language.Locale('Catches.itemMissings', Bridge.Inventory.GetItemInfo('bakingsoda').label), 'error')
                    return
                end
	            if not progressbar(Bridge.Language.Locale('heroin.pbCutHeroin'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:cutheroin", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

local peds = {}
for k, v in pairs (locations.buyKit) do
    requestModel(v.ped, 1000)
    peds[k] = CreatePed(4, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
    Freeze(peds[k], true, v.loc.w)
    SetBlockingOfNonTemporaryEvents(peds[k], true)
    SetEntityInvincible(peds[k], true)
    Bridge.Target.AddLocalEntity(peds[k], {
        {
            label = Bridge.Language.Locale('heroin.targetBuyKit'),
            icon = 'fa-solid fa-box-open',
            action = function()
               if not progressbar(Bridge.Language.Locale('heroin.pbBuyKit'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:getheroinlabkit", k)
            end,
            canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
        }
    })
end


Bridge.Callback.Register("md-drugs:client:setheroinlabkit", function() 
    if herointable then
       Bridge.Notify.SendNotify(Bridge.Language.Locale('heroin.tableout'), 'error')
       return false
    else
        herointable = true
        local location, head = StartRay()
        if not location then herointable = false return end
        if not progressbar(Bridge.Language.Locale('heroin.placing'), 4000, 'uncuff') then return end
    	createLabKit(location, head)
        return true, location
    end
end)

for k, v in pairs (locations.fillneedle) do
    Bridge.Target.AddBoxZone('fillNeedle'..k, v.loc, vector3(v.l, v.w, 2.0), v.loc.w or 180.0, {
        {
            label = Bridge.Language.Locale('heroin.targetFill'),
            icon = 'fa-solid fa-syringe',
            action = function()
                if not minigame() then TriggerServerEvent("md-drugs:server:failheroin", k) return end
                if not progressbar(Bridge.Language.Locale('heroin.pbFill'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:fillneedle", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end