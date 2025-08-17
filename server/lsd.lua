
local prices = {
	tabcost = 100, -- price per piece of tab paper event does 10 at a time
	lsdlabkitcost = 10000 -- price of the lsd lab kit
}
local lsdRecipes = {
	vial = {
        heat = {take = {lysergic_acid = 1, diethylamide = 1,}, give = {lsd_one_vial = 1}}
    },
}

local lsdLocations = {
	lysergicacid = { -- get lysergic acid
        {loc = vector3(-1381.21, -327.75, 39.85), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2405.53, 5008.39, 46.02), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    diethylamide = {  -- get diethylamide
        {loc = vector3(-1371.71, -316.02, 39.53), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2408.38, 5011.18, 46.08), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    gettabs = { -- buy tab paper
        {loc = vector3(-1370.77, -314.51, 39.58), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
        {loc = vector3(2409.59, 5012.45, 46.09), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    buyLSDkit = {
        {ped = 'g_f_y_families_01', loc = vector4(2598.47, 5033.06, 105.86, 283.51), l = 1.0, w = 1.0, rot = 283.51, gang = ""},
    },
}

ps.registerCallback('md-drugs:server:GetLSDLocations', function(source)
	return lsdLocations
end)

local lsdTables = {}

RegisterServerEvent('md-drugs:server:getlysergic', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:getlysergic') then return end
	if not ps.checkDistance(src, lsdLocations.lysergicacid[num].loc, 2.0) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return
	end
	ps.addItem(src, 'lysergic_acid', 2)
end)

RegisterServerEvent('md-drugs:server:getdiethylamide', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:getdiethylamide') then return end
	if not ps.checkDistance(src, lsdLocations.diethylamide[num].loc, 2.0) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return
	end
	ps.addItem(src, 'diethylamide', 2)
end)


ps.createUseable('lsdlabkit', function(source, item)
	local src = source
	local placed, loc = ps.callback('md-drugs:client:setlsdlabkit', src)
	if placed then
		if ps.removeItem(src, 'lsdlabkit', 1) then
			table.insert(lsdTables, {
				owner = ps.getPlayerName(src),
				ownerid = ps.getIdentifier(src),
				src = src,
				loc = loc
			})
		end
	end
end)

local function hasLabKit(source)
	local src = source
	for k, v in pairs (lsdTables) do
		if v.ownerid == ps.getIdentifier(src) then
			return true
		end
	end
end

ps.registerCallback('md-drugs:server:removecleaningkit', function(source)
	local src = source
	return ps.removeItem(src, "cleaningkit", 1)
end)

RegisterServerEvent('md-drugs:server:getlabkitback', function()
	local src = source
	for k, v in pairs (lsdTables) do
		if v.ownerid == ps.getIdentifier(src) then
			table.remove(lsdTables, k)
			ps.addItem(src, 'lsdlabkit', 1)
		end
	end
end)

RegisterServerEvent('md-drugs:server:heatliquid', function()
	local src = source
	if not hasLabKit(src) then return end
	if timeOut(src, 'md-drugs:server:heatliquid') then return end
	if not ps.craftItem(src, lsdRecipes['vial']['heat']) then
		verifyHas(src, lsdRecipes['vial']['heat'].take)
		return
	end
end)

RegisterServerEvent('md-drugs:server:failheating', function()
	local src = source
	if not hasLabKit(src) then return end
	ps.removeItem(src, 'lysergic_acid', 1)
	ps.removeItem(src, 'diethylamide', 1)
	ps.notify(src, ps.lang('lsd.failed'), "error")
end)


RegisterServerEvent('md-drugs:server:refinequalityacid', function()
	local src = source
	if not hasLabKit(src) then return end
	if timeOut(src, 'md-drugs:server:refinequalityacid') then return end
	if not ps.hasItem(src, 'lsd_one_vial', 1) then return end
	if Config.TierSystem then
		local lsd = tonumber(getRep(src, 'lsd'))
		if ps.removeItem(src, 'lsd_one_vial', 1) then
			if lsd <= 30 then
				ps.addItem(src,'lsd_vial_two', 1)
			elseif lsd >= 31 and lsd <= 60 then 
				ps.addItem(src,'lsd_vial_three', 1)
			elseif lsd >= 61 and lsd <= 90 then
				ps.addItem(src,'lsd_vial_four', 1)
			elseif lsd >= 91 and lsd <= 120 then
				ps.addItem(src,'lsd_vial_five', 1)
			else 
				ps.addItem(src,'lsd_vial_six', 1)
			end
			AddRep(src,'lsd')
		end
	else
		local randomchance = math.random(1,100)
		if ps.removeItem(src,'lsd_one_vial', 1) then
			if randomchance <= 60 then 
				ps.addItem(src,'lsd_vial_two', 1)
			elseif randomchance >= 61 and randomchance <= 75 then 
				ps.addItem(src,'lsd_vial_three', 1)
			elseif randomchance >= 76 and randomchance <= 85 then
				ps.addItem(src,'lsd_vial_four', 1)
			elseif randomchance >= 86 and randomchance <= 93 then
				ps.addItem(src,'lsd_vial_five', 1)
			else
				ps.addItem(src,'lsd_vial_six', 1)
			end
		end
	end
end)

RegisterServerEvent('md-drugs:server:failrefinequality', function()
	local src = source
	if not hasLabKit(src) then return end
	ps.removeItem(src,'lsd_one_vial', 1)
end)


RegisterServerEvent('md-drugs:server:gettabpaper', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:gettabpaper') then return end
	if not ps.checkDistance(src, lsdLocations.gettabs[num].loc, 3.0) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return
	end
	if ps.removeMoney(src, 'cash', prices.tabcost * 10) then
		ps.addItem(src,'tab_paper', 10)
	else
		ps.notify(src, ps.lang('Catches.notEnoughMoney'), "error")
	end
end)
 
RegisterServerEvent('md-drugs:server:getlabkit', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:getlabkit') then return end
	if ps.hasItem(src,'lsdlabkit', 1) then 
		return
	end
	if not ps.checkDistance(src, lsdLocations.buyLSDkit[num].loc, 3.0) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return
	end
	if ps.removeMoney(src, 'cash', prices.lsdlabkitcost) then
		ps.addItem(src,'lsdlabkit', 1)
	else
		ps.notify(src, ps.lang('Catches.notEnoughMoney'), "error")
	end
end)

RegisterServerEvent('md-drugs:server:maketabpaper', function()
	local src = source
	if timeOut(src, 'md-drugs:server:maketabpaper') then return end
	if not hasLabKit(src) then return end
	if not ps.hasItem(src,'tab_paper', 1) then return end
	local vialdata = {
		{vial = 'lsd_one_vial',   sheet = 'smileyfacesheet', log = 'Made A Smiley Face Sheet'},
	    {vial = 'lsd_vial_two',   sheet = 'wildcherrysheet', log = 'Made A Wild Cherry Sheet'},
	    {vial = 'lsd_vial_three', sheet = 'yinyangsheet', log = 'Made A Yin Yang Sheet'},
	    {vial = 'lsd_vial_four',  sheet = 'pineapplesheet', log = 'Made A Pine Apple Sheet'},
	    {vial = 'lsd_vial_five',  sheet = 'bartsheet', log = 'Made A Cluckin Bell Sheet'},
	    {vial = 'lsd_vial_six',   sheet = 'gratefuldeadsheet', log = 'Made A Maze Sheet'}
	}
	for k, v in ipairs (vialdata) do
		local check = ps.hasItem(src, v.vial) and ps.hasItem(src, 'tab_paper')
		if check then
			if ps.removeItem(src, v.vial, 1) and ps.removeItem(src, 'tab_paper', 1) then
				ps.addItem(src, v.sheet, 1)
			end
		end
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
	ps.createUseable(v.item, function(source)
		local src = source
		local math = math.random(1,10)
		if ps.removeItem(src, v.item, 1) then
			ps.addItem(src, v.recieve, math)
		end
	end)
end

AddEventHandler('playerDropped', function()
	local src = source
	for k, v in pairs (lsdTables) do
		if v.ownerid == ps.getPlayerCitizenId(src) then
			table.remove(lsdTables, k)
			ps.addItem(src, 'lsdlabkit', 1)
		end
	end
end)