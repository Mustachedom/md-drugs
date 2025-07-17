local amonia = false
local tray = false
local heated = false
local active = false
local trays = nil
---- start animation shit
local function loadParticle(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
    end
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
    end
    SetPtfxAssetNextCall(dict)
end

local function MethCooking(coords, offset, rotation)
	local animDict, animName = "anim@amb@business@meth@meth_monitoring_cooking@cooking@", "chemical_pour_short_cooker"
	ps.requestAnim(animDict, 500)
	SetEntityCoords(PlayerPedId(), coords)
	local targetPosition = GetEntityCoords(PlayerPedId())
	local animDuration = GetAnimDuration(animDict, animName) * 800
	FreezeEntityPosition(PlayerPedId(), true)
	local scenePos, sceneRot = vector3(coords.x + offset.x, coords.y + offset.y, coords.z + offset.z), rotation
	local netScene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(PlayerPedId(), netScene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)
	local sacid = CreateObjectNoOffset("bkr_prop_meth_sacid", targetPosition, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(sacid, netScene, animDict, "chemical_pour_short_sacid", 4.0, -8.0, 1)
	local ammonia = CreateObjectNoOffset("bkr_prop_meth_ammonia", targetPosition, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(ammonia, netScene, animDict, "chemical_pour_short_ammonia", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(netScene)
	Wait(animDuration)
	NetworkStopSynchronisedScene(netScene)
	DeleteObject(sacid) DeleteObject(ammonia)
	FreezeEntityPosition(PlayerPedId(), false)
	ps.requestModel('hei_prop_heist_thermite', 2000)
	loadParticle('scr_ornate_heist')
	local thermite = CreateObject('hei_prop_heist_thermite', vector3(1005.76, -3201.3, -39.25), true, false, false)
	FreezeEntityPosition(thermite, true)
	SetEntityRotation(thermite, 190.0, 90.0, 140.0, 3, true )
	Wait(1000)
	local therm = StartParticleFxLoopedOnEntity('scr_heist_ornate_thermal_burn', thermite, 0.0, 1.4, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
	Wait(math.random(10000, 20000))
	StopParticleFxLooped(therm, true)
end


local function SmashMeth(coords, offset, rotation)
	local ver = ""
	local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char02"
	ps.requestAnim(animDict, 500)
	local ped = PlayerPedId()
	local targetPosition = coords
	SetEntityCoords(ped, targetPosition)
	Wait(1)
	local animDuration = GetAnimDuration(animDict, animName) * 800
	FreezeEntityPosition(ped, true)
	local scenePos, sceneRot = vector3(coords.x + offset.x, coords.y + offset.y, coords.z + offset.z), rotation
	local netScene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(ped, netScene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)
	local objects, sceneObjects = {}, {
		{	hash = "w_me_hammer",	animName = "break_weigh_" .. ver .. "hammer"},
		{	hash = "bkr_Prop_Meth_SmashedTray_01_frag_",	animName = "break_weigh_"..ver.."tray01"},
		{	hash = "bkr_Prop_Meth_Tray_02a",	animName = "break_weigh_"..ver.."tray01^1"},
		{	hash = "bkr_Prop_Meth_Tray_02a",	animName = "break_weigh_"..ver.."tray01^2"},
		{	hash = "bkr_Prop_Meth_SmashedTray_01_frag_",	animName = "break_weigh_"..ver.."tray01^3"},
	}
	for i=1, #sceneObjects, 1 do
		local obj = CreateObjectNoOffset(sceneObjects[i].hash, targetPosition, true, true, true)
		NetworkAddEntityToSynchronisedScene(obj, netScene, animDict, sceneObjects[i].animName, 4.0, -8.0, 1)
		objects[#objects+1] = obj
	end
	NetworkStartSynchronisedScene(netScene)
	Wait(animDuration)
	NetworkStopSynchronisedScene(netScene)
	for i=1, #objects, 1 do
		DeleteObject(objects[i])
	end
	RemoveAnimDict(animDict)
	FreezeEntityPosition(ped, false)
end

local function BagMeth(coords, offset, rotation)
	local ver = ""
	local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char01"
	ps.requestAnim(animDict, 500)
	local animDuration = GetAnimDuration(animDict, animName) * 1000
	local ped = PlayerPedId()
	SetEntityCoords(ped, coords)
	local scenePos, sceneRot = vector3(coords.x + offset.x, coords.y + offset.y, coords.z + offset.z), rotation
	local scenes = {
	{
		{	hash = "bkr_prop_meth_bigbag_04a",	animName = "break_weigh_"..ver.."box01"},
		{	hash = "bkr_prop_meth_bigbag_03a",	animName = "break_weigh_"..ver.."box01^1"},
		{	hash = "bkr_prop_meth_openbag_02",	animName = "break_weigh_"..ver.."methbag01"}
	},
	{
		{	hash = "bkr_prop_meth_openbag_02",	animName = "break_weigh_"..ver.."methbag01^1"},
		{	hash = "bkr_prop_meth_openbag_02",	animName = "break_weigh_"..ver.."methbag01^2"},
		{	hash = "bkr_prop_meth_openbag_02",	animName = "break_weigh_"..ver.."methbag01^3"}
	},
	{
		{	hash = "bkr_prop_meth_openbag_02",	animName = "break_weigh_"..ver.."methbag01^4"},
		{	hash = "bkr_prop_meth_openbag_02",	animName = "break_weigh_"..ver.."methbag01^5"},
		{	hash = "bkr_prop_meth_openbag_02",	animName = "break_weigh_"..ver.."methbag01^6"}
	},
	{
		{	hash = "bkr_prop_meth_scoop_01a",	animName = "break_weigh_"..ver.."scoop"},
		{	hash = "bkr_prop_coke_scale_01",	animName = "break_weigh_"..ver.."scale"},
		{	hash = "bkr_prop_fakeid_penclipboard",	animName = "break_weigh_"..ver.."pen"}
	},
	{
		{	hash = "bkr_prop_fakeid_clipboard_01a",	animName = "break_weigh_"..ver.."clipboard"},
		{	hash = "bkr_Prop_Meth_Tray_02a",	animName = "break_weigh_"..ver.."tray01^5"}
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
---------------------- end animation shit
---

local function startcook(num, coords, offset, rotation)
	if not amonia then
		local adding = ps.callback('md-drugs:server:startcook', num)
		if not adding then return end
		active = true
		amonia = true
		MethCooking(coords, offset, rotation)
		amonia = true
	else
		ps.notify(ps.lang('meth.inside'), "error")
	end
end


local function dials(coords)
	if amonia == true then
		if not ps.minigame('ps-circle', {amount = 2, speed = 8}) then
			AddExplosion(coords.x, coords.y,coords.z, 49, 10, true, false, true)
			amonia = false
			active = false
		return end
		ps.notify(ps.lang('meth.increaseheat'), "success")
		heated = true
	end
end

local function smash(coords, offset, rotation, buckets, k)
	if tray then
		tray = false
		DeleteObject(trays)
		local bucket = CreateObject("bkr_prop_meth_bigbag_03a", buckets.x, buckets.y, buckets.z, true, true, true)
		Freeze(bucket, true, buckets.w)
		ps.entityTarget(bucket, {
			{
				name = 'bucket',
				icon = "fa-solid fa-sack-xmark",
				label = ps.lang('targets.meth.bag'),
				canInteract = function()
					if active == false then return false end
				end,
				action = function()
					DeleteObject(bucket)
					active = false
					amonia = false
					heated = false
					tray = false
					BagMeth(GlobalState.MDDrugsLocs.BagMeth[k].loc, GlobalState.MDDrugsLocs.BagMeth[k].offset, GlobalState.MDDrugsLocs.BagMeth[k].rotation)
					TriggerServerEvent('md-drugs:server:getmeth', k)
				end,
			}
		})
		SmashMeth(coords, offset, rotation)
		Wait(100)
	end
end

local function trayscarry()
	if amonia then
		local pos = GetEntityCoords(PlayerPedId(), true)
		ps.requestAnim('anim@heists@box_carry@')
		TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
		ps.requestModel('bkr_prop_meth_tray_02a')	
		trays = CreateObject("bkr_prop_meth_tray_02a", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(trays, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.01, -0.2,-0.2, 20.0, 0.0, 0.0, true, true, false, true, 1, true)
		tray = true
	end
end

CreateThread(function()
	BikerMethLab = exports['bob74_ipl']:GetBikerMethLabObject()
	BikerMethLab.Style.Set(BikerMethLab.Style.upgrade)
	BikerMethLab.Security.Set(BikerMethLab.Security.upgrade)
	BikerMethLab.Details.Enable(BikerMethLab.Details.production, true)
	RefreshInterior(BikerMethLab.interiorId)
end)

for k, v in pairs (GlobalState.MDDrugsLocs.CookMeth) do
	ps.boxTarget('cookMeth'..k, v.loc, {length = v.l, width = v.w, rotation = v.rot, height = 1.0},{
		{
			label = 'Cook Meth',
			icon = 'fa-solid fa-temperature-high',
			action = function()
				 startcook(k, v.loc, v.offset or vec3(0,0,0), v.rotation or vector3(0,0,180.0))
			end,
			canInteract = function()
				if not amonia and not active then
					return true
				end
			end,
		},
		{
			icon = "fas fa-sign-in-alt",
			label = ps.lang('targets.meth.tray'),
			action = function() trayscarry() end,
		  	canInteract = function()
				if heated and amonia and not tray then
					return true
				end
		  	end,
		},
	})
end

for k, v in pairs (GlobalState.MDDrugsLocs.MethDials) do 
	ps.boxTarget('adjustMethDials'..k, v.loc, {length = v.l, width = v.w, rotation = v.rot, height = 1.0},{
		{
			name = 'adjustdials',
			icon = "fa-solid fa-temperature-three-quarters",
			label = ps.lang('targets.meth.adjust'),
			action = function()
				dials(GlobalState.MDDrugsLocs.CookMeth[k].loc)
			end,
			canInteract = function()
				if amonia and heated == false then return true end
			end
		}
	})
end

for k, v in pairs (GlobalState.MDDrugsLocs.MethSmash) do
	ps.boxTarget('smashMeth'..k, v.loc, {length = v.l, width = v.w, rotation = v.rot, height = 1.0},{
		{
			name = 'smash',
			icon = "fa-solid fa-weight-scale",
			label = ps.lang('targets.meth.smash'),
			action = function()
				smash(v.loc, v.offset, v.rotation, v.bucket,k)
			end,
			canInteract = function()
				if heated and amonia and tray then return true end
			end
		}
	})
end

RegisterCommand('offset', function()
	local pos = GetEntityCoords(PlayerPedId())
	Wait(4000)
	local offset = GetEntityCoords(PlayerPedId()) - pos
	print("Offset: ", offset)
end)

if not Config.MethHeist then
	for k, v in pairs (GlobalState.MDDrugsLocs.MethEph) do
		ps.boxTarget('stealMethEph'..k, v.loc, {length = v.l, width = v.w, rotation = v.rot, height = 1.0},{
			{
				label = 'Steal Ephedrine',
				icon = 'fa-solid fa-bucket',
				action = function()
					if not ps.progressbar('Stealing Ephedrine', 4000, 'uncuff') then return end
					TriggerServerEvent("md-drugs:server:geteph", k)
				end,
			}
		})
	end

	for k, v in pairs (GlobalState.MDDrugsLocs.Methace) do
		ps.boxTarget('stealMethAce'..k, v.loc, {length = v.l, width = v.w, rotation = v.rot, height = 1.0},{
			{
				label = 'Steal Acetone',
				icon = 'fa-solid fa-bucket',
				action = function()
					if not ps.progressbar('Stealing Acetone', 4000, 'uncuff') then return end
					TriggerServerEvent("md-drugs:server:getace", k)
				end,
			}
		})
	end
end