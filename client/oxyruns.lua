local carryPackage = nil
local onMission = false
local locations = ps.callback('md-drugs:server:GetOxyLocs')
local pdAlert =  90

local function getRoute()
	local Route = ps.callback('md-drugs:server:getRoute')
    if not Route then
		ps.notify(ps.lang('oxy.ditchCar'), "error")
		onMission = false
		return false
	end

    SetNewWaypoint(Route.x, Route.y)
	ps.requestModel('g_m_y_famdnf_01', 30000)
    local oxybuyer = CreatePed(0, 'g_m_y_famdnf_01',Route.x,Route.y,Route.z-1, Route.w, false, false)
	Freeze(oxybuyer, true, Route.w)
	local timeOut = 300

	repeat
		Wait(1000)
		timeOut = timeOut - 1
	until #(GetEntityCoords(PlayerPedId()) - vector3(Route.x,Route.y,Route.z)) < 5.0 or timeOut == 0

	PoliceCall(pdAlert)
	ps.entityTarget(oxybuyer,{
		{ 
			label = ps.lang('oxy.targetHandoff'),
			icon = "fa-solid fa-dollar-sign",
			action = function()
				if carryPackage then
					if not ps.progressbar(ps.lang('oxy.handingoff'), 4000, 'uncuff') then return end
					TriggerServerEvent("md-drugs:server:giveoxybox")
					DeleteEntity(oxybuyer)
					DetachEntity(carryPackage, true, true)
					DeleteObject(carryPackage)
					carryPackage = nil
					getRoute()
				else
					ps.notify(ps.lang('oxy.emptyHands'), "error")
				end
			end
		}
	})
end

for k, v in pairs(locations.OxyPayForTruck) do
	ps.boxTarget('oxyTruckPur' ..k , v.loc, {length = v.l, width = v.w, heading = v.rot}, {
		{
			icon = 'fa-solid fa-truck-fast',
			label = ps.lang('oxy.targetPay'),
			action = function()
				ps.requestModel("burrito3", 30000)

				local paid = ps.callback('md-drugs:server:payfortruck', false)
				if not paid then return end
				local oxycar = CreateVehicle("burrito3",v.truckSpawn.x, v.truckSpawn.y, v.truckSpawn.z, v.truckSpawn.w, true, false)

    			if Config.Fuel == "ox_fuel" then
					Entity(oxycar).state.fuel = 100.0
				else
    				exports[Config.Fuel]:SetFuel(oxycar, 100.0)
				end
    			TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(oxycar))
				ps.notify(ps.lang('oxy.keys'), 'success')
				onMission = true
				getRoute()

				ps.entityTarget(oxycar,  {
					{
						icon = "fa-solid fa-box",
						label = ps.lang('oxy.targetGetPackage'),
						action = function()
							if carryPackage then
								ps.notify(ps.lang('oxy.alreadyCarrying'), "error")
							else
								local pos = GetEntityCoords(PlayerPedId(), true)
								ps.requestAnim('anim@heists@box_carry@')
								TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
								ps.requestModel("hei_prop_drug_statue_box_big")
								carryPackage = CreateObject("hei_prop_drug_statue_box_big", pos.x, pos.y, pos.z, true, true, true)
								AttachEntityToEntity(carryPackage, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
							end
						end,
						canInteract = function()
							return handleGang(v.gang)
						end
					}
				})
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
