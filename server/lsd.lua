Recipes, Locations = Recipes or {}, Locations or {}
local prices = {
	tabcost = 100, -- price per piece of tab paper event does 10 at a time
	lsdlabkitcost = 10000 -- price of the lsd lab kit
}
Recipes.LSD = {
	vial = {
        heat = {take = {lysergic_acid = 1, diethylamide = 1,}, give = {lsd_one_vial = 1}}
    },
}
GlobalState.MDDrugsRecipes = Recipes
Locations.LSD = {
	lysergicacid = { -- get lysergic acid
        {loc = vector3(-1381.21, -327.75, 39.85), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2405.53, 5008.39, 46.02), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    diethylamide = {  -- get diethylamide
        {loc = vector3(-1372.89, -319.47, 39.05), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2408.38, 5011.18, 46.08), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    gettabs = { -- buy tab paper
        {loc = vector3(-1378.26, -336.56, 39.31), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2409.59, 5012.45, 46.09), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    buyLSDkit = {
        {ped = 'g_f_y_families_01', loc = vector4(-1376.66, -325.52, 39.63, 142.1), l = 1.0, w = 1.0, rot = 283.51, gang = ""},
    },
}
GlobalState.MDDrugsLocations = Locations

local lsdTables = {}

RegisterServerEvent('md-drugs:server:getlysergic', function(num)
	local src = source

	if timeOut(src, 'md-drugs:server:getlysergic') then return end

	if not checkDistance(src, Locations.LSD.lysergicacid[num].loc, 2.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end
	Bridge.Inventory.AddItem(src, 'lysergic_acid', 2)
end)

RegisterServerEvent('md-drugs:server:getdiethylamide', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:getdiethylamide') then return end
	if not checkDistance(src, Locations.LSD.diethylamide[num].loc, 2.0) then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end
	Bridge.Inventory.AddItem(src, 'diethylamide', 2)
end)


Bridge.Framework.RegisterUsableItem('lsdlabkit', function(source, item)
	local src = source
	local placed, loc = Bridge.Callback.Trigger('md-drugs:client:setlsdlabkit', src)
	if placed then
		if Bridge.Inventory.RemoveItem(src, 'lsdlabkit', 1) then
			lsdTables[src] = {
				src = src,
				loc = loc
			}
		end
	end
end)


Bridge.Callback.Register('md-drugs:server:removecleaningkit', function(source)
	local src = source
	if not lsdTables[src] then return false end
	if not checkDistance(src, lsdTables[src].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return false
	end
	return Bridge.Inventory.RemoveItem(src, "cleaningkit", 1)
end)

RegisterServerEvent('md-drugs:server:getlabkitback', function()
	local src = source
	if timeOut(src, 'md-drugs:server:getlabkitback') then return end
	if lsdTables[src] then
		lsdTables[src] = nil
		Bridge.Inventory.AddItem(src, 'lsdlabkit', 1)
	end
end)

RegisterServerEvent('md-drugs:server:heatliquid', function()
	local src = source
	if not lsdTables[src] then return end

	if timeOut(src, 'md-drugs:server:heatliquid') then return end
	if not checkDistance(src, lsdTables[src].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end
	if not craft(src, Recipes.LSD['vial']['heat']) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:failheating', function()
	local src = source
	if not lsdTables[src] then return end

	if not checkDistance(src, lsdTables[src].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end

	Bridge.Inventory.RemoveItem(src, 'lysergic_acid', 1)
	Bridge.Inventory.RemoveItem(src, 'diethylamide', 1)
	Bridge.Notify.SendNotify(src, Bridge.Language.Locale('lsd.failed'), "error")
end)


RegisterServerEvent('md-drugs:server:refinequalityacid', function()
	local src = source

	if not lsdTables[src] then
		return
	end
	if not checkDistance(src, lsdTables[src].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end

	if timeOut(src, 'md-drugs:server:refinequalityacid') then 
		return
	end
	local removed = Bridge.Inventory.RemoveItem(src, 'lsd_one_vial', 1)
	if not removed then
		return
	end
	if Config.TierSystem then
		local lsd = tonumber(getRep(src, 'lsd'))
		if lsd <= 30 then
			Bridge.Inventory.AddItem(src,'lsd_vial_two', 1)
		elseif lsd >= 31 and lsd <= 60 then 
			Bridge.Inventory.AddItem(src,'lsd_vial_three', 1)
		elseif lsd >= 61 and lsd <= 90 then
			Bridge.Inventory.AddItem(src,'lsd_vial_four', 1)
		elseif lsd >= 91 and lsd <= 120 then
			Bridge.Inventory.AddItem(src,'lsd_vial_five', 1)
		else 
			Bridge.Inventory.AddItem(src,'lsd_vial_six', 1)
		end
		AddRep(src,'lsd')
	else
		local randomchance = math.random(1,100)
		if randomchance <= 60 then 
			Bridge.Inventory.AddItem(src,'lsd_vial_two', 1)
		elseif randomchance >= 61 and randomchance <= 75 then 
			Bridge.Inventory.AddItem(src,'lsd_vial_three', 1)
		elseif randomchance >= 76 and randomchance <= 85 then
			Bridge.Inventory.AddItem(src,'lsd_vial_four', 1)
		elseif randomchance >= 86 and randomchance <= 93 then
			Bridge.Inventory.AddItem(src,'lsd_vial_five', 1)
		else
			Bridge.Inventory.AddItem(src,'lsd_vial_six', 1)
		end
	end
end)

RegisterServerEvent('md-drugs:server:failrefinequality', function()
	local src = source

	if not lsdTables[src] then return end

	if not checkDistance(src, lsdTables[src].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end

	Bridge.Inventory.RemoveItem(src,'lsd_one_vial', 1)
end)


RegisterServerEvent('md-drugs:server:gettabpaper', function(num)
	local src = source

	if timeOut(src, 'md-drugs:server:gettabpaper') then return end

	if not checkDistance(src, Locations.LSD.gettabs[num].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end

	if Bridge.Framework.RemoveAccountBalance(src, 'cash', prices.tabcost * 10) then
		Bridge.Inventory.AddItem(src,'tab_paper', 10)
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notEnoughMoney'), "error")
	end
end)
 
RegisterServerEvent('md-drugs:server:getlabkit', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:getlabkit') then return end

	if Bridge.Inventory.HasItem(src,'lsdlabkit', 1) then
		return
	end

	if not checkDistance(src, Locations.LSD.buyLSDkit[num].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end
	if Bridge.Framework.RemoveAccountBalance(src, 'cash', prices.lsdlabkitcost) then
		Bridge.Inventory.AddItem(src,'lsdlabkit', 1)
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notEnoughMoney'), "error")
	end
end)

RegisterServerEvent('md-drugs:server:maketabpaper', function()
	local src = source
	if timeOut(src, 'md-drugs:server:maketabpaper') then return end
	if not lsdTables[src] then return end
	if not checkDistance(src, lsdTables[src].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
		return
	end

	local vialdata = {
		{vial = 'lsd_one_vial',   give = {smileyfacesheet = 1},   take = {lsd_one_vial = 1, tab_paper = 1}},
	    {vial = 'lsd_vial_two',   give = {wildcherrysheet = 1},   take = {lsd_vial_two = 1, tab_paper = 1}},
	    {vial = 'lsd_vial_three', give = {yinyangsheet = 1}, 	  take = {lsd_vial_three = 1, tab_paper = 1}},
	    {vial = 'lsd_vial_four',  give = {pineapplesheet = 1}, 	  take = {lsd_vial_four = 1, tab_paper = 1}},
	    {vial = 'lsd_vial_five',  give = {bartsheet = 1}, 	      take = {lsd_vial_five = 1, tab_paper = 1}},
	    {vial = 'lsd_vial_six',   give = {gratefuldeadsheet = 1}, take = {lsd_vial_six = 1, tab_paper = 1}}
	}
	local vial = 1
	for k, v in ipairs (vialdata) do
		local check = Bridge.Inventory.HasItem(src, v.vial)
		if check then
			vial = k
			break
		end
	end
	if not craft(src, vialdata[vial]) then
		return
	end
end)

local sheets = {
	{item = 'smileyfacesheet',   recieve = "smiley_tabs", 		},
	{item = 'wildcherrysheet',   recieve = "wildcherry_tabs",   },
	{item = 'yinyangsheet',      recieve = "yinyang_tabs",      },
	{item = 'pineapplesheet',    recieve = "pineapple_tabs",    },
	{item = 'bartsheet', 		 recieve = "bart_tabs",         },
	{item = 'gratefuldeadsheet', recieve = "gratefuldead_tabs", },
}

for k, v in pairs (sheets) do
	Bridge.Framework.RegisterUsableItem(v.item, function(source)
		local src = source
		local math = math.random(1,10)
		if Bridge.Inventory.RemoveItem(src, v.item, 1) then
			Bridge.Inventory.AddItem(src, v.recieve, math)
		end
	end)
end

AddEventHandler('playerDropped', function()
	local src = source
	if lsdTables[src] then
		lsdTables[src] = nil
		Bridge.Inventory.AddItem(src, 'lsdlabkit', 1)
	end
end)