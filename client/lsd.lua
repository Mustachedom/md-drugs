local tableout = false
local dirtylsd = false
local locations = ps.callback('md-drugs:server:GetLSDLocations')

local function loadParticle(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
    end
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
    end
    SetPtfxAssetNextCall(dict)
end

local function createLabKit(coord, head)
    local labkit = CreateObject("v_ret_ml_tablea", coord.x, coord.y, coord.z - 1, true, false)
    SetEntityHeading(labkit, head)
    PlaceObjectOnGroundProperly(labkit)
    FreezeEntityPosition(labkit, true)
    tableout = true
    local options = {
        {
            icon = "fa-solid fa-temperature-high",
            label = ps.lang('lsd.targetHeat'),
            action = function()
	            local dict = "scr_ie_svm_technical2"
	            if not minigame() then
                    dirtylsd = true
	            	loadParticle(dict)
	                local exitPtfx = StartParticleFxLoopedOnEntity("scr_dst_cocaine", labkit, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
                    SetParticleFxLoopedAlpha(exitPtfx, 3.0)
                    return
                end
                if not ps.progressbar(ps.lang('lsd.heating'), 7000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:heatliquid")
            end,
            canInteract = function()
                if not dirtylsd then return true end
            end
        },
        {
            icon = "fa-solid fa-temperature-high",
            label = ps.lang('lsd.targetRefine'),
            action = function()
                if not ps.hasItem('lsd_one_vial') then
                    ps.notify(ps.lang('Catches.itemNeeded', ps.getLabel('lsd_one_vial')), 'error')
                    return
                end
                if not minigame() then TriggerServerEvent("md-drugs:server:failrefinequality") return end
                if not ps.progressbar(ps.lang('lsd.refining'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:refinequalityacid")
            end,
            canInteract = function()
                if not dirtylsd then return true end
            end
        },
        {
            icon = "fa-regular fa-note-sticky",
            label = ps.lang('lsd.targetDipping'),
            action = function()
                if not ps.hasItem('tab_paper') then
                    ps.notify(ps.lang('Catches.itemNeeded', ps.getLabel('tab_paper')), 'error')
                    return
                end
                if not minigame() then TriggerServerEvent("md-drugs:server:failtabs") return end
                if not ps.progressbar(ps.lang('lsd.dipping'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:maketabpaper")
            end,
            canInteract = function()
                if not dirtylsd then return true end
            end
        },
        {
            event = "md-drugs:client:getlabkitback",
            icon = "fas fa-box-circle-check",
            label = ps.lang('lsd.targetPickup'),
            action = function()
                if not ps.progressbar(ps.lang('lsd.packup'), 4000, 'uncuff') then return end
	            DeleteObject(labkit)
	            TriggerServerEvent('md-drugs:server:getlabkitback')
                tableout = false
            end,
            canInteract = function()
                if not dirtylsd then return true end
            end
        },
        {
            icon = "fa-solid fa-hand-sparkles",
            label = ps.lang('lsd.targetClean'),
            action = function()
                if not ps.hasItem('cleaningkit') then
                    ps.notify(ps.lang('Catches.itemNeeded', ps.getLabel('cleaningkit')), 'error')
                    return
                end
                if not ps.progressbar(ps.lang('lsd.cleaning'), 4000, 'clean') then return end
                local check = ps.callback('md-drugs:server:removecleaningkit')
                if check then
                    dirtylsd = false
                end
            end,
            canInteract = function() if dirtylsd then return true end end
        }
    }
    ps.entityTarget(labkit, options)
end

for k, v in pairs (locations.lysergicacid) do 
    ps.boxTarget('lysergicacid'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('lsd.targetLys'),
            icon = 'fa-solid fa-temperature-high',
            action = function()
                if not minigame() then TriggerServerEvent("md-drugs:server:faillysergic") return end
                if not ps.progressbar(ps.lang('lsd.stealLys'), 4000, 'uncuff') then return end
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
    ps.boxTarget('diethylamide'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('lsd.targetDie'),
            icon = 'fa-solid fa-temperature-high',
            action = function()
                if not minigame() then TriggerServerEvent("md-drugs:server:faildiethylamide") return end
                if not ps.progressbar(ps.lang('lsd.stealDie'), 4000, 'uncuff') then return end
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
    ps.boxTarget('gettabs'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('lsd.targetBuyTab'),
            icon = 'fa-solid fa-hand-holding-dollar',
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
    ps.requestModel(v.ped, 1000)
    seller[k] = CreatePed(4, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
    Freeze(seller[k], true, v.loc.w)
    ps.entityTarget(seller[k], {
        {
            label = ps.lang('lsd.targetBuyKit'),
            icon = 'fa-solid fa-hand-holding-dollar',
            action = function()
                if ps.hasItem('lsdlabkit') then
                    ps.notify(ps.lang('lsd.alreadyOwn'), 'error')
                    return
                end
                if not ps.progressbar(ps.lang('lsd.buyingKit'), 4000, 'uncuff') then return end
                TriggerServerEvent('md-drugs:server:getlabkit', k)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                return true
            end
        }
    })
end

ps.registerCallback("md-drugs:client:setlsdlabkit", function()
    if tableout then
        ps.notify(ps.lang('lsd.tableout'), 'error')
        return false
    else
        tableout = true
        local loc, head = StartRay()
        if not loc then tableout = false return end
        if not ps.progressbar(ps.lang('lsd.placing'), 4000, 'uncuff') then return end
        createLabKit(loc, head)
        return true, loc
    end

end)
