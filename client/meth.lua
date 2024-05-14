local QBCore = exports['qb-core']:GetCoreObject()
local amonia = nil
local tray = nil
local heated = nil
local active = nil

local function startcook()
	if amonia == nil then
		active = true
		TriggerServerEvent("md-drugs:server:startcook")
		MethCooking()
		amonia = true
	else
		Notify(Lang.meth.inside, "error")
	end
end

local function dials()
	if amonia == true then
		if not minigame(2, 8) then
			AddExplosion(1005.773, -3200.402, -38.524, 49, 10, true, false, true, true)
			ClearPedTasks(PlayerPedId())
			amonia = nil
			active = nil
		return end
		Notify(Lang.meth.increaseheat, "success")
		ClearPedTasks(PlayerPedId())
		heated = true	
	else
	end
end

local function smash()
if tray then
	tray = false
	DeleteObject(trays)
	local bucket = CreateObject(`bkr_prop_meth_bigbag_03a`, vector3(1012.85, -3194.29, -39.2), true, true, true)
	SetEntityHeading(bucket, 90.0)
	SmashMeth()

	local options = {
		{
			name = 'bucket',
			icon = 'fa-solid fa-car',
			label = 'Bag Meth',
			action = function()
				DeleteObject(bucket)
				amonia = nil
				heated = nil
				tray = nil
				active = nil
				BagMeth()
				TriggerServerEvent('md-drugs:server:getmeth')
				
			end,

		}
	}
	local optionsox = {
		{
			name = 'bucket',
			icon = 'fa-solid fa-car',
			label = 'Bag Meth',
			onSelect = function()
				DeleteObject(bucket)
				amonia = nil
				heated = nil
				tray = nil
				active = nil
				BagMeth()
				TriggerServerEvent('md-drugs:server:getmeth')
			end,

		}
	}
	if Config.oxtarget then
        exports.ox_target:addLocalEntity(bucket,  optionsox)
    else 
	    exports['qb-target']:AddTargetEntity(bucket, {options = options, distance = 2.0})
    end   
end	
end

local function trayscarry()
	if amonia then
		local pos = GetEntityCoords(PlayerPedId(), true)
		RequestAnimDict('anim@heists@box_carry@')
		while (not HasAnimDictLoaded('anim@heists@box_carry@')) do
			Wait(7)
		end
		TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false,
			false)
		RequestModel("bkr_prop_meth_tray_02a")
		while not HasModelLoaded("bkr_prop_meth_tray_02a") do
			Wait(0)
		end
		 trays = CreateObject("bkr_prop_meth_tray_02a", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(trays, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.01, -0.2,
			-0.2, 20.0, 0.0, 0.0, true, true, false, true, 1, true)
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

CreateThread(function()
	exports['qb-target']:AddBoxZone("methteleout", Config.MethTeleIn, 1.5, 1.75, { name = "methteleout", heading = 11.0, debugPoly = false, minZ = Config.MethTeleIn.z - 2, maxZ = Config.MethTeleIn.z + 2,}, {
		options = {
			{name = 'teleout',	icon = "fas fa-sign-in-alt",	label = "Enter Building",	action = function()		SetEntityCoords(PlayerPedId(), Config.MethTeleOut)	end},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("methtelein", Config.MethTeleOut, 1.5, 1.75, {name = "methtelein",heading = 11.0,debugPoly = false,minZ = Config.MethTeleOut.z - 2,maxZ = Config.MethTeleOut.z + 2,}, {
		options = {
			{ name = 'teleout', icon = "fas fa-sign-in-alt", label = "Exit Building", action = function() 	SetEntityCoords(PlayerPedId(), Config.MethTeleIn) end },
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("maze", vector3(-95.55, -806.73, 44.04), 1.5, 1.75, { name = "maze", heading = 11.0, debugPoly = false, minZ = 44 - 2, maxZ = 44 + 2, }, {
		options = {
			{	name = 'die',	icon = "fas fa-sign-in-alt",	label = "dont click this",	action = function()		SetEntityCoords(PlayerPedId(), vector3(-75.36, -837.24, 318.93))	end},
		},
		distance = 2.5
	})
	local itemreqcook = { "ephedrine", "acetone" }
	exports['qb-target']:AddBoxZone("ingridientsmeth", vector3(1005.7, -3201.28, -39.55), 1.5, 1.75,{ name = "ingridientsmeth", heading = 11.0, debugPoly = false, minZ = -39 - 2, maxZ = -39 + 2,}, {
		options = {
			{ name = 'methcook', icon = "fas fa-sign-in-alt", label = "Cook Meth", item = itemreqcook, action = function() 	startcook() end,
				canInteract = function()
					if amonia == nil and active == nil then
						return true
					end
			  end,
			},
			{ name = 'grabtray', icon = "fas fa-sign-in-alt", label = "Grab Tray", distance = 5, action = function() 	trayscarry() end,
			  canInteract = function()
					if heated and amonia and tray == nil then return true end
			  end,
			},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("boxmeth", vector3(1012.15, -3194.04, -39.20), 1.5, 1.75,{	name = "boxmeth",	heading = 3.0,	debugPoly = false,	minZ = -39 - 2,	maxZ = -39 + 2,}, {
		options = {
			{name = 'boxmeth',icon = "fas fa-sign-in-alt",label = "Box Up Meth",distance = 5,action = function()	smash()end,
				canInteract = function()
					if tray then return true end
				end,
			},
		},
	})
	exports['qb-target']:AddBoxZone("adjustdials", vector3(1007.89, -3201.17, -38.99), 1.5, 1.75,{	name = "adjustdials",	heading = 11.0,	debugPoly = false,	minZ = -39 - 2,	maxZ = -39 + 2,}, {
		options = {
			{	name = 'adjustdials',	icon = "fas fa-sign-in-alt",	label = "Adjust Dials",	distance = 5,	action = function()		dials()	end,
				canInteract = function()
					if amonia and heated == nil then return true end end
			},
		},
	})
	if Config.MethHeist == false then
		for k, v in pairs (Config.MethEph) do 
			if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
			exports['qb-target']:AddBoxZone("methep"..k, v.loc, v.l, v.w, { name = "methep"..k, heading = v.rot, minZ = v.loc.z - 1.0, maxZ = v.loc.z + 2.0,}, {
				options = {
					{icon = "fas fa-sign-in-alt",	label = "Steal Ephedrine", event = 'md-drugs:client:stealeph', data = k,
					canInteract = function()
						if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
				},
				},
				distance = 2.5
			})
		end
		for k, v in pairs (Config.Methace) do 
			if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
			exports['qb-target']:AddBoxZone("methace"..k, v.loc, v.l, v.w, { name = "methace"..k, heading = v.rot, minZ = v.loc.z - 1.0, maxZ = v.loc.z + 2.0,}, {
				options = {
					{icon = "fas fa-sign-in-alt",	label = "Steal Acetone", event = 'md-drugs:client:stealace', data = k,
					canInteract = function()
						if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
				},
				},
				distance = 2.5
			})
		end
	end
end)

CreateThread(function()
if Config.MethHeist == false then
else
	local current = "g_m_y_famdnf_01"
	lib.requestModel(current, Config.RequestModelTime)
	local CurrentLocation = Config.MethHeistStart
	local methdealer = CreatePed(0, current, CurrentLocation.x, CurrentLocation.y, CurrentLocation.z - 1, false, false)
	FreezeEntityPosition(methdealer, true)
	SetEntityHeading(methdealer, 220.0)
	SetEntityInvincible(methdealer, true)
	exports['qb-target']:AddTargetEntity(methdealer, {
		options = {
			{
				label = "Get Mission",
				icon = "fas fa-eye",
				action = function()
					Notify(Lang.meth.mission, "success")
					SpawnMethCarPedChase()
				end,
			},
		}
	})
end
end)
RegisterNetEvent("md-drugs:client:stealeph", function(data)
	if not progressbar('Stealing Ephedrine', 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:geteph", data.data)
end)

RegisterNetEvent("md-drugs:client:stealace", function(data)
	if not progressbar('Stealing Acetone', 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:getace", data.data)
end)


