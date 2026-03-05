local cuttingcoke = nil
local baggingcoke = nil
local locations = Config.Cocaine.Locations

local function CutCoke(coords, offset, rotation)
	cuttingcoke = true
	local animDict, animName = "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v5_coccutter"
	Bridge.Anim.RequestDict(animDict, 500)
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
	cuttingcoke = nil
end

local function BagCoke(coords, offset, rotation)
baggingcoke = true
    local ver = ""
	local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char01"
	Bridge.Anim.RequestDict(animDict, 500)
	local animDuration = GetAnimDuration(animDict, animName) * 1000
	local ped = PlayerPedId()
	local scenePos, sceneRot = vector3(coords.x + offset.x, coords.y + offset.y,coords.z + offset.z +0.03), rotation
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
	baggingcoke = nil
end

for k, v in pairs (locations.MakePowder) do
    Bridge.Target.AddBoxZone('cocaplant'..k, v.loc, v.size, v.loc.w or 180.0, {
        {
            label = Bridge.Language.Locale('coke.targetMakePow'),
            icon = Bridge.Language.Locale('coke.targetMakePowIcon'),
            action = function()
                if not itemCheck('coca_leaf') then return end
                if not progressbar(Bridge.Language.Locale('coke.makePow')) then return end
	            TriggerServerEvent("md-drugs:server:makepowder", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
	targets[#targets+1] = 'cocaplant'..k
end

for k, v in pairs (locations.CuttingCoke) do
    Bridge.Target.AddBoxZone('cutcoke'..k,  v.loc, v.size, v.loc.w or 180.0,  {
        {
            label = Bridge.Language.Locale('coke.targetCutCoke'),
            icon = Bridge.Language.Locale('coke.targetCutCokeIcon'),
            action = function()
                if not itemCheck('bakingsoda') then return end
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
	targets[#targets+1] = 'cutcoke'..k
end

for k, v in pairs (locations.BaggingCoke) do
    Bridge.Target.AddBoxZone('bagcoke'..k, v.loc, v.size, v.loc.w or 180.0, {
        {
            label = Bridge.Language.Locale('coke.targetBagCoke'),
            icon = Bridge.Language.Locale('coke.targetBagCokeIcon'),
            action = function()
                if not itemCheck('empty_weed_bag') then return end
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
	targets[#targets+1] = 'bagcoke'..k
end

for k, v in pairs (locations.cokeTele) do
	Bridge.Target.AddBoxZone('coke_tele'..k, v.inside, v.size, v.inside.w or 180.0,{
		{
			icon = Bridge.Language.Locale('coke.teleOutIcon'),
			label = Bridge.Language.Locale('coke.teleOut'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.outside)
			end,
			canInteract = function()
                return handleGang(v.gang)
            end
		}
	})
	targets[#targets+1] = 'coke_tele'..k
	Bridge.Target.AddBoxZone('coke_teleout'..k, v.outside, v.size, v.outside.w or 180.0,{
		{
			icon = Bridge.Language.Locale('coke.teleInIcon'),
			label = Bridge.Language.Locale('coke.teleIn'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.inside)
			end,
			canInteract = function()
                return handleGang(v.gang)
            end
		}
	})
	targets[#targets+1] = 'coke_teleout'..k
end

CreateThread(function()
	BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
    BikerCocaine.Style.Set(BikerCocaine.Style.upgrade)
    BikerCocaine.Security.Set(BikerCocaine.Security.upgrade)
    BikerCocaine.Details.Enable({BikerCocaine.Details.cokeBasic1, BikerCocaine.Details.cokeBasic2, BikerCocaine.Details.cokeBasic3}, true)
end)

