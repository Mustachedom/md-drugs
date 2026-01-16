local amonia, tray, heated, active, trays, startedmeth, methVan = false, false, false, false, nil, false, nil
local locations = GlobalState.MDDrugsLocations.Meth
--- meth heist 


local function SpawnMethCarPedChase(loc)
	local stoploc = vector3(-1157.63, -3056.71, 13.94)
	local start = locations.StartLoc[math.random(1,#locations.StartLoc)]
	if startedmeth then
		Bridge.Notify.SendNotify(Bridge.Language.Locale('meth.alreadyChasing'),'error')
	else
	    startedmeth = true
	    requestModel("journey", 30000)
	    requestModel("a_m_m_hillbilly_02", 30000)
	    requestModel("cargobob3", 30000)
	    methVan = CreateVehicle("journey", start.x+3, start.y-2, start.z-1, 52.0, true, false)
	    local methdriver = CreatePed(26, "a_m_m_hillbilly_02", start.x, start.y, start.z, 268.9422, false, false)
	    local methpilot = CreatePed(26, "a_m_m_hillbilly_02", stoploc.x-3, stoploc.y-3, stoploc.z-1, 268.9422, false, false)
		local can = Bridge.Callback.Trigger('md-drugs:server:registerMeth', loc, NetworkGetNetworkIdFromEntity(methVan))
		if not can then
			startedmeth = false
			DeleteVehicle(methVan)
			DeleteEntity(methdriver)
			DeleteEntity(methpilot)
			return
		end
		FreezeEntityPosition(methpilot, true)
		SetEntityInvincible(methpilot, true)
	    SetEntityAsMissionEntity(methVan)
	    AddBlipForEntity(methVan)
	    SetPedIntoVehicle(methdriver, methVan, -1)
	    SetPedFleeAttributes(methdriver,false)
	    TaskVehicleDriveToCoordLongrange(methdriver, methVan, stoploc.x, stoploc.y, stoploc.z-1, 50.0, 524288, 25.0)
	    SetPedKeepTask(methdriver, true)

		repeat
			Wait(1000)
		until #(GetEntityCoords(methdriver) - stoploc) < 20.0 or GetEntityHealth(methdriver) == 0

		if GetEntityHealth(methdriver) == 0 then
			Bridge.Target.AddLocalEntity(methVan, {
				{
					name = 'methcar',
					icon = 'fa-solid fa-car',
					label = Bridge.Language.Locale('meth.targetStealFromCar'),
					action = function()
						if not minigame() then return end
				 		TriggerServerEvent('md-drugs:server:givemethingridients', NetworkGetNetworkIdFromEntity(methVan))
				 		startedmeth = false
						DeleteEntity(methdriver)
						DeleteEntity(methpilot)
					end,
				}
			})
		else
			DeleteVehicle(methVan)
			DeleteEntity(methdriver)
			DeleteEntity(methpilot)
	    end
	end
end

local peds = {}
for k, v in pairs (locations.MethHeist) do
	peds[k] = CreatePed(4, GetHashKey(v.ped), v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, true)
	Freeze(peds[k], true, v.loc.w)
	Bridge.Target.AddLocalEntity(peds[k], {
		{
			icon = 'fa-solid fa-user-secret',
			label = Bridge.Language.Locale('meth.targetHeist'),
			action = function()
				if startedmeth then Bridge.Notify.SendNotify(Bridge.Language.Locale('meth.alreadyChasing'),'error') return end
				SpawnMethCarPedChase(k)
			end,
			canInteract = function()
				return handleGang(v.gang)
			end
		}
	})
end

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

local function dialSuccess(coords)
	requestModel('hei_prop_heist_thermite', 2000)
	loadParticle('scr_ornate_heist')
	local thermite = CreateObject('hei_prop_heist_thermite', coords.x - 0.5, coords.y - 0.5, coords.z -0.5, true, false, false)
	FreezeEntityPosition(thermite, true)
	SetEntityVisible(thermite, false)
	Wait(1000)
	local therm = StartParticleFxLoopedOnEntity('scr_heist_ornate_thermal_burn', thermite, 0.0, 1.4, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
	Wait(math.random(10000, 20000))
	StopParticleFxLooped(therm, true)
	DeleteObject(thermite)
end

local function MethCooking(coords, offset, rotation)
	local animDict, animName = "anim@amb@business@meth@meth_monitoring_cooking@cooking@", "chemical_pour_short_cooker"
	Bridge.Anim.RequestDict(animDict)
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
end


local function SmashMeth(coords, offset, rotation)
	local ver = ""
	local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char02"
	Bridge.Anim.RequestDict(animDict, 500)
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
	Bridge.Anim.RequestDict(animDict, 500)
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
		local adding = Bridge.Callback.Trigger('md-drugs:server:startcook', num)
		if not adding then return end
		active = true
		MethCooking(coords, offset, rotation)
		amonia = true
	else
		Bridge.Notify.SendNotify(Bridge.Language.Locale('meth.started'), "error")
	end
end


local function dials(coords)
	if amonia then
		if not minigame() then
			AddExplosion(coords.x, coords.y,coords.z, 49, 10, true, false, true)
			amonia = false
			active = false
			return
		end
		Bridge.Notify.SendNotify(Bridge.Language.Locale('meth.increaseHeat'), "success")
		dialSuccess(coords)
		heated = true
	end
end

local function smash(coords, offset, rotation, buckets, k)
	if active and tray and amonia and heated then
		DeleteObject(trays)
		tray = false
		local bucket = CreateObject("bkr_prop_meth_bigbag_03a", buckets.x, buckets.y, buckets.z, true, true, true)
		Freeze(bucket, true, buckets.w)
		SmashMeth(coords, offset, rotation)
		Wait(100)
		Bridge.Target.AddLocalEntity(bucket, {
			{
				name = 'bucket',
				icon = "fa-solid fa-sack-xmark",
				label = Bridge.Language.Locale('meth.targetBag'),
				action = function()
					DeleteObject(bucket)
					active = false
					amonia = false
					heated = false
					tray = false
					BagMeth(locations.BagMeth[k].loc, locations.BagMeth[k].offset, locations.BagMeth[k].rotation)
					TriggerServerEvent('md-drugs:server:getmeth', k)
				end,
				canInteract = function()
					if not active then return false end
					return true
				end,
			}
		})
	end
end

local function trayscarry()
	if amonia and heated then
		local pos = GetEntityCoords(PlayerPedId(), true)
		Bridge.Anim.RequestDict('anim@heists@box_carry@')
		TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
		requestModel('bkr_prop_meth_tray_02a')	
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

for k, v in pairs (locations.CookMeth) do
	Bridge.Target.AddBoxZone('cookMeth'..k, v.loc, vector3(v.l, v.w, 2.0), v.loc.w or 180.0, {
		{
			label = Bridge.Language.Locale('meth.targetCook'),
			icon = 'fa-solid fa-temperature-high',
			action = function()
				startcook(k, v.loc, v.offset or vec3(0,0,0), v.rotation or vector3(0,0,180.0))
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				if not amonia and not active then
					return true
				end
			end,
		},
		{
			icon = "fas fa-sign-in-alt",
			label = Bridge.Language.Locale('meth.targetGrabTray'),
			action = function() trayscarry() end,
		  	canInteract = function()
				if not handleGang(v.gang) then return false end
				if heated and amonia and not tray then
					return true
				end
		  	end,
		},
	})
end

for k, v in pairs (locations.MethDials) do
	Bridge.Target.AddBoxZone('adjustMethDials'..k, v.loc, vector3(v.l, v.w, 1.0), v.loc.w or 180.0, {
		{
			name = 'adjustdials',
			icon = "fa-solid fa-temperature-three-quarters",
			label = Bridge.Language.Locale('meth.targetHeat'),
			action = function()
				dials(locations.CookMeth[k].loc)
			end,
			--canInteract = function()
			--	if not handleGang(v.gang) then return false end
			--	if amonia and heated == false then return true end
			--end
		}
	})
end

for k, v in pairs (locations.MethSmash) do
	Bridge.Target.AddBoxZone('smashMeth'..k, v.loc, vector3(v.l, v.w, 1.0), v.loc.w or 180.0, {
		{
			name = 'smash',
			icon = "fa-solid fa-weight-scale",
			label = Bridge.Language.Locale('meth.targetSmash'),
			action = function()
				smash(v.loc, v.offset, v.rotation, v.bucket,k)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				if heated and amonia and tray then return true end
			end
		}
	})
end

for k, v in pairs (locations.MethTele) do
	Bridge.Target.AddBoxZone('meth_tele'..k, v.inside, vector3(v.l, v.w, 1.0), v.rot, {
		{
			icon = 'fa-solid fa-door-open',
			label = Bridge.Language.Locale('coke.teleOut'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.outside)
			end,
			canInteract = function()
                return handleGang(v.gang)
            end
		}
	})
	Bridge.Target.AddBoxZone('meth_teleout'..k, v.outside, vector3(v.l, v.w, 1.0), v.rot, {
		{
			icon = 'fa-solid fa-door-closed',
			label = Bridge.Language.Locale('coke.teleIn'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.inside)
			end,
			canInteract = function()
                return handleGang(v.gang)
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

for k, v in pairs (locations.MethEph) do
	Bridge.Target.AddBoxZone('stealMethEph'..k, v.loc, vector3(v.l, v.w, 1.0), v.loc.w or 180.0, {
		{
			label = Bridge.Language.Locale('meth.targetStealEPH'),
			icon = 'fa-solid fa-bucket',
			action = function()
				if not progressbar(Bridge.Language.Locale('meth.stealingEPH'), 4000, 'uncuff') then return end
				TriggerServerEvent("md-drugs:server:geteph", k)
			end,
			canInteract = function()
				return handleGang(v.gang)
			end
		}
	})
end
for k, v in pairs (locations.MethAce) do
	Bridge.Target.AddBoxZone('stealMethAce'..k, v.loc, vector3(v.l, v.w, 1.0), v.loc.w or 180.0, {
		{
			label = Bridge.Language.Locale('meth.targetStealACE'),
			icon = 'fa-solid fa-bucket',
			action = function()
				if not progressbar(Bridge.Language.Locale('meth.stealingACE'), 4000, 'uncuff') then return end
				TriggerServerEvent("md-drugs:server:getace", k)
			end,
			canInteract = function()
				return handleGang(v.gang)
			end
		}
	})

end