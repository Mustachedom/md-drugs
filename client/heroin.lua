
local herointable = false
local dirty = false
local locations = ps.callback('md-drugs:server:GetHeroinLocations')

local function createLabKit(coord, head)
    local heroinlabkit = CreateObject("v_ret_ml_tablea", coord.x, coord.y, coord.z - 1, true, false,false)
    SetEntityHeading(heroinlabkit, head)
    PlaceObjectOnGroundProperly(heroinlabkit)
    ps.entityTarget(heroinlabkit, {
        {
            icon = "fa-solid fa-temperature-high",
            label = ps.lang('heroin.targetCook'),
            action = function()
            if not ps.hasItem('emptyvial') then
                ps.notify(ps.lang('Catches.itemMissings', ps.getLabel('emptyvial')), 'error')
                return
            end

            if not minigame() then
                dirty = true
                TriggerServerEvent("md-drugs:server:failheatingheroin")
	        	ps.requestPTFX("core")
	            local heroinkit = StartParticleFxLoopedOnEntity("exp_air_molotov", heroinlabkit, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
                SetParticleFxLoopedAlpha(heroinkit, 3.0)
	        	SetPedToRagdoll(PlayerPedId(), 1300, 1300, 0, 0, 0, 0)
	        return end

            if not ps.progressbar(ps.lang('heroin.pbCook'), 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:heatliquidheroin")
        end,
        canInteract = function()
            if not dirty then return true end
        end
    },
    {
        icon = "fas fa-box-circle-check",
        label = ps.lang('heroin.targetPickup'),
        action = function()
            if not ps.progressbar(ps.lang('heroin.pbPickup'), 4000, 'uncuff') then return end
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
        label = ps.lang('heroin.targetClean'),
        action = function()
            if not ps.hasItem('cleaningkit') then
                ps.notify(ps.lang('Catches.itemMissings', ps.getLabel('cleaningkit')), 'error')
                return
            end
            if not ps.progressbar(ps.lang('heroin.pbClean'), 4000, 'clean') then return end
	        local done = ps.callback('removeCleaningkit', false)
            if done then dirty = false end
        end,
        canInteract = function()
            if dirty then return true end
            return false
        end
    }})
end

for k, v in pairs (locations.dryplant) do
    ps.boxTarget('dryHeroin'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('heroin.targetDry'),
            icon = 'fa-solid fa-temperature-high',
            action = function()
                if not ps.progressbar(ps.lang('heroin.pbDry'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:dryplant", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

for k, v in pairs (locations.cutheroinone) do
    ps.boxTarget('cutHeroin'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('heroin.targetCutHeroin'),
            icon = 'fa-solid fa-seedling',
            action = function()
                if not ps.hasItem('bakingsoda') then
                    ps.notify(ps.lang('Catches.itemMissings', ps.getLabel('bakingsoda')), 'error')
                    return
                end
	            if not ps.progressbar(ps.lang('heroin.pbCutHeroin'), 4000, 'uncuff') then return end
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
    ps.requestModel(v.ped, 1000)
    peds[k] = CreatePed(4, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
    Freeze(peds[k], true, v.loc.w)
    SetBlockingOfNonTemporaryEvents(peds[k], true)
    SetEntityInvincible(peds[k], true)
    ps.entityTarget(peds[k], {
        {
            label = ps.lang('heroin.targetBuyKit'),
            icon = 'fa-solid fa-box-open',
            action = function()
               if not ps.progressbar(ps.lang('heroin.pbBuyKit'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:getheroinlabkit", k)
            end,
            canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
        }
    })
end


ps.registerCallback("md-drugs:client:setheroinlabkit", function() 
    if herointable then
       ps.notify(ps.lang('heroin.tableout'), 'error')
       return false
    else
        herointable = true
        local location, head = StartRay()
        if not location then herointable = false return end
        if not ps.progressbar(ps.lang('heroin.placing'), 4000, 'uncuff') then return end
    	createLabKit(location, head)
        return true, location
    end
end)

for k, v in pairs (locations.fillneedle) do
    ps.boxTarget('fillNeedle'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('heroin.targetFill'),
            icon = 'fa-solid fa-syringe',
            action = function()
                if not minigame() then TriggerServerEvent("md-drugs:server:failheroin", k) return end
                if not ps.progressbar(ps.lang('heroin.pbFill'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:fillneedle", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end