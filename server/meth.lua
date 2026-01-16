Recipes, Locations = Recipes or {}, Locations or {}
local onRun = {}
local vehicles = {}
Locations.Meth = {
	CookMeth = {
        {loc = vector3(1006.09, -3200.59, -38.52), l = 1.0, w = 1.0, rot = 45.0, offset = vec3(4.79, 2.13, -0.41), rotation = vector3(0,0,0.0), gang = ""},
    },
    MethDials = {
        {loc = vector3(1007.89, -3201.17, -38.99),l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    MethSmash = {
        {loc = vector3(1012.04, -3194.96, -38.99), bucket = vector4(1012.86, -3194.13, -39.20, 90.00), l = 1.0, w = 1.0, rot = 45.0, offset = vec3(-3.143311, -1.666748, -1.010128), rotation = vector3(0,0,0.0), gang = ""},
    },
    BagMeth = {
        {loc = vector3(1014.25, -3194.93, -38.99), l = 1.0, w = 1.0, rot = 45.0, offset = vec3(-4.9, -1.70, -1.01), rotation = vector3(0,0,0.0), gang = ""},
    },
    MethEph = { -- get ephedrine
        {loc = vector3(3559.86, 3673.9, 28.13), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    MethAce = { -- get acetone
        {loc = vector3(3535.41, 3661.05, 28.12), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    MethHeist = {
        {loc = vector4(-1520.84, 827.72, 181.66, 184.13), ped = 'a_m_m_farmer_01', gang = ""},
    },
    StartLoc = { -- where truck spawns for lean and meth missions
        vector3(-2307.22, 434.77, 174.47),
        vector3(614.75, 1786.26, 199.39),
        vector3(-224.89, 6388.32, 31.59)
    },
	MethTele = {
		{inside = vector3(996.91, -3200.83, -36.39), outside = vector3(-2222.04, 303.99, 174.6), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
	}
}
GlobalState.MDDrugsLocations = Locations

Recipes.Meth = {
	cook = {
		heat = {take = {ephedrine = 1, acetone = 1}, give = {}}
	},
	bag = {
		bags = {take = {empty_weed_bag = 5}, give = {methbags = 5} }
	}
}
GlobalState.MDDrugsRecipes = Recipes

local function setTimeout(src)
	if onRun[src] then
		CreateThread(function()
			Wait(10 * 60 * 1000)
			onRun[src] = nil
		end)
	end
end

RegisterServerEvent('md-drugs:server:givemethingridients', function(veh)
	local src = source
	local amount = math.random(1,5)

	local vehicle = NetworkGetEntityFromNetworkId(veh)
	if vehicles[src] ~= vehicle then
		return Bridge.Notify.SendNotify(src, Bridge.Language.Locale('meth.noVehicle'), "error")
	end

	if not DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey('journey') then
		return Bridge.Notify.SendNotify(src, Bridge.Language.Locale('meth.noVehicle'), "error")
	end
	
	if timeOut(src, 'md-drugs:server:givemethingridients') then return end

	if not onRun[src] then
		return Bridge.Notify.SendNotify(src, Bridge.Language.Locale('meth.notOnRun'), "error")
	end
	onRun[src] = onRun[src] + 1

	local chance = math.random(1,2) == 1 and 'ephedrine' or 'acetone'
	if onRun[src] == 5 then
		DeleteEntity(vehicle)
		onRun[src] = nil
		vehicles[src] = nil
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('meth.finishedRun'), "success")
	end
	Bridge.Inventory.AddItem(src, chance, amount)
end)


RegisterServerEvent('md-drugs:server:getmeth', function(num)
  	local src = source
	if timeOut(src, 'md-drugs:server:getmeth') then return end

	if not checkDistance(src, Locations.Meth.BagMeth[num].loc, 2.5) then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end

	if not craft(src, Recipes.Meth.bag.bags) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:geteph', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:geteph') then return end
	if not checkDistance(src, Locations.Meth.MethEph[num].loc, 2.5) then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end
	Bridge.Inventory.AddItem(src, 'ephedrine', 1)
end)

RegisterServerEvent('md-drugs:server:getace', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:getace') then return end
	if not checkDistance(src, Locations.Meth.MethAce[num].loc, 2.5) then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end
	Bridge.Inventory.AddItem(src, 'acetone', 1)
end)

Bridge.Callback.Register('md-drugs:server:startcook', function(source, num)
	local src = source
	if not checkDistance(src, Locations.Meth.CookMeth[num].loc, 2.5) then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return false
	end
	if not craft(src, Recipes.Meth.cook.heat) then
		return false
	end
	return true
end)

Bridge.Callback.Register('md-drugs:server:registerMeth', function(source, loc, vehNetId)
	local src = source
	if onRun[source] then
		return false
	else
		if checkDistance(src, Locations.Meth.MethHeist[loc].loc, 10.0) then
			local vehicle = NetworkGetEntityFromNetworkId(vehNetId)
			if DoesEntityExist(vehicle) and GetEntityModel(vehicle) == GetHashKey('journey') then
				vehicles[src] = vehicle
			else
				return false
			end
		else
			return false
		end
		onRun[source] = 0
		setTimeout(source)
		return true
	end
end)



