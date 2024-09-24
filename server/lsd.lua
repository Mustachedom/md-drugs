local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:getlysergic', function(num)
	local src = source
	if CheckDist(src, Config.lysergicacid[num]['loc']) then return end
	if AddItem(src,'lysergic_acid', 2) then
		Log(GetName(src) ..' Got Lysergic acid with a distance of ' .. dist(source, Config.lysergicacid[num]['loc']) .. '!', 'lsd')
	end
end)

RegisterServerEvent('md-drugs:server:getdiethylamide', function(num)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if CheckDist(src, Config.diethylamide[num]['loc']) then return end
	if AddItem(src,'diethylamide', 2) then 
		Log(GetName(src) ..' Got Diethylamide with a distance of ' .. dist(source, Config.diethylamide[num]['loc']) .. '!', 'lsd')
	end
end)


QBCore.Functions.CreateUseableItem('lsdlabkit', function(source, item)
local src = source
	if TriggerClientEvent("md-drugs:client:setlsdlabkit", src) then
		RemoveItem(src, "lsdlabkit", 1)
		Log(GetName(src) ..' Placed Their LSD Lab Kit Back At ' .. GetCoords(src)  .. '!', 'lsd')
	end
end)


lib.callback.register('md-drugs:server:removecleaningkit', function(source)
local src = source
	if not Itemcheck(src, 'cleaningkit', 1) then return end
	if RemoveItem(src,"cleaningkit", 1) then 
		Log(GetName(src) ..' Wiped Down Their LSD Lab Kit!' , 'lsd')
		return true
	end
end)

RegisterServerEvent('md-drugs:server:getlabkitback', function()
local src = source
	if AddItem(src,"lsdlabkit", 1) then
		Log(GetName(src) ..' Picked Up Their LSD Lab Kit Back At ' .. GetCoords(src) .. '!', 'lsd')
	end
end)

RegisterServerEvent('md-drugs:server:heatliquid', function()
local src = source
	if not GetRecipe(src, 'lsd', 'vial', 'heat') then return end
	Log(GetName(src) ..' Heated Basic LSD!', 'lsd')
end)

RegisterServerEvent('md-drugs:server:failheating', function()
local src = source
if not ChecknRemove(source, {lysergic_acid = 1, diethylamide = 1}) then return end
	Notifys(src,Lang.lsd.failed, "error")
	Log(GetName(src) ..' Failed Basic LSD Like An Idiot!', 'lsd')
end)


RegisterServerEvent('md-drugs:server:refinequalityacid', function()
local src = source
local randomchance = math.random(1,100)
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
	if not Itemcheck(src, 'lsd_one_vial', 1) then return end
	RemoveItem('lsd_one_vial', 1)  
end)


RegisterServerEvent('md-drugs:server:gettabpaper', function(num)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if CheckDist(source, Config.gettabs[num]['loc']) then return end
	if Player.Functions.RemoveMoney('cash', Config.tabcost * 10) then
		AddItem(src,'tab_paper', 10)
		Log(GetName(src) ..' Bought Tab Paper!', 'lsd')
	else
		Notifys(Lang.lsd.broke, "error")
	end
end)
 
RegisterServerEvent('md-drugs:server:getlabkit', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if CheckDist(source, vector3(Config.buylsdlabkit.x, Config.buylsdlabkit.y, Config.buylsdlabkit.z)) then return end
	if Player.Functions.RemoveMoney('cash', Config.lsdlabkitcost) then
		AddItem(src,'lsdlabkit', 1)
		Log(GetName(src) ..' Bought A LSD Lab Kit!', 'lsd')
	else
		Notifys(src, Lang.lsd.broke, "error")
	end
end)




RegisterServerEvent('md-drugs:server:maketabpaper', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
if not Itemcheck(src,'tab_paper', 1) then return end
	if RemoveItem(src,'lsd_one_vial', 1) then
		RemoveItem(src,'tab_paper', 1)
		AddItem(src,'smileyfacesheet', 1)
		Log(GetName(src) ..' Made A Smiley Face Sheet', 'lsd')
	elseif Player.Functions.RemoveItem('lsd_vial_two', 1) then
		RemoveItem(src,'tab_paper', 1)
		AddItem(src,'wildcherrysheet', 1)
		Log(GetName(src) ..' Made A Wild Cherry Sheet', 'lsd')
	elseif Player.Functions.RemoveItem('lsd_vial_three', 1) then
		RemoveItem(src,'tab_paper', 1)
		AddItem(src,'yinyangsheet', 1)
		Log(GetName(src) ..' Made A Yin Yang Sheet', 'lsd')
	elseif Player.Functions.RemoveItem('lsd_vial_four', 1) then
		RemoveItem(src,'tab_paper', 1)
		AddItem(src,'pineapplesheet', 1)
		Log(GetName(src) ..' Made A Pine Apple Sheet', 'lsd')
	elseif Player.Functions.RemoveItem('lsd_vial_five', 1) then
		RemoveItem(src,'tab_paper', 1)
		AddItem(src,'bartsheet', 1)
		Log(GetName(src) ..' Made A Cluckin Bell Sheet', 'lsd')
	elseif Player.Functions.RemoveItem('lsd_vial_six', 1) then
		RemoveItem(src,'tab_paper', 1)
		AddItem(src,'gratefuldeadsheet', 1)
		Log(GetName(src) ..' Made A Maze Sheet', 'lsd')
	else
		Notifys(Lang.lsd.novial, "error")
	end
end)

local sheets = {
	{item = 'smileyfacesheet',   recieve = "Smiley_tabs", 		},
	{item = 'wildcherrysheet',   recieve = "wildcherry_tabs",   },
	{item = 'yinyangsheet',      recieve = "yinyang_tabs",      },
	{item = 'pineapplesheet',    recieve = "pineapple_tabs",    },
	{item = 'bartsheet', 		 recieve = "bart_tabs",         },
	{item = 'gratefuldeadsheet', recieve = "gratefuldead_tabs", },
}

for k, v in pairs (sheets) do 
	QBCore.Functions.CreateUseableItem(v.item, function(source)
		local src = source
		local Player = QBCore.Functions.GetPlayer(src)
		local math = math.random(1,10)
		if RemoveItem(src, v.item, 1) then
			AddItem(src, v.recieve, math)
			Log(GetName(src) ..' Made ' .. math .. 'Tabs of ' .. v.recieve .. '!', 'lsd')
		end
	end)
end