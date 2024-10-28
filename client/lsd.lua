local QBCore = exports['qb-core']:GetCoreObject()
local tableout = false


local function createLabKit(coord, head)
    local labkit = CreateObject("v_ret_ml_tablea", coord.x, coord.y, coord.z - 1, true, false)
    SetEntityHeading(labkit, head)
    PlaceObjectOnGroundProperly(labkit)
    local options = {
        { event = "md-drugs:client:heatliquid", icon = "fa-solid fa-temperature-high", label = Lang.targets.lsd.heat, data = labkit },
        { event = "md-drugs:client:refinequalityacid", icon = "fa-solid fa-temperature-high", label = Lang.targets.lsd.refine, data = labkit },
        { event = "md-drugs:client:maketabpaper", icon = "fa-regular fa-note-sticky", label = Lang.targets.lsd.dab, data = labkit },
        { event = "md-drugs:client:getlabkitback", icon = "fas fa-box-circle-check", label = Lang.targets.lsd.back, data = labkit, canInteract = function() return tableout end }
    }
    AddMultiModel(labkit, options, labkit)
end

CreateThread(function() 
    local Ped = "g_m_y_famdnf_01"
	lib.requestModel(Ped, Config.RequestModelTime)
	local tabdealer = CreatePed(0, Ped,Config.buylsdlabkit.x,Config.buylsdlabkit.y,Config.buylsdlabkit.z-1, Config.buylsdlabkit.w, false, false)
    Freeze(tabdealer, true, Config.buylsdlabkit.w)
    AddSingleModel(tabdealer,{ type = "client", label = Lang.targets.lsd.buy, icon = "fa-solid fa-money-bill", event = "md-drugs:client:buylabkit", distance = 2.0}, tabdealer )
end)


RegisterNetEvent("md-drugs:client:getlysergic", function(data) 
    if not minigame() then return end
	if not progressbar(Lang.lsd.steallys, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:getlysergic",data.data)
end)


RegisterNetEvent("md-drugs:client:getdiethylamide", function(data) 
    if not minigame() then return end
	if not progressbar(Lang.lsd.stealdie, 4000, 'uncuff') then return end
    TriggerServerEvent('md-drugs:server:getdiethylamide', data.data)
end)

RegisterNetEvent("md-drugs:client:setlsdlabkit", function()
if tableout then 
    Notify(Lang.lsd.tableout, 'error')
    TriggerServerEvent('md-drugs:server:getlabkitback')
else
    tableout = true
    local loc, head = StartRay()
    if not loc then tableout = false TriggerServerEvent('md-drugs:server:getlabkitback') return end
	if not progressbar(Lang.lsd.place, 4000, 'uncuff') then TriggerServerEvent('md-drugs:server:getlabkitback') return end
	createLabKit(loc, head)
end
end)

RegisterNetEvent("md-drugs:client:getlabkitback", function(data) 
    if not progressbar(Lang.lsd.tablepack, 4000, 'uncuff') then return end
	DeleteObject(data.data)
	TriggerServerEvent('md-drugs:server:getlabkitback')
    tableout = false
end)

RegisterNetEvent("md-drugs:client:heatliquid", function(data) 
	local PedCoords, head = GetEntityCoords(data.data), GetEntityHeading(data.data)
	local dict = "scr_ie_svm_technical2"
    if not ItemCheck('lysergic_acid') then return end
    if not ItemCheck('diethylamide') then return end
	if not minigame() then
        TriggerServerEvent("md-drugs:server:failheating")
		DeleteObject(data.data)
		local dirtylabkit = CreateObject("v_ret_ml_tablea", PedCoords.x, PedCoords.y, PedCoords.z-1, true, false)
        SetEntityHeading(dirtylabkit, head)
		loadParticle(dict)
	    exitPtfx = StartParticleFxLoopedOnEntity("scr_dst_cocaine", dirtylabkit, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
		PlaceObjectOnGroundProperly(dirtylabkit)
        SetParticleFxLoopedAlpha(exitPtfx, 3.0)
        Wait(100)
        AddMultiModel(dirtylabkit, {   event = "md-drugs:client:cleanlabkit",   icon = "fa-solid fa-hand-sparkles",   label = Lang.targets.lsd.clean, data = dirtylabkit}, nil )
        return end
    if not progressbar(Lang.lsd.heat, 7000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:heatliquid")
end)

RegisterNetEvent("md-drugs:client:cleanlabkit", function(data)
    if not ItemCheck('cleaningkit')  then return end
    if not progressbar(Lang.lsd.clean, 4000, 'clean') then return end
    local check = lib.callback.await('md-drugs:server:removecleaningkit')
    if check then 
        local coord, head = GetEntityCoords(data.data), GetEntityHeading(data.data)
        DeleteObject(data.data)
        createLabKit(coord, head)
	end
end)

RegisterNetEvent("md-drugs:client:refinequalityacid", function()
    if not ItemCheck('lsd_one_vial')  then return end 
    if not minigame() then TriggerServerEvent("md-drugs:server:failrefinequality") return end
    if not progressbar(Lang.lsd.refine, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:refinequalityacid")
end)

RegisterNetEvent("md-drugs:client:maketabpaper", function()
    if not ItemCheck('tab_paper')  then return end 
    if not minigame() then TriggerServerEvent("md-drugs:server:failtabs") return end
	if not progressbar(Lang.lsd.dip, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:maketabpaper")
end)

RegisterNetEvent("md-drugs:client:buytabs", function(data) 
	if not progressbar(Lang.lsd.buypaper, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:gettabpaper", data.data)
end)


RegisterNetEvent("md-drugs:client:buylabkit", function()
    if QBCore.Functions.HasItem('lsdlabkit') then Notify(Lang.lsd.hav, 'error') return end 
	if not progressbar(Lang.lsd.buykit, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:getlabkit")
end)
