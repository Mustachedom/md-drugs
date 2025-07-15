
local herointable = false
local dirty = false

local function createLabKit(coord, head)
    local heroinlabkit = CreateObject("v_ret_ml_tablea", coord.x, coord.y, coord.z - 1, true, false,false)
    SetEntityHeading(heroinlabkit, head)
    PlaceObjectOnGroundProperly(heroinlabkit)
    ps.entityTarget(heroinlabkit, {
        {
            icon = "fa-solid fa-temperature-high",
            label = ps.lang('Heroin.cook'),
            action = function()
            if not ps.hasItem('emptyvial') then return end
            if not minigame() then
                dirty = true
                TriggerServerEvent("md-drugs:server:failheatingheroin")
	        	ps.requestPTFX("core")
                lib.requestNamedPtfxAsset("core")
	            local heroinkit = StartParticleFxLoopedOnEntity("exp_air_molotov", heroinlabkit, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
                SetParticleFxLoopedAlpha(heroinkit, 3.0)
	        	SetPedToRagdoll(PlayerPedId(), 1300, 1300, 0, 0, 0, 0)
	        return end
            if not ps.progressbar(ps.lang('Heroin.success'), 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:heatliquidheroin")
        end,
        canInteract = function()
            if not dirty then return true end
        end
    },
    {
        icon = "fas fa-box-circle-check",
        label = ps.lang('Heroin.up'),
        action = function()
            if not ps.progressbar(ps.lang('Heroin.pickup'), 4000, 'uncuff') then return end
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
        event = "md-drugs:client:cleanheroinlabkit",
        icon = "fa-solid fa-hand-sparkles",
        label = ps.lang('Heroin.clean'),
        action = function()
            if not ps.hasItem('cleaningkit') then return end
            if not ps.progressbar(ps.lang('Heroin.clean'), 4000, 'clean') then return end
	        local done = ps.callback('removeCleaningkit', false)
            if done then dirty = false end
        end,
        canInteract = function()
            if dirty then return true end
            return false
        end
    }})
end

for k, v in pairs (GlobalState.MDDrugsLocs.dryplant) do
    ps.boxTarget('dryHeroin'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('targets.heroin.dry'),
            icon = 'fa-solid fa-temperature-high',
            action = function()
                if not ps.progressbar(ps.lang('Heroin.dryout'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:dryplant", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

for k, v in pairs (GlobalState.MDDrugsLocs.cutheroinone) do
    ps.boxTarget('cutHeroin'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('targets.heroin.cut'),
            icon = 'fa-solid fa-seedling',
            action = function()
                if not ps.hasItem('bakingsoda') then return end
	            if not ps.progressbar(ps.lang('Heroin.cutting'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:cutheroin", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

RegisterNetEvent("md-drugs:client:buyheroinlabkit", function()
    if not ps.progressbar(ps.lang('Heroin.secret'), 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:getheroinlabkit")
end)

ps.registerCallback("md-drugs:client:setheroinlabkit", function() 
    if herointable then
       ps.notify(ps.lang('Heroin.tableout'), 'error')
       return false
    else
        herointable = true
        local location, head = StartRay()
        if not location then herointable = false return end
        if not ps.progressbar(ps.lang('Heroin.table'), 4000, 'uncuff') then return end
    	createLabKit(location, head)
        return true, location
    end
end)

for k, v in pairs (GlobalState.MDDrugsLocs.fillneedle) do
    ps.boxTarget('fillNeedle'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('targets.heroin.fill'),
            icon = 'fa-solid fa-syringe',
            action = function()
                if not minigame() then TriggerServerEvent("md-drugs:server:failheroin", k) return end
                if not ps.progressbar(ps.lang('Heroin.needles'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:fillneedle", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end