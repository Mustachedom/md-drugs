
local started = false
local hit = 0

local function SpawnCarPedChase()
	local stoploc = vector3(-1157.63, -3056.71, 13.94)
	local start = GlobalState.MDDrugsLocs.StartLoc[math.random(1,#GlobalState.MDDrugsLocs.StartLoc)]

	if started then ps.notify(Lang.lean.act,'error') return end
    started = true

	ps.callback('md-drugs:server:RegisterLean')
    ps.requestModel("pounder", Config.RequestModelTime)
    ps.requestModel("ig_priest", Config.RequestModelTime)
    ps.requestModel("cargobob3", Config.RequestModelTime)

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
				label = Lang.targets.lean.st,
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
for k, v in pairs (GlobalState.MDDrugsLocs.SyrupVendor) do
	ps.requestModel(v.ped)
	leanPeds[k] = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, false, false)
	Freeze(leanPeds[k], true, v.loc.w)
	ps.entityTarget(leanPeds[k], {
		{
			icon = "fa-solid fa-hand-holding-medical",
			label = ps.lang('Lean.buylean'),
			action = function()
				SpawnCarPedChase()
			end,
		},
	})
end