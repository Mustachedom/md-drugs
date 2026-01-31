
local onRun = {}

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
	if onRun[src].taken >= 5 then
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
		if not checkDistance(src, Config.Lean.Locations.SyrupVendor[loc].loc, 5.0, 'md-drugs:server:registerLean') then
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
	if not Config.Lean.Recipes[recipe] then
		return
	end
	local rec = Config.Lean.Recipes[recipe]
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