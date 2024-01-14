local QBCore = exports['qb-core']:GetCoreObject()
local amonia = nil
local tray = nil
local heated = nil


CreateThread(function()
	BikerMethLab = exports['bob74_ipl']:GetBikerMethLabObject()
	BikerMethLab.Style.Set(BikerMethLab.Style.upgrade)
	BikerMethLab.Security.Set(BikerMethLab.Security.upgrade)
	BikerMethLab.Details.Enable(BikerMethLab.Details.production, true)
	RefreshInterior(BikerMethLab.interiorId)
end)

CreateThread(function()
	exports['qb-target']:AddBoxZone("methteleout", Config.MethTeleIn, 1.5, 1.75, { -- 963.37, .z-2122.95, 31.47
		name = "methteleout",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.MethTeleIn.z - 2,
		maxZ = Config.MethTeleIn.z + 2,
	}, {
		options = {
			{
				name = 'teleout',
				icon = "fas fa-sign-in-alt",
				label = "Enter Building",
				action = function()
					SetEntityCoords(PlayerPedId(), Config.MethTeleOut)
				end,

			},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("methtelein", Config.MethTeleOut, 1.5, 1.75, { -- 963.37, .z-2122.95, 31.47
		name = "methtelein",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.MethTeleOut.z - 2,
		maxZ = Config.MethTeleOut.z + 2,
	}, {
		options = {
			{
				name = 'teleout',
				icon = "fas fa-sign-in-alt",
				label = "Exit Building",
				action = function()
					SetEntityCoords(PlayerPedId(), Config.MethTeleIn)
				end,

			},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("maze", vector3(-95.55, -806.73, 44.04), 1.5, 1.75, { -- 963.37, .z-2122.95, 31.47
		name = "maze",
		heading = 11.0,
		debugPoly = false,
		minZ = 44 - 2,
		maxZ = 44 + 2,
	}, {
		options = {
			{
				name = 'die',
				icon = "fas fa-sign-in-alt",
				label = "dont click this",
				action = function()
					SetEntityCoords(PlayerPedId(), vector3(-75.36, -837.24, 318.93))
				end,

			},
		},
		distance = 2.5
	})
	local itemreqcook = { "ephedrine", "acetone" }
	exports['qb-target']:AddBoxZone("ingridientsmeth", vector3(1005.7, -3201.28, -39.55), 1.5, 1.75,
		{                                                                                        -- 963.37, .z-2122.95, 31.47
			name = "ingridientsmeth",
			heading = 11.0,
			debugPoly = false,
			minZ = -39 - 2,
			maxZ = -39 + 2,
		}, {
		options = {
			{
				name = 'methcook',
				icon = "fas fa-sign-in-alt",
				label = "Cook Meth",
				item = itemreqcook,
				action = function()
					if amonia == nil then
						amonia = true
						TriggerServerEvent("md-drugs:server:startcook")
						MethCooking()
						exports['qb-target']:AddBoxZone("adjustdials", vector3(1007.89, -3201.17, -38.99), 1.5, 1.75,
							{                                                                      -- 963.37, .z-2122.95, 31.47
								name = "adjustdials",
								heading = 11.0,
								debugPoly = false,
								minZ = -39 - 2,
								maxZ = -39 + 2,
							}, {
							options = {
								{
									name = 'adjustdials',
									icon = "fas fa-sign-in-alt",
									label = "Adjust Dials",
									distance = 5,
									action = function()
										if amonia == true then
											exports['ps-ui']:Circle(function(success)
												if success then
													QBCore.Functions.Notify("Increasing Heat", "success")
													ClearPedTasks(PlayerPedId())
													heated = true
													exports['qb-target']:RemoveZone("adjustdials")
												else
													AddExplosion(1005.773, -3200.402, -38.524, 49, 10, true, false, true, true)
													ClearPedTasks(PlayerPedId())
													amonia = nil
													exports['qb-target']:RemoveZone("adjustdials")
												end
											end, 2, 8) -- NumberOfCircles,
										else
										end
									end,
								},
							},
						})
					else
						QBCore.Functions.Notify("Theres Stuff Inside", "error")
					end
				end,
				canInteract = function()
					if amonia == nil then
						return true
					end
				end,
			},
			{
				name = 'grabtray',
				icon = "fas fa-sign-in-alt",
				label = "Grab Tray",
				distance = 5,
				action = function()
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
						local trays = CreateObject("bkr_prop_meth_tray_02a", pos.x, pos.y, pos.z, true, true, true)
						AttachEntityToEntity(trays, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.01, -0.2,
							-0.2, 20.0, 0.0, 0.0, true, true, false, true, 1, true)
						tray = true
						exports['qb-target']:AddBoxZone("boxmeth", vector3(1012.15, -3194.04, -39.20), 1.5, 1.75,
							{                                                                  -- 963.37, .z-2122.95, 31.47
								name = "boxmeth",
								heading = 3.0,
								debugPoly = false,
								minZ = -39 - 2,
								maxZ = -39 + 2,
							}, {
							options = {
								{
									name = 'boxmeth',
									icon = "fas fa-sign-in-alt",
									label = "Box Up Meth",
									distance = 5,
									action = function()
										if tray then
											tray = false
											DeleteObject(trays)
											local bucket = CreateObject(`bkr_prop_meth_bigbag_03a`, vector3(1012.85, -3194.29, -39.2), true, true, true)
											SetEntityHeading(bucket, 90.0)
											SmashMeth()
											exports['qb-target']:RemoveZone("boxmeth")
											exports['qb-target']:AddTargetEntity(bucket, {
												options = {
													{
														name = 'bucket',
														icon = 'fa-solid fa-car',
														label = 'Bag Meth',
														action = function()
															DeleteObject(bucket)
															amonia = nil
															heated = nil
															tray = nil
															BagMeth()
															TriggerServerEvent('md-drugs:server:getmeth')
														end,

													}
												},
											})
										end
									end,
									canInteract = function()
										if tray then return true end
									end,
								},
							},
						})
					end
				end,
				canInteract = function()
					if heated and amonia and tray == nil then return true end
				end,
			},
		},
		distance = 2.5
	})
end)

CreateThread(function()
	local current = "g_m_y_famdnf_01"
	lib.requestModel(current, 1000)
	local CurrentLocation = Config.MethHeistStart
	methdealer = CreatePed(0, current, CurrentLocation.x, CurrentLocation.y, CurrentLocation.z - 1, false, false)
	FreezeEntityPosition(methdealer, true)
	SetEntityHeading(methdealer, 220.0)
	SetEntityInvincible(methdealer, true)
	exports['qb-target']:AddTargetEntity(methdealer, {
		options = {
			{
				label = "Get Mission",
				icon = "fas fa-eye",
				action = function()
					SpawnMethCarPedChase()
					QBCore.Functions.Notify("Car Has Been Marked On Your Map", "success")
				end,
			},
		}
	})
end)
