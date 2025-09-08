
local cuttingcoke = nil
local baggingcoke = nil
local locations = ps.callback('md-drugs:server:GetCokeLocations')

local function CutCoke(coords, offset, rotation)
	local animDict, animName = "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v5_coccutter"
	ps.requestAnim(animDict, 500)
	local animDuration = GetAnimDuration(animDict, animName) * 1000
	local ped = PlayerPedId()
	local scenePos, sceneRot = vector3(coords.x + offset.x, coords.y + offset.y,coords.z + offset.z), rotation
	local scenes = {
	{
		{	hash = "bkr_prop_coke_bakingsoda_o",	animName = "coke_cut_v5_bakingsoda"},
		{	hash = "prop_cs_credit_card",	animName = "coke_cut_v5_creditcard"},
		{	hash = "prop_cs_credit_card",	animName = "coke_cut_v5_creditcard^1"}
	},
}
	local scenesList, entitiesList = {}, {}
	for i=1, #scenes, 1 do
		local scene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
		NetworkAddPedToSynchronisedScene(ped, scene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)
		for j=1, #scenes[i], 1 do
			local s = scenes[i][j]
			RequestModel(s.hash)
			while not HasModelLoaded(s.hash) do
				Wait(0)
			end
			local obj = CreateObjectNoOffset(s.hash, coords, true, true, true)
			SetModelAsNoLongerNeeded(s.hash)
			entitiesList[#entitiesList+1] = obj
			NetworkAddEntityToSynchronisedScene(obj, scene, animDict, s.animName, 4.0, -8.0, 1)
		end
		scenesList[#scenesList+1] = scene
	end
	DisableCamCollisionForEntity(ped)
	FreezeEntityPosition(ped, true)
	for i=1, #scenesList, 1 do
		NetworkStartSynchronisedScene(scenesList[i])
	end

	Wait(animDuration-11000)
	for i=1, #scenesList, 1 do
		NetworkStopSynchronisedScene(scenesList[i])
	end
	for i=1, #entitiesList, 1 do
		DeleteEntity(entitiesList[i])
	end
	RemoveAnimDict(animDict)
	FreezeEntityPosition(ped, false)
end

local function BagCoke(coords, offset, rotation)
    local ver = ""
	local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char01"
	ps.requestAnim(animDict, 500)
	local animDuration = GetAnimDuration(animDict, animName) * 1000
	local ped = PlayerPedId()
	local scenePos, sceneRot = vector3(coords.x + offset.x, coords.y + offset.y,coords.z + offset.z), rotation
	local scenes = {
    	{
    		{	hash = "bkr_prop_coke_cutblock_01",	animName = "break_weigh_"..ver.."box01"},
    		{	hash = "bkr_prop_coke_fullmetalbowl_02",	animName = "break_weigh_"..ver.."box01^1"},
    		{	hash = "bkr_prop_coke_cutblock_01",	animName = "break_weigh_"..ver.."methbag01"}
    	},
    	{
    		{	hash = "xm3_prop_xm3_bag_coke_01a",	animName = "break_weigh_"..ver.."methbag01^1"},
    		{	hash = "xm3_prop_xm3_bag_coke_01a",	animName = "break_weigh_"..ver.."methbag01^2"},
    		{	hash = "xm3_prop_xm3_bag_coke_01a",	animName = "break_weigh_"..ver.."methbag01^3"}
    	},
    	{
    		{	hash = "bkr_prop_coke_fullscoop_01a",	animName = "break_weigh_"..ver.."scoop"},
    		{	hash = "bkr_prop_coke_scale_01",	animName = "break_weigh_"..ver.."scale"},
    		{	hash = "bkr_prop_fakeid_penclipboard",	animName = "break_weigh_"..ver.."pen"}
    	},
    	{
    		{	hash = "bkr_prop_fakeid_clipboard_01a",	animName = "break_weigh_"..ver.."clipboard"},
    	}
    }
    local scenesList, entitiesList = {}, {}
    for i=1, #scenes, 1 do
    	local scene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
    	NetworkAddPedToSynchronisedScene(ped, scene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)
    	for j=1, #scenes[i], 1 do
    		local s = scenes[i][j]
    		RequestModel(s.hash)
    		while not HasModelLoaded(s.hash) do
    		Wait(0)
    		end
    		local obj = CreateObjectNoOffset(s.hash, coords, true, true, true)
    		SetModelAsNoLongerNeeded(s.hash)
    		entitiesList[#entitiesList+1] = obj
    		NetworkAddEntityToSynchronisedScene(obj, scene, animDict, s.animName, 4.0, -8.0, 1)
    	end
    	scenesList[#scenesList+1] = scene
    end
    DisableCamCollisionForEntity(ped)
    FreezeEntityPosition(ped, true)
    for i=1, #scenesList, 1 do
    	NetworkStartSynchronisedScene(scenesList[i])
    end

    Wait(animDuration-11000)
    for i=1, #scenesList, 1 do
    	NetworkStopSynchronisedScene(scenesList[i])
    end
    for i=1, #entitiesList, 1 do
    	DeleteEntity(entitiesList[i])
    end
    RemoveAnimDict(animDict)
    FreezeEntityPosition(ped, false)
end

for k, v in pairs (locations.MakePowder) do
    ps.boxTarget('cocaplant'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('coke.targetMakePow'),
            icon = 'fa-solid fa-seedling',
            action = function()
                if not ps.hasItem('coca_leaf') then
                    ps.notify(ps.lang('Catches.itemMissings', ps.getLabel('coca_leaf')), 'error')
                    return
                end
                if not ps.progressbar(ps.lang('coke.makePow'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:makepowder", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

for k, v in pairs (locations.CuttingCoke) do
    ps.boxTarget('cutcoke'..k, v.loc, {length = 1.0, width = 1.0, height = 1.0, rotation = 180.0}, {
        {
            label = ps.lang('coke.targetCutCoke'),
            icon = 'fa-solid fa-mortar-pestle',
            action = function()
                if not ps.hasItem('bakingsoda') then
                    ps.notify(ps.lang('Catches.itemMissings', ps.getLabel('bakingsoda')), 'error')
                    return
                end
                CutCoke(v.loc, v.offset, v.rotation)
				TriggerServerEvent("md-drugs:server:cutcokeone", k)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                if cuttingcoke ~= nil or baggingcoke ~= nil then return false end
                return true
            end,
        }
    })
end

for k, v in pairs (locations.BaggingCoke) do
    ps.boxTarget('bagcoke'..k, v.loc, {length = 1.0, width = 1.0, height = 1.0, rotation = 180.0}, {
        {
            label = ps.lang('coke.targetBagCoke'),
            icon = 'fa-solid fa-sack-xmark',
            action = function()
                if not ps.hasItem('empty_weed_bag') then
                    ps.notify(ps.lang('Catches.itemMissings', ps.getLabel('empty_weed_bag')), 'error')
                    return
                end
                BagCoke(v.loc, v.offset, v.rotation)
				TriggerServerEvent("md-drugs:server:bagcoke", k)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                if cuttingcoke ~= nil or baggingcoke ~= nil then return false end
                return true
            end
        }
    })
end

for k, v in pairs (locations.cokeTele) do
	ps.boxTarget('coke_tele'..k, v.inside, {length = v.l, width = v.w, heading = v.rot}, {
		{
			icon = 'fa-solid fa-door-open',
			label = ps.lang('coke.teleOut'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.outside)
			end,
			canInteract = function()
                return handleGang(v.gang)
            end
		}
	})
	ps.boxTarget('coke_teleout'..k, v.outside, {length = v.l, width = v.w, heading = v.rot}, {
		{
			icon = 'fa-solid fa-door-closed',
			label = ps.lang('coke.teleIn'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.inside)
			end,
			canInteract = function()
                return handleGang(v.gang)
            end
		}
	})
end

CreateThread(function()
	BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
    BikerCocaine.Style.Set(BikerCocaine.Style.upgrade)
    BikerCocaine.Security.Set(BikerCocaine.Security.upgrade)
    BikerCocaine.Details.Enable({BikerCocaine.Details.cokeBasic1, BikerCocaine.Details.cokeBasic2, BikerCocaine.Details.cokeBasic3}, true)
end)

