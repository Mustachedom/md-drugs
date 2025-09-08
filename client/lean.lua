
local started = false
local hit = 0
local location = ps.callback('md-drugs:server:GetLeanLocs')

local function SpawnCarPedChase()
	local stoploc = vector3(-1157.63, -3056.71, 13.94)
	local start = location.StartLoc[math.random(1,#location.StartLoc)]

	if started then ps.notify(ps.lang('lean.alreadyChasing'), 'error') return end
    started = true

	ps.callback('md-drugs:server:RegisterLean')
    ps.requestModel("pounder", 30000)
    ps.requestModel("ig_priest", 30000)
    ps.requestModel("cargobob3", 30000)

    local leancar = CreateVehicle("pounder", start.x+3, start.y-2, start.z-1, 52.0, true, false)
    local driver = CreatePed(26, "ig_priest", start.x, start.y, start.z, 268.9422, false, false)
    local pilot2 = CreatePed(26, "ig_priest", stoploc.x-3, stoploc.y-3, stoploc.z-1, 268.9422, false, false)

	FreezeEntityPosition(pilot2, true)
	SetEntityInvincible(pilot2, true)
    SetEntityAsMissionEntity(leancar)
    AddBlipForEntity(leancar)
    SetPedIntoVehicle(driver, leancar, -1)
    SetPedFleeAttributes(driver,false)
    TaskVehicleDriveToCoordLongrange(driver, leancar, stoploc.x, stoploc.y, stoploc.z-1, 50.0, 524288, 25.0)
    SetPedKeepTask(driver, true)

	repeat
		Wait(1000)
	until #(GetEntityCoords(driver) - stoploc) < 20.0 or GetEntityHealth(driver) == 0

	RemoveBlip(leancar)

	if GetEntityHealth(driver) == 0 then
		ps.entityTarget(leancar, {
			{
				name = 'leancar',
				icon = 'fa-solid fa-car',
				label = ps.lang('lean.stealFromTruck'),
				action = function()
					hit = hit + 1
					if not minigame() then return end
					TriggerServerEvent('md-drugs:server:givelean')
					started = false
					if math.random(1,100) <= 30 or hit == 4 then
					hit = 0
					DeleteVehicle(leancar)
					DeleteEntity(driver)
					DeleteEntity(pilot2)
					end
				end
			}
		})
	else
		DeleteVehicle(leancar)
		DeleteEntity(driver)
		DeleteEntity(pilot2)
	end
end

local leanPeds = {}
for k, v in pairs (location.SyrupVendor) do
	ps.requestModel(v.ped)
	leanPeds[k] = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, false, false)
	Freeze(leanPeds[k], true, v.loc.w)
	ps.entityTarget(leanPeds[k], {
		{
			icon = "fa-solid fa-hand-holding-medical",
			label = ps.lang('lean.startMission'),
			action = function()
				SpawnCarPedChase()
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		},
	})
end