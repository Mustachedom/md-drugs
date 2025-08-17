local inside = false
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
    CreateThread(function()
	local animDict, animName = "anim@amb@business@meth@meth_monitoring_cooking@cooking@", "chemical_pour_short_cooker"
    ps.requestModel('ig_priest', 500)
    local worker1 = CreatePed(4, 'ig_priest', coords.x + 1.0, coords.y + 1.0, coords.z - 1.0, 0.0, true, true)
	ps.requestAnim(animDict, 500)
	SetEntityCoords(worker1, coords)
	local targetPosition = GetEntityCoords(worker1)
	local animDuration = GetAnimDuration(animDict, animName) * 800
	FreezeEntityPosition(worker1, true)
	local scenePos, sceneRot = vector3(coords.x + offset.x, coords.y + offset.y, coords.z + offset.z), rotation
	local netScene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
	NetworkAddPedToSynchronisedScene(worker1, netScene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)
	local sacid = CreateObjectNoOffset("bkr_prop_meth_sacid", targetPosition, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(sacid, netScene, animDict, "chemical_pour_short_sacid", 4.0, -8.0, 1)
	local ammonia = CreateObjectNoOffset("bkr_prop_meth_ammonia", targetPosition, 1, 1, 0)
	NetworkAddEntityToSynchronisedScene(ammonia, netScene, animDict, "chemical_pour_short_ammonia", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(netScene)
	Wait(animDuration)
	NetworkStopSynchronisedScene(netScene)
	DeleteObject(sacid) DeleteObject(ammonia)
	FreezeEntityPosition(worker1, false)
	if inside then
        MethCooking(coords, offset, rotation)
    end
        end)
end


local function SmashMeth(coords, offset, rotation)
    CreateThread(function()
	local ver = ""
	local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char02"
	ps.requestAnim(animDict, 500)
	local ped = CreatePed(4, 'ig_priest', coords.x + 1.0, coords.y + 1.0, coords.z - 1.0, 0.0, true, true)
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
    if inside then
        SmashMeth(coords, offset, rotation)
    end
    end)
end

local function BagMeth(coords, offset, rotation)
    CreateThread(function()
	local ver = ""
	local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char01"
	ps.requestAnim(animDict, 500)
	local animDuration = GetAnimDuration(animDict, animName) * 1000
	local ped = CreatePed(4, 'ig_priest', coords.x + 1.0, coords.y + 1.0, coords.z - 1.0, 0.0, true, true)
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
    if inside then
        BagMeth(coords, offset, rotation)
    end
    end)
end

RegisterCommand('TestMethLab', function()
    TriggerServerEvent('TestMethLab')
    Wait(2000)
    SetEntityCoords(PlayerPedId(), vector3(1004.66, -3199.98, -38.99)) -- Example coordinates
end)

RegisterCommand('RestoreMethLab', function()
    TriggerServerEvent('RestoreMethLab')
end)

RegisterCommand('methcook', function()
    local coords = vector3(1006.09, -3200.59, -38.52)
    local offset = vector3(4.79, 2.13, -0.41)
    local rotation = vector3(0.0, 0.0, 0.0)
    inside = true
    MethCooking(coords, offset, rotation)
    SmashMeth(vector3(1012.04, -3194.96, -38.99), vector3(-3.143311, -1.666748, -1.010128), vector3(0,0,0.0))
    BagMeth(vector3(1014.25, -3194.93, -38.99), vector3(-4.9, -1.70, -1.01), vector3(0,0,0.0))
end)