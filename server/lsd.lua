local QBCore = exports['qb-core']:GetCoreObject()
local prices = {
	tabcost = 100, -- price per piece of tab paper event does 10 at a time
	lsdlabkitcost = 10000 -- price of the lsd lab kit
}

local lsdTables = {}
RegisterServerEvent('md-drugs:server:getlysergic', function(num)
	local src = source
	if not checkLoc(src, 'lysergicacid', num) then return end
	if AddItem(src,'lysergic_acid', 2) then
	end
end)

RegisterServerEvent('md-drugs:server:getdiethylamide', function(num)
	local src = source
	if not checkLoc(src, 'diethylamide', num) then return end
	if AddItem(src,'diethylamide', 2) then 
	end
end)


CUI('lsdlabkit', function(source, item)
	local src = source
	local Player = getPlayer(src)
	local placed, loc = lib.callback.await('md-drugs:client:setlsdlabkit', src)
	if placed then 
		if RemoveItem(src, 'lsdlabkit', 1) then
			table.insert(lsdTables, {
				owner = GetName(src),
				ownerid = Player.PlayerData.citizenid,
				src = src,
				loc = loc
			})
		end
	end
end)

local function hasLabKit(source) 
	local src = source 
	local Player = getPlayer(src)
	for k, v in pairs (lsdTables) do
		if v.ownerid == Player.PlayerData.citizenid then
			return true
		end
	end
end

lib.callback.register('md-drugs:server:removecleaningkit', function(source)
	local src = source
	if not Itemcheck(src, 'cleaningkit', 1) then return end
	if RemoveItem(src,"cleaningkit", 1) then 
		return true
	end
end)

RegisterServerEvent('md-drugs:server:getlabkitback', function()
	local src = source
	local Player = getPlayer(src)
	for k, v in pairs (lsdTables) do
		if v.ownerid == Player.PlayerData.citizenid then
			table.remove(lsdTables, k)
			AddItem(src, 'lsdlabkit', 1)
		end
	end
end)

RegisterServerEvent('md-drugs:server:heatliquid', function()
	local src = source
	if not hasLabKit(src) then return end
	if not GetRecipe(src, 'lsd', 'vial', 'heat') then return end
end)

RegisterServerEvent('md-drugs:server:failheating', function()
	local src = source
	if not hasLabKit(src) then return end
	RemoveItem(src, 'lysergic_acid', 1)
	RemoveItem(src, 'diethylamide', 1)
	Notifys(src,Lang.lsd.failed, "error")
	Log(GetName(src) ..' Failed Basic LSD Like An Idiot!', 'lsd')
end)


RegisterServerEvent('md-drugs:server:refinequalityacid', function()
local src = source
if not hasLabKit(src) then return end
if not Itemcheck(src, 'lsd_one_vial', 1) then return end
	if Config.TierSystem then
		local lsd = getRep(src, 'lsd')
		if RemoveItem(src, 'lsd_one_vial', 1) then 
			if lsd <= 30 then 
				AddItem(src,'lsd_vial_two', 1)
			elseif lsd >= 31 and lsd <= 60 then 
				AddItem(src,'lsd_vial_three', 1)
			elseif lsd >= 61 and lsd <= 90 then
				AddItem(src,'lsd_vial_four', 1)
			elseif lsd >= 91 and lsd <= 120 then
				AddItem(src,'lsd_vial_five', 1)	
			else 
				AddItem(src,'lsd_vial_six', 1)
			end
			AddRep(src,'lsd')
			Log(GetName(src) ..' Refined Acid and Now Has A Rep Of ' .. lsd + 1 .. '!', 'lsd')
		end
	else
		local randomchance = math.random(1,100)
		if RemoveItem(src,'lsd_one_vial', 1) then 
			if randomchance <= 60 then 
				AddItem(src,'lsd_vial_two', 1)
			elseif randomchance >= 61 and randomchance <= 75 then 
				AddItem(src,'lsd_vial_three', 1)
			elseif randomchance >= 76 and randomchance <= 85 then
				AddItem(src,'lsd_vial_four', 1)	
			elseif randomchance >= 86 and randomchance <= 93 then
				AddItem(src,'lsd_vial_five', 1)	
			else 
				AddItem(src,'lsd_vial_six', 1)
			end
			Log(GetName(src) ..' Refined Acid!', 'lsd')
		end
	end
end)

RegisterServerEvent('md-drugs:server:failrefinequality', function()
	local src = source
	if not hasLabKit(src) then return end
	if not Itemcheck(src, 'lsd_one_vial', 1) then return end
	RemoveItem(src,'lsd_one_vial', 1)  
end)


RegisterServerEvent('md-drugs:server:gettabpaper', function(num)
	local src = source
	local Player = getPlayer(src)
	if not checkLoc(src, 'gettabs', num) then return end
	if Player.Functions.RemoveMoney('cash', prices.tabcost * 10) then
		AddItem(src,'tab_paper', 10)
	else
		Notifys(Lang.lsd.broke, "error")
	end
end)
 
RegisterServerEvent('md-drugs:server:getlabkit', function()
	local src = source
	local Player = getPlayer(src)
	if not checkLoc(src,'singleSpot', 'buylsdlabkit') then return end
	if Player.Functions.RemoveMoney('cash', prices.lsdlabkitcost) then
		AddItem(src,'lsdlabkit', 1)
	else
		Notifys(src, Lang.lsd.broke, "error")
	end
end)

RegisterServerEvent('md-drugs:server:maketabpaper', function()
	local src = source
	local Player = getPlayer(src)
	if not hasLabKit(src) then return end
	if not Itemcheck(src,'tab_paper', 1) then return end
	local count = 0
	local items, recieve = nil, nil
	local vialdata = {
		{vial = 'lsd_one_vial',   sheet = 'smileyfacesheet', log = 'Made A Smiley Face Sheet'},
	    {vial = 'lsd_vial_two',   sheet = 'wildcherrysheet', log = 'Made A Wild Cherry Sheet'},
	    {vial = 'lsd_vial_three', sheet = 'yinyangsheet', log = 'Made A Yin Yang Sheet'},
	    {vial = 'lsd_vial_four',  sheet = 'pineapplesheet', log = 'Made A Pine Apple Sheet'},
	    {vial = 'lsd_vial_five',  sheet = 'bartsheet', log = 'Made A Cluckin Bell Sheet'},
	    {vial = 'lsd_vial_six',   sheet = 'gratefuldeadsheet', log = 'Made A Maze Sheet'}
	}
	sortTab(vialdata, 'vial')
	for k, v in pairs (vialdata) do
		if count >= 1 then break end
		local check = Player.Functions.GetItemByName(v.vial)
		
		if check and check.amount >= 1 then
			items = v.vial
			recieve = v.sheet
			count = count + 1
			break
		end
	end
	if count >= 1 then
		if RemoveItem(src, items, 1) and RemoveItem(src, 'tab_paper', 1) then
			AddItem(src, recieve, 1)
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
	CUI(v.item, function(source)
		local src = source
		local Player = getPlayer(src)
		local math = math.random(1,10)
		if RemoveItem(src, v.item, 1) then
			AddItem(src, v.recieve, math)
			Log(GetName(src) ..' Made ' .. math .. 'Tabs of ' .. v.recieve .. '!', 'lsd')
		end
	end)
end

AddEventHandler('playerDropped', function()
	local src = source
	local Player = getPlayer(src)
	for k, v in pairs (lsdTables) do
		if v.ownerid == Player.PlayerData.citizenid then
			table.remove(lsdTables, k)
			AddItem(src, 'lsdlabkit', 1)
		end
	end
end)