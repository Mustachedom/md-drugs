local carryPackage = nil
local onMission = false
local locations = GlobalState.MDDrugsLocations.Oxy
local pdAlert =  90
local vehicle = nil

local function getRoute()
	local Route = Bridge.Callback.Trigger('md-drugs:server:getRoute')
    if not Route then
		Bridge.Notify.SendNotify(Bridge.Language.Locale('oxy.ditchCar'), "error")
		onMission = false
		return false
	end
	local Route = locations.oxylocations[Route]
    SetNewWaypoint(Route.x, Route.y)
	requestModel('g_m_y_famdnf_01', 30000)
    local oxybuyer = CreatePed(0, 'g_m_y_famdnf_01',Route.x,Route.y,Route.z-1, Route.w, false, false)
	Freeze(oxybuyer, true, Route.w)
	local timeOut = 300

	repeat
		Wait(1000)
		timeOut = timeOut - 1
	until #(GetEntityCoords(PlayerPedId()) - vector3(Route.x,Route.y,Route.z)) < 5.0 or timeOut == 0

	PoliceCall(pdAlert)
	Bridge.Target.AddLocalEntity(oxybuyer,{
		{ 
			label = Bridge.Language.Locale('oxy.targetHandoff'),
			icon = "fa-solid fa-dollar-sign",
			action = function()
				if carryPackage then
					if not progressbar(Bridge.Language.Locale('oxy.handingoff')) then return end
					TriggerServerEvent("md-drugs:server:giveoxybox")
					DeleteEntity(oxybuyer)
					DetachEntity(carryPackage, true, true)
					DeleteObject(carryPackage)
					carryPackage = nil
					getRoute()
				else
					Bridge.Notify.SendNotify(Bridge.Language.Locale('oxy.emptyHands'), "error")
				end
			end
		}
	})
end

for k, v in pairs(locations.OxyPayForTruck) do
	Bridge.Target.AddBoxZone('oxyTruckPur' ..k ,  v.loc, vector3(v.l, v.w, 2.0), v.loc.w or 180.0, {
		{
			icon = 'fa-solid fa-truck-fast',
			label = Bridge.Language.Locale('oxy.targetPay'),
			action = function()
				requestModel("burrito3", 30000)

				local paid = Bridge.Callback.Trigger('md-drugs:server:payfortruck', k)
				if not paid then return end
				vehicle = CreateVehicle("burrito3",v.truckSpawn.x, v.truckSpawn.y, v.truckSpawn.z, v.truckSpawn.w, true, false)
				SetVehicleFuelLevel(vehicle, 100.0)
    			local plate = GetVehicleNumberPlateText(vehicle)
				Bridge.VehicleKey.GiveKeys(vehicle, plate)
				Bridge.Notify.SendNotify(Bridge.Language.Locale('oxy.keys'), 'success')
				onMission = true
				TriggerServerEvent('md-drugs:server:startOxyRun', NetworkGetNetworkIdFromEntity(vehicle))
				
				Bridge.Target.AddLocalEntity(vehicle,  {
					{
						icon = "fa-solid fa-box",
						label = Bridge.Language.Locale('oxy.targetGetPackage'),
						action = function()
							if carryPackage then
								Bridge.Notify.SendNotify(Bridge.Language.Locale('oxy.alreadyCarrying'), "error")
							else
								local pos = GetEntityCoords(PlayerPedId(), true)
								Bridge.Anim.RequestDict('anim@heists@box_carry@')
								TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
								requestModel("hei_prop_drug_statue_box_big")
								carryPackage = CreateObject("hei_prop_drug_statue_box_big", pos.x, pos.y, pos.z, true, true, true)
								AttachEntityToEntity(carryPackage, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
							end
						end,
						canInteract = function()
							return handleGang(v.gang)
						end
					}
				})
				Wait(1000)
				getRoute()
			end,
			canInteract = function()
				if onMission then
					return false
				end
				return true
			end
		}
	})

end
