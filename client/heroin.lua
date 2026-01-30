
local herointable = false
local dirty = false
repeat Wait(100) until GlobalState.MDDrugsLocations.Heroin ~= nil
local locations = GlobalState.MDDrugsLocations.Heroin

local function createLabKit(coord, head)
    local heroinlabkit = CreateObject("v_ret_ml_tablea", coord.x, coord.y, coord.z - 1, true, false,false)
    SetEntityHeading(heroinlabkit, head)
    PlaceObjectOnGroundProperly(heroinlabkit)
    Bridge.Target.AddLocalEntity(heroinlabkit, {
        {
            icon = Bridge.Language.Locale('heroin.cookIcon'),
            label = Bridge.Language.Locale('heroin.targetCook'),
            action = function()
            if not itemCheck('emptyvial') then return end

            if not minigame() then
                dirty = true
                TriggerServerEvent("md-drugs:server:failheatingheroin")
                local coords = GetEntityCoords(heroinlabkit)
                AddExplosion(coords.x, coords.y, coords.z-1.0, 34, 0.0, true, false, true)
                SetParticleFxLoopedAlpha(heroinkit, 3.0)
	        	SetPedToRagdoll(PlayerPedId(), 1300, 1300, 0, 0, 0, 0)
	            return
            end
            if not progressbar(Bridge.Language.Locale('heroin.pbCook')) then return end
            TriggerServerEvent("md-drugs:server:heatliquidheroin")
        end,
        canInteract = function()
            if not dirty then return true end
        end
    },
    {
        icon = Bridge.Language.Locale('heroin.targetPickupIcon'),
        label = Bridge.Language.Locale('heroin.targetPickup'),
        action = function()
            if not progressbar(Bridge.Language.Locale('heroin.pbPickup')) then return end
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
        icon = Bridge.Language.Locale('heroin.targetCleanIcon'),
        label = Bridge.Language.Locale('heroin.targetClean'),
        action = function()
            if not itemCheck('cleaningkit') then return end
            if not progressbar(Bridge.Language.Locale('heroin.pbClean'), 4000, 'clean') then return end
	        local done = Bridge.Callback.Trigger('md-drugs:server:removeCleaningKitHeroin', false)
            if done then dirty = false end
        end,
        canInteract = function()
            if dirty then return true end
            return false
        end
    }})
    targets[#targets+1] = heroinlabkit
end

for k, v in pairs (locations.dryplant) do
    Bridge.Target.AddBoxZone('dryHeroin'..k,   v.loc, v.size, v.loc.w or 180.0,   {
        {
            label = Bridge.Language.Locale('heroin.targetDry'),
            icon = Bridge.Language.Locale('heroin.dryIcon'),
            action = function()
                if not progressbar(Bridge.Language.Locale('heroin.pbDry')) then return end
	            TriggerServerEvent("md-drugs:server:dryplant", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
    targets[#targets+1] = 'dryHeroin'..k
end

for k, v in pairs (locations.cutheroinone) do
    Bridge.Target.AddBoxZone('cutHeroin'..k, v.loc, v.size, v.loc.w or 180.0,  {
        {
            label = Bridge.Language.Locale('heroin.targetCutHeroin'),
            icon = Bridge.Language.Locale('heroin.cutIcon'),
            action = function()
                if not itemCheck('bakingsoda') then return end
	            if not progressbar(Bridge.Language.Locale('heroin.pbCutHeroin')) then return end
	            TriggerServerEvent("md-drugs:server:cutheroin", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
    targets[#targets+1] = 'cutHeroin'..k
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
            icon = Bridge.Language.Locale('heroin.buyIcon'),
            action = function()
               if not progressbar(Bridge.Language.Locale('heroin.pbBuyKit')) then return end
	            TriggerServerEvent("md-drugs:server:getheroinlabkit", k)
            end,
            canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
        }
    })
    targets[#targets+1] = peds[k]
end


Bridge.Callback.Register("md-drugs:client:setheroinlabkit", function() 
    if herointable then
       Bridge.Notify.SendNotify(Bridge.Language.Locale('heroin.tableout'), 'error')
       return false
    else
        herointable = true
        local location, head = StartRay()
        if not location then herointable = false return end
        if not progressbar(Bridge.Language.Locale('heroin.placing')) then return end
    	createLabKit(location, head)
        return true, location
    end
end)

for k, v in pairs (locations.fillneedle) do
    Bridge.Target.AddBoxZone('fillNeedle'..k, v.loc, v.size, v.loc.w or 180.0, {
        {
            label = Bridge.Language.Locale('heroin.targetFill'),
            icon = Bridge.Language.Locale('heroin.fillNeedleIcon'),
            action = function()
                if not minigame() then TriggerServerEvent("md-drugs:server:failheroin", k) return end
                if not progressbar(Bridge.Language.Locale('heroin.pbFill')) then return end
                TriggerServerEvent("md-drugs:server:fillneedle", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
    targets[#targets+1] = 'fillNeedle'..k
end