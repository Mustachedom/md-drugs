
local QBCore = exports['qb-core']:GetCoreObject()
local started = nil

local function loadParticle(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
    end
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
    end
    SetPtfxAssetNextCall(dict)
end



function MethCooking()
local animDict, animName = "anim@amb@business@meth@meth_monitoring_cooking@cooking@", "chemical_pour_short_cooker"
lib.requestAnimDict(animDict, 500)
dict = "scr_ornate_heist"
local ped = PlayerPedId()
SetEntityCoords(ped, vector3(1005.773, -3200.402, -38.524))
Wait(1)
local targetPosition = GetEntityCoords(ped)
local animDuration = GetAnimDuration(animDict, animName) * 800
FreezeEntityPosition(ped, true)
local scenePos, sceneRot = vector3(1010.656, -3198.445, -38.925), vector3(0.0, 0.0, 0.0)
local netScene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
NetworkAddPedToSynchronisedScene(ped, netScene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)
local sacid = CreateObjectNoOffset(`bkr_prop_meth_sacid`, targetPosition, 1, 1, 0)
NetworkAddEntityToSynchronisedScene(sacid, netScene, animDict, "chemical_pour_short_sacid", 4.0, -8.0, 1)
local ammonia = CreateObjectNoOffset(`bkr_prop_meth_ammonia`, targetPosition, 1, 1, 0)
NetworkAddEntityToSynchronisedScene(ammonia, netScene, animDict, "chemical_pour_short_ammonia", 4.0, -8.0, 1)
NetworkStartSynchronisedScene(netScene)
Wait(animDuration)
NetworkStopSynchronisedScene(netScene)
DeleteObject(sacid)
DeleteObject(ammonia)
FreezeEntityPosition(ped, false)
lib.requestModel('hei_prop_heist_thermite', 2000)
loadParticle('scr_ornate_heist')

local thermite = CreateObject('hei_prop_heist_thermite', vector3(1005.76, -3201.3, -39.25), true, false, false)
FreezeEntityPosition(thermite, true)
SetEntityRotation(thermite, 190.0, 90.0, 140.0, 3, true )
Wait(1000)
local therm = StartParticleFxLoopedOnEntity('scr_heist_ornate_thermal_burn', thermite, 0.0, 1.4, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
Wait(math.random(10000, 20000))
StopParticleFxLooped(therm, true)
end


function SmashMeth()
local ver = ""
local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char02"
lib.requestAnimDict(animDict, 500)
local ped = PlayerPedId()
local targetPosition = vector3(1012.628, -3194.619, -39.589)
SetEntityCoords(ped, targetPosition)
Wait(1)
local animDuration = GetAnimDuration(animDict, animName) * 800
FreezeEntityPosition(ped, true)
local scenePos, sceneRot = vector3(1008.734, -3196.646, -39.99), vector3(0.0, 0.0, 1.08)
local netScene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
NetworkAddPedToSynchronisedScene(ped, netScene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)
local objects, sceneObjects = {}, {
	{
		hash = `w_me_hammer`,
		animName = "break_weigh_"..ver.."hammer"
	},
	{
		hash = `bkr_Prop_Meth_SmashedTray_01_frag_`,
		animName = "break_weigh_"..ver.."tray01"
	},
	{
		hash = `bkr_Prop_Meth_Tray_02a`,
		animName = "break_weigh_"..ver.."tray01^1"
	},
	{
		hash = `bkr_Prop_Meth_Tray_02a`,
		animName = "break_weigh_"..ver.."tray01^2"
	},
	{
		hash = `bkr_Prop_Meth_SmashedTray_01_frag_`,
		animName = "break_weigh_"..ver.."tray01^3"
	},
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

function BagMeth()
local ver = ""
	local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char01"
	lib.requestAnimDict(animDict, 500)
	local animDuration = GetAnimDuration(animDict, animName) * 1000
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local scenePos, sceneRot = vector3(1008.734, -3196.646, -39.99), vector3(0.0, 0.0, 1.08)
	local scenes = {
	{
		{
			hash = `bkr_prop_meth_bigbag_04a`,
			animName = "break_weigh_"..ver.."box01"
		},
		{
			hash = `bkr_prop_meth_bigbag_03a`,
			animName = "break_weigh_"..ver.."box01^1"
		},
		{
			hash = `bkr_prop_meth_openbag_02`,
			animName = "break_weigh_"..ver.."methbag01"
		}
	},
	{
		{
			hash = `bkr_prop_meth_openbag_02`,
			animName = "break_weigh_"..ver.."methbag01^1"
		},
		{
			hash = `bkr_prop_meth_openbag_02`,
			animName = "break_weigh_"..ver.."methbag01^2"
		},
		{
			hash = `bkr_prop_meth_openbag_02`,
			animName = "break_weigh_"..ver.."methbag01^3"
		}
	},
	{
		{
			hash = `bkr_prop_meth_openbag_02`,
			animName = "break_weigh_"..ver.."methbag01^4"
		},
		{
			hash = `bkr_prop_meth_openbag_02`,
			animName = "break_weigh_"..ver.."methbag01^5"
		},
		{
			hash = `bkr_prop_meth_openbag_02`,
			animName = "break_weigh_"..ver.."methbag01^6"
		}
	},
	{
		{
			hash = `bkr_prop_meth_scoop_01a`,
			animName = "break_weigh_"..ver.."scoop"
		},
		{
			hash = `bkr_prop_coke_scale_01`,
			animName = "break_weigh_"..ver.."scale"
		},
		{
			hash = `bkr_prop_fakeid_penclipboard`,
			animName = "break_weigh_"..ver.."pen"
		}
	},
	{
		{
			hash = `bkr_prop_fakeid_clipboard_01a`,
			animName = "break_weigh_"..ver.."clipboard"
		},
		{
			hash = `bkr_Prop_Meth_Tray_02a`,
			animName = "break_weigh_"..ver.."tray01^5"
		}
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
-- Citizen.Wait(45000)
for i=1, #scenesList, 1 do
	NetworkStopSynchronisedScene(scenesList[i])
end
for i=1, #entitiesList, 1 do
	DeleteEntity(entitiesList[i])
end
RemoveAnimDict(animDict)
FreezeEntityPosition(ped, false)
end

function Tray()
local pos = GetEntityCoords(PlayerPedId(), true)
RequestAnimDict('anim@heists@box_carry@')
while (not HasAnimDictLoaded('anim@heists@box_carry@')) do
Wait(7)
end
TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
RequestModel("bkr_prop_meth_tray_02a")
while not HasModelLoaded("bkr_prop_meth_tray_02a") do
Wait(0)
end
local trays = CreateObject("bkr_prop_meth_tray_02a", pos.x, pos.y, pos.z, true, true, true)
AttachEntityToEntity(trays, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.01,-0.2, -0.2, 20.0, 0.0, 0.0, true, true, false, true, 1, true)
end



function CutCoke()
	local animDict, animName = "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v5_coccutter"
	lib.requestAnimDict(animDict, 500)
	local animDuration = GetAnimDuration(animDict, animName) * 1000
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local scenePos, sceneRot = vector3(1090.37+.9, -3193.61-1.68, -39.60), vector3(0.0, 0.0, 0.00)
	local scenes = {
	{
		{
			hash = `bkr_prop_coke_bakingsoda_o`,
			animName = "coke_cut_v5_bakingsoda"
		},
		{
			hash = `prop_cs_credit_card`,
			animName = "coke_cut_v5_creditcard"
		},
		{
			hash = `prop_cs_credit_card`,
			animName = "coke_cut_v5_creditcard^1"
		}
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

CreateThread(function()

	BikerCocaine = exports['bob74_ipl']:GetBikerCocaineObject()
    BikerCocaine.Style.Set(BikerCocaine.Style.upgrade)
    BikerCocaine.Security.Set(BikerCocaine.Security.upgrade)
    BikerCocaine.Details.Enable({BikerCocaine.Details.cokeBasic1, BikerCocaine.Details.cokeBasic2, BikerCocaine.Details.cokeBasic3}, true)

end)

 function BagCoke()
local ver = ""
	local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char01"
	lib.requestAnimDict(animDict, 500)
	local animDuration = GetAnimDuration(animDict, animName) * 1000
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local scenePos, sceneRot = vector3(1090.62+4.3, -3196.2+3, -38.99-1), vector3(360.0, 360.0, 180.08)
	local scenes = {
	{
		{
			hash = `bkr_prop_coke_cutblock_01`,
			animName = "break_weigh_"..ver.."box01"
		},
		{
			hash = `bkr_prop_coke_fullmetalbowl_02`,
			animName = "break_weigh_"..ver.."box01^1"
		},
		{
			hash = `bkr_prop_coke_cutblock_01`,
			animName = "break_weigh_"..ver.."methbag01"
		}
	},
	{
		{
			hash = `xm3_prop_xm3_bag_coke_01a`,
			animName = "break_weigh_"..ver.."methbag01^1"
		},
		{
			hash = `xm3_prop_xm3_bag_coke_01a`,
			animName = "break_weigh_"..ver.."methbag01^2"
		},
		{
			hash = `xm3_prop_xm3_bag_coke_01a`,
			animName = "break_weigh_"..ver.."methbag01^3"
		}
	},
	{
		{
			hash = `bkr_prop_coke_fullscoop_01a`,
			animName = "break_weigh_"..ver.."scoop"
		},
		{
			hash = `bkr_prop_coke_scale_01`,
			animName = "break_weigh_"..ver.."scale"
		},
		{
			hash = `bkr_prop_fakeid_penclipboard`,
			animName = "break_weigh_"..ver.."pen"
		}
	},
	{
		{
			hash = `bkr_prop_fakeid_clipboard_01a`,
			animName = "break_weigh_"..ver.."clipboard"
		},
		
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
-- Citizen.Wait(45000)
for i=1, #scenesList, 1 do
	NetworkStopSynchronisedScene(scenesList[i])
end
for i=1, #entitiesList, 1 do
	DeleteEntity(entitiesList[i])
end
RemoveAnimDict(animDict)
FreezeEntityPosition(ped, false)
end

function EcstasyEffect()
    local startStamina = 50
    SetFlash(0, 0, 500, 20000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
end


function MethBagEffect()
    local startStamina = 30
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            TrevorEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end


function CokeBaggyEffect()
    local startStamina = 20
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            AlienEffect()
            Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

function SpawnCarPedChase()
local ped = GetEntityCoords(PlayerPedId())
local stoploc = vector3(-1157.63, -3056.71, 13.94)
local start = Config.StartLoc[math.random(1,#Config.StartLoc)]
if started then  --  checks if active
else
    started = true
    lib.requestModel(`pounder`, Config.RequestModelTime)
    lib.requestModel("ig_priest", Config.RequestModelTime)
    lib.requestModel(`cargobob3`, Config.RequestModelTime)
   local leancar = CreateVehicle(`pounder`, start.x+3, start.y-2, start.z-1, 52.0, true, true)
   local driver = CreatePed(26, "ig_priest", start.x, start.y, start.z, 268.9422, true, false)
   local pilot2 = CreatePed(26, "ig_priest", stoploc.x-3, stoploc.y-3, stoploc.z-1, 268.9422, true, false)
	FreezeEntityPosition(pilot2, true)
	SetEntityInvincible(pilot2, true)
    SetEntityAsMissionEntity(leancar)
    AddBlipForEntity(leancar)
    SetPedIntoVehicle(driver, leancar, -1)
    SetPedFleeAttributes(driver,false)
    TaskVehicleDriveToCoordLongrange(driver, leancar, stoploc.x, stoploc.y, stoploc.z-1, 50.0, 524288, 25.0)
    SetPedKeepTask(driver, true) -- everything above is ped/ veh spawn
	repeat -- repeats Wait(1000) only until 
		Wait(1000)
	until #(GetEntityCoords(driver) - stoploc) < 20.0 or GetEntityHealth(driver) == 0 -- either the distance is within 20 OR the driver is dead
	if GetEntityHealth(driver) == 0 then  -- once one of those thing ends, the loop breaks and carries on from here
		if Config.oxtarget then 
			local options = {
				{
					name = 'leancar',
					icon = 'fa-solid fa-car',
					label = 'Steal From Car',
					onSelect = function()
						 if not minigame(2,8) then return end
						TriggerServerEvent('md-drugs:server:givelean')
						started = nil
						if math.random(1,100) <= 30 then
							DeleteVehicle(leancar)
							DeleteEntity(driver)
							DeleteEntity(pilot2)
						 end    
					end,		
				}
			}                
			exports.ox_target:addLocalEntity(leancar, options)
		else	
			exports['qb-target']:AddTargetEntity(leancar, {
    		options = {
    		       {
    		           name = 'leancar',
    		           icon = 'fa-solid fa-car',
    		           label = 'Steal From Car',
    		           action = function()
							if not minigame(2,8) then return end
    		               TriggerServerEvent('md-drugs:server:givelean')
    		               started = nil
    		               if math.random(1,100) <= 30 then
    		                   DeleteVehicle(leancar)
    		                   DeleteEntity(driver)
    		                   DeleteEntity(pilot2)
    		                end    
    		           end,		
    		       }
    		   }                
    		})
		end
	else
		repeat -- this second loop is to spawn the helicopter when the truck is in distance 
			Wait(1000)
		until #(GetEntityCoords(driver) - GetEntityCoords(pilot2)) < 25.0
        Wait( 3 * 1000)
        local heli = CreateVehicle(`cargobob3`, stoploc.x-20, stoploc.y-20, stoploc.z-1, 80, true,true) 
        Wait(1000)
        if DoesEntityExist(heli) then
			SetEntityInvincible(pilot2, false)
            DeleteVehicle(leancar)
            DeleteEntity(driver)
            SetEntityAsMissionEntity(heli)
            SetPedIntoVehicle(pilot2, heli, -1)
            TaskHeliMission(pilot2, heli, 0, 0, -3362.05, 589.45, -13.04, 4, 150.0, 20.0, -1.0, 10, 10, 5.0, 0)
        else    
        	heli = CreateVehicle(`cargobob3`, stoploc.x-20, stoploc.y-20, stoploc.z-1, 80, true,true) 
        end  
     end        
end
end

function SpawnMethCarPedChase()
local ped = GetEntityCoords(PlayerPedId())
local stoploc = vector3(-1157.63, -3056.71, 13.94)
local start = Config.StartLoc[math.random(1,#Config.StartLoc)]
local startedmeth = false

if startedmeth then 
else
    startedmeth = true
    lib.requestModel(`journey`, Config.RequestModelTime)
    lib.requestModel("a_m_m_hillbilly_02", Config.RequestModelTime)
    lib.requestModel(`cargobob3`, Config.RequestModelTime)
    local methcar = CreateVehicle(`journey`, start.x+3, start.y-2, start.z-1, 52.0, true, true)
    local methdriver = CreatePed(26, "a_m_m_hillbilly_02", start.x, start.y, start.z, 268.9422, true, false)
    local methpilot = CreatePed(26, "a_m_m_hillbilly_02", stoploc.x-3, stoploc.y-3, stoploc.z-1, 268.9422, true, false)
	FreezeEntityPosition(methpilot, true)
	SetEntityInvincible(methpilot, true)
    SetEntityAsMissionEntity(methcar)
    AddBlipForEntity(methcar)
    SetPedIntoVehicle(methdriver, methcar, -1)
    SetPedFleeAttributes(methdriver,false)
    TaskVehicleDriveToCoordLongrange(methdriver, methcar, stoploc.x, stoploc.y, stoploc.z-1, 50.0, 524288, 25.0)
    SetPedKeepTask(methdriver, true)
	repeat 
		Wait(1000)
	until #(GetEntityCoords(methdriver) - stoploc) < 20.0 or GetEntityHealth(methdriver) == 0
	if GetEntityHealth(methdriver) == 0 then 
		if Config.oxtarget then 
			local options = {
				{
					name = 'methcar',
					icon = 'fa-solid fa-car',
					label = 'Steal From Car',
					onSelect = function()
						 if not minigame(2,8) then return end
						 TriggerServerEvent('md-drugs:server:givemethingridients')
						 startedmeth = nil
						if math.random(1,100) <= 30 then
							DeleteVehicle(methcar)
                            DeleteEntity(methdriver)
                            DeleteEntity(methpilot)
						 end    
					end,		
				}
			}                
			exports.ox_target:addLocalEntity(methcar, options)
		else	
			exports['qb-target']:AddTargetEntity(methcar, {
    		options = {
    		       {
    		           name = 'methcar',
    		           icon = 'fa-solid fa-car',
    		           label = 'Steal From Car',
    		           action = function()
						if not minigame(2,8) then return end
						TriggerServerEvent('md-drugs:server:givemethingridients')
						startedmeth = nil
					    if math.random(1,100) <= 30 then
						   DeleteVehicle(methcar)
						   DeleteEntity(methdriver)
						   DeleteEntity(methpilot)
						end    
    		           end,		
    		       }
    		   }                
    		})
		end
	else
		repeat
			Wait(1000)
		until #(GetEntityCoords(methdriver) - GetEntityCoords(methpilot)) < 25.0
        Wait( 3 * 1000)
        local methheli = CreateVehicle(`cargobob3`, stoploc.x-20, stoploc.y-20, stoploc.z-1, 80, true,true) 
        Wait(1000)
        if DoesEntityExist(methheli) then
			SetEntityInvincible(methpilot, false)
			CreatePickUpRopeForCargobob(methheli, 1)
            AttachVehicleToCargobob(methheli, methcar, GetEntityBoneIndexByName(methcar, 'bodyshell'), 0.0, 0.0, 0.0)
            DeleteEntity(methdriver)
            SetEntityAsMissionEntity(methheli)
            SetPedIntoVehicle(methpilot, methheli, -1)
            TaskHeliMission(methpilot, methheli, 0, 0, -3362.05, 589.45, -13.04, 4, 150.0, 20.0, -1.0, 10, 10, 5.0, 0)
        else    
        	methheli = CreateVehicle(`cargobob3`, stoploc.x-20, stoploc.y-20, stoploc.z-1, 80, true,true) 
        end  
    end        
end
end

function SetUpPeds()
local 	ped = GetEntityCoords(PlayerPedId())
local	CokePed = CreatePed(0, "g_m_y_famdnf_01", ped.x+3, ped.y-5, ped.z-1, 90.0, true, true)
local	CokePed2 = CreatePed(0,"g_m_y_famdnf_01", ped.x+6, ped.y-10, ped.z-1, 90.0, true, true)
local	CokePed3 = CreatePed(0,"g_m_y_famdnf_01", ped.x+-2, ped.y+5, ped.z-1, 90.0, true, true)
local	CokePed4 = CreatePed(0,"g_m_y_famdnf_01", ped.x+8, ped.y-12, ped.z-1, 90.0, true, true)
local	CokePed5 = CreatePed(0,"g_m_y_famdnf_01", ped.x+5, ped.y-2, ped.z-1, 90.0, true, true)
local	CokePed6 = CreatePed(0,"g_m_y_famdnf_01", ped.x+2, ped.y-20, ped.z-1, 90.0, true, true)
local	CokePed7 = CreatePed(0,"g_m_y_famdnf_01", ped.x+1, ped.y-10, ped.z-1, 90.0, true, true)
AddRelationshipGroup('setups')
local peds = {CokePed, CokePed2,CokePed3, CokePed4, CokePed5,CokePed6, CokePed7}
for k, v in pairs (ped) do 
	SetPedRelationshipGroupDefaultHash(v, 'setups')
end
SetPedArmour(CokePed, 200)
SetPedCanSwitchWeapon(CokePed, true)
GiveWeaponToPed(CokePed, "weapon_pistol", 1, false, true)
TaskCombatPed(CokePed, PlayerPedId(), 0, 16)
GiveWeaponToPed(CokePed2, "weapon_pistol", 1, false, true)
TaskCombatPed(CokePed2, PlayerPedId(), 0, 16)
GiveWeaponToPed(CokePed3, "weapon_pistol", 1, false, true)
TaskCombatPed(CokePed3, PlayerPedId(), 0, 16)
GiveWeaponToPed(CokePed4, "weapon_pistol", 1, false, true)
TaskCombatPed(CokePed4, PlayerPedId(), 0, 16)
GiveWeaponToPed(CokePed5, "weapon_pistol", 1, false, true)
TaskCombatPed(CokePed5, PlayerPedId(), 0, 16)
GiveWeaponToPed(CokePed6, "weapon_pistol", 1, false, true)
TaskCombatPed(CokePed6, PlayerPedId(), 0, 16)
GiveWeaponToPed(CokePed7, "weapon_pistol", 1, false, true)
TaskCombatPed(CokePed7, PlayerPedId(), 0, 16)
SetPedCombatAttributes(CokePed, 46, true)
SetPedCombatAttributes(CokePed2, 46, true)
SetPedCombatAttributes(CokePed3, 46, true)
SetPedCombatAttributes(CokePed4, 46, true)
SetPedCombatAttributes(CokePed5, 46, true)
SetPedCombatAttributes(CokePed6, 46, true)
SetPedCombatAttributes(CokePed7, 46, true)
end

RegisterCommand('DrugRep', function()
	if not Config.TierSystem then return end
	lib.registerContext({
		id = 'DrugRep',
		title = 'Drug Reputation',
		options = {
		  {icon = "fa-solid fa-face-flushed", title = 'Cocaine: '..QBCore.Functions.GetPlayerData().metadata.coke},
		  {icon = "fa-solid fa-syringe", title = 'Heroin: '..QBCore.Functions.GetPlayerData().metadata.heroin},
		  {icon = "fa-solid fa-vial", title = 'LSD: '..QBCore.Functions.GetPlayerData().metadata.lsd},
		  {icon = "fa-solid fa-plug", title = 'Dealer: '..QBCore.Functions.GetPlayerData().metadata.dealerrep},
		}
	  })
	  lib.showContext('DrugRep')
end, false)