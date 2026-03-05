if not Config.Drugs['lean'] then return end
local started = false
local leanCar = nil

local location = Config.Lean.Locations

local function SpawnCarPedChase(loc)
	local stoploc = vector3(-1157.63, -3056.71, 13.94)
	local start = location.StartLoc[math.random(1,#location.StartLoc)]

	if started then Bridge.Notify.SendNotify(Bridge.Language.Locale('lean.alreadyChasing'), 'error') return end
    started = true

    requestModel("pounder", 30000)
    requestModel("ig_priest", 30000)
    requestModel("cargobob3", 30000)

    leanCar = CreateVehicle("pounder", start.x+3, start.y-2, start.z-1, 52.0, true, false)
    local driver = CreatePed(26, "ig_priest", start.x, start.y, start.z, 268.9422, false, false)
    local pilot2 = CreatePed(26, "ig_priest", stoploc.x-3, stoploc.y-3, stoploc.z-1, 268.9422, false, false)
	local can = Bridge.Callback.Trigger('md-drugs:server:registerLean', loc, NetworkGetNetworkIdFromEntity(leanCar))

	if not can then
		Bridge.Notify.SendNotify(Bridge.Language.Locale('lean.cantStart'), 'error')
		DeleteVehicle(leanCar)
		DeleteEntity(driver)
		DeleteEntity(pilot2)
		started = false
		return
	end
	Bridge.Notify.SendNotify(Bridge.Language.Locale('lean.chaseStarted'), 'success')
	SetPedIntoVehicle(pilot2, leanCar, 1)
	FreezeEntityPosition(driver, true)
	FreezeEntityPosition(pilot2, true)
	SetEntityInvincible(pilot2, true)
    SetEntityAsMissionEntity(leanCar)
    AddBlipForEntity(leanCar)
    SetPedIntoVehicle(driver, leanCar, -1)
    SetPedFleeAttributes(driver,false)
    TaskVehicleDriveToCoordLongrange(driver, leanCar, stoploc.x, stoploc.y, stoploc.z-1, 50.0, 524288, 25.0)
    SetPedKeepTask(driver, true)

	repeat
		Wait(1000)
	until #(GetEntityCoords(driver) - stoploc) < 20.0 or GetEntityHealth(driver) == 0

	RemoveBlip(leanCar)

	if GetEntityHealth(driver) == 0 then
		Bridge.Target.AddLocalEntity(leanCar, {
			{
				name = 'leancar',
				icon = Bridge.Language.Locale('lean.carIcon'),
				label = Bridge.Language.Locale('lean.stealFromTruck'),
				action = function()
					if not minigame() then return end
					TriggerServerEvent('md-drugs:server:givelean')
					started = false
					DeleteEntity(driver)
					DeleteEntity(pilot2)
				end
			}
		})
		targets[#targets+1] = leanCar
	else
		DeleteEntity(driver)
		DeleteEntity(pilot2)
	end
end

local leanPeds = {}
for k, v in pairs (location.SyrupVendor) do
	requestModel(v.ped)
	leanPeds[k] = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, false, false)
	Freeze(leanPeds[k], true, v.loc.w)
	Bridge.Target.AddLocalEntity(leanPeds[k], {
		{
			icon = Bridge.Language.Locale('lean.startMissionIcon'),
			label = Bridge.Language.Locale('lean.startMission'),
			action = function()
				SpawnCarPedChase(k)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		},
	})
	targets[#targets+1] = leanPeds[k]
end

local function concat(tbl)
	local str = ""
	for k, v in pairs (tbl) do
		str = str .. v.item .. " X  " .. v.amount .. "  \n  "
	end
	return str
end

local function getDisabled(recipe)
	for k, v in pairs (recipe.ingredients) do
		local count = Bridge.Inventory.GetItemCount(v.item)
		if count < v.amount then
			return true
		end
	end
	return false
end

RegisterNetEvent("md-drugs:client:makeLean", function()
	local menu = {}
	for k, v in pairs (Config.Lean.Recipes) do
		menu[#menu+1] = {
			title = Bridge.Inventory.GetItemInfo(v.item).label,
			description = concat(v.ingredients),
			icon = Bridge.Inventory.GetItemInfo(v.item).image,
			disabled = getDisabled(v),
			onSelect = function()
				if not progressbar(Bridge.Language.Locale('lean.makingLean')) then return end
				TriggerServerEvent('md-drugs:server:makeLean', k)
			end,
		}
	end
	Bridge.Menu.Open({
		id = 'makeLeanMenu',
		title = Bridge.Language.Locale('lean.makeLeanMenuTitle'),
		description = Bridge.Language.Locale('lean.makeLeanMenuDesc'),
		options = menu
	})
end)