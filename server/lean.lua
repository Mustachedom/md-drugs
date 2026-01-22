Locations = Locations or {}
Recipes = Recipes or {}
local onRun = {}
Locations.Lean = {
	MakeLean = {
        {
            loc = vector3(2635.81, 4240.57, 45.32),
            checks = { -- these can be arrays like {'police', 'ambulance'} or just a single string like 'police'
                --gang = {},
                --item = {},
                --job = {},
                --citizenid = {}
            }
        },
    },
	SyrupVendor = {
        {ped = 'a_m_m_farmer_01', loc = vector4(365.21, -578.77, 39.30, 347.23), l = 1.0, w = 1.0, rot = 347.23, gang = ""},
    },
	StartLoc = { -- where truck spawns for lean and meth missions
        vector3(-2307.22, 434.77, 174.47),
        vector3(614.75, 1786.26, 199.39),
        vector3(-224.89, 6388.32, 31.59)
    },
}

GlobalState.MDDrugsLocations = Locations
Recipes.Lean = {
	{
		item = 'cupoflean',
		amount = 1,
		ingredients = {
			{item = 'leancup', amount = 1},
			{item = 'mdlean', amount = 1},
			{item = 'sprunk', amount = 1},
		}
	},
	{
		item = 'cupofdextro',
		amount = 1,
		ingredients = {
			{item = 'leancup', amount = 1},
			{item = 'mdreddextro', amount = 1},
			{item = 'sprunk', amount = 1},
		}
	}
}
GlobalState.MDDrugsRecipes = Recipes
local function setTimeout(identifier)
	if onRun[identifier] then
		CreateThread(function()
			Wait(10 * 60 * 1000)
			onRun[identifier] = nil
		end)
	end
end
RegisterServerEvent('md-drugs:server:givelean', function()
	local src = source
	if not onRun[src] then
		return
	end
	local veh = onRun[src].vehicle
	if not veh or veh == 0 then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('lean.vehDoesntExist', Bridge.Framework.GetPlayerIdentifier(src)), 'error')
		return
	end
	if GetEntityModel(veh) ~= GetHashKey('pounder') then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('lean.wrongVehModel', Bridge.Framework.GetPlayerIdentifier(src)), 'error')
		return
	end
	local pcoords, vcoords = GetEntityCoords(GetPlayerPed(src)), GetEntityCoords(veh)
	if not checkDistance(src, vcoords, 5.0, 'md-drugs:server:givelean') then
		return
	end
	onRun[src].taken = onRun[src].taken + 1
	local item, amount = math.random(1,2) == 1 and 'mdlean' or 'mdreddextro', math.random(1,3)
	Bridge.Inventory.AddItem(src, item, amount)
	if onRun[src].taken < 5 then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('lean.maxTaken'), 'error')
		DeleteEntity(veh)
		onRun[src] = nil
		return
	end
end)

Bridge.Callback.Register('md-drugs:server:registerLean', function(source, loc, vehicleNetId)
	local src = source
	if onRun[src] then
		return false
	else
		if not checkDistance(src, Locations.Lean.SyrupVendor[loc].loc, 5.0, 'md-drugs:server:registerLean') then
			return false
		end
		if not vehicleNetId then
			Bridge.Prints.Warn(src, Bridge.Language.Locale('lean.vehDoesntExist', Bridge.Framework.GetPlayerIdentifier(src)), 'error')
			return false
		end
		local veh = NetworkGetEntityFromNetworkId(vehicleNetId)
		if not veh or veh == 0 or GetEntityModel(veh) ~= GetHashKey('pounder') then
			Bridge.Prints.Warn(src, Bridge.Language.Locale('lean.wrongVehModel', Bridge.Framework.GetPlayerIdentifier(src)), 'error')
			return false
		end

		onRun[src] = {
			taken = 0,
			vehicle = veh,
		}
		setTimeout(src)
		return true
	end
end)

Bridge.Framework.RegisterUsableItem('leancup', function(source, item)
	local src = source
	if not item then return end
	TriggerClientEvent('md-drugs:client:makeLean', src)
end)

RegisterNetEvent('md-drugs:server:makeLean', function(recipe)
	local src = source
	if not Recipes.Lean[recipe] then
		return
	end
	local rec = Recipes.Lean[recipe]
	for k, v in pairs (rec.ingredients) do
		if not Bridge.Inventory.HasItem(src, v.item, v.amount) then
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('lean.missingIngredients'), 'error')
			return
		end
	end
	for k, v in pairs (rec.ingredients) do
		Bridge.Inventory.RemoveItem(src, v.item, v.amount)
	end
	Bridge.Inventory.AddItem(src, rec.item, rec.amount)
end)