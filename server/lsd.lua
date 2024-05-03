local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:getlysergic', function(num)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.lysergicacid[num]['loc']) then return end
	if AddItem('lysergic_acid', 2) then
		Notifys(Lang.lsd.lys, "success")
	end
end)

RegisterServerEvent('md-drugs:server:getdiethylamide', function(num)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.diethylamide[num]['loc']) then return end
	if AddItem('diethylamide', 2) then 
		Notifys(Lang.lsd.die, "success")
	end
end)


QBCore.Functions.CreateUseableItem('lsdlabkit', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if TriggerClientEvent("md-drugs:client:setlsdlabkit", src) then
		Player.Functions.RemoveItem("lsdlabkit", 1)
	end
end)	


RegisterServerEvent('md-drugs:server:removecleaningkit', function(data)
local src = source
local Player = QBCore.Functions.GetPlayer(src)	
	if not Itemcheck(Player, 'cleaningkit', 1, 'true') then return end
	if RemoveItem("cleaningkit", 1) then 
		Notifys(Lang.lsd.cleaned, "success")
		TriggerClientEvent("md-drugs:client:resetlsdkit", src, data)
	end
end)

RegisterServerEvent('md-drugs:server:getlabkitback', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	
	if AddItem("lsdlabkit", 1) then
		Notifys('You Got Your Lab Kit Back', 'success')
	end
end)

RegisterServerEvent('md-drugs:server:heatliquid', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'lysergic_acid', 1, 'true') then return end
	if not Itemcheck(Player, 'diethylamide', 1, 'true') then return end
		RemoveItem('diethylamide', 1)  
		RemoveItem('lysergic_acid', 1)  
		AddItem('lsd_one_vial', 1)
		Notifys(Lang.lsd.madelsd, "success")
end)

RegisterServerEvent('md-drugs:server:failheating', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	RemoveItem('diethylamide', 1)  
	RemoveItem('lysergic_acid', 1)  
	Notifys(Lang.lsd.failed, "error")
end)


RegisterServerEvent('md-drugs:server:refinequalityacid', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local randomchance = math.random(1,100)
if not Itemcheck(Player, 'lsd_one_vial', 1, 'true') then return end
	if Config.TierSystem then
		local lsd = Player.PlayerData.metadata['lsd']
		if RemoveItem('lsd_one_vial', 1) then 
			if lsd <= 30 then 
				AddItem('lsd_vial_two', 1)
				Notifys(Lang.lsd.refined, "Success")
			elseif lsd >= 31 and lsd <= 60 then 
				AddItem('lsd_vial_three', 1)
				Notifys(Lang.lsd.refined, "Success")
			elseif lsd >= 61 and lsd <= 90 then
				AddItem('lsd_vial_four', 1)
				Notifys(Lang.lsd.refined, "Success")
			elseif lsd >= 91 and lsd <= 120 then
				AddItem('lsd_vial_five', 1)	
				Notifys(Lang.lsd.refined, "Success")
			else 
				AddItem('lsd_vial_six', 1)
				Notifys(Lang.lsd.refined, "Success")
			end
			Player.Functions.SetMetaData('lsd', (lsd + 1))
		end
	else
		if RemoveItem('lsd_one_vial', 1) then 
			if randomchance <= 60 then 
				AddItem('lsd_vial_two', 1)
				Notifys(Lang.lsd.refined, "Success")
			elseif randomchance >= 61 and randomchance <= 75 then 
				AddItem('lsd_vial_three', 1)
				Notifys(Lang.lsd.refined, "Success")
			elseif randomchance >= 76 and randomchance <= 85 then
				AddItem('lsd_vial_four', 1)
				Notifys(Lang.lsd.refined, "Success")
			elseif randomchance >= 86 and randomchance <= 93 then
				AddItem('lsd_vial_five', 1)	
				Notifys(Lang.lsd.refined, "Success")
			else 
				AddItem('lsd_vial_six', 1)
				Notifys(Lang.lsd.refined, "Success")
			end
		end
	end
end)

RegisterServerEvent('md-drugs:server:failrefinequality', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local randomchance = math.random(1,100)
if not Itemcheck(Player, 'lsd_one_vial', 1, 'true') then return end
	if RemoveItem('lsd_one_vial', 1) then 
		Player.Functions.SetMetaData('lsd', (Player.PlayerData.metadata.lsd - 1))
		if Player.PlayerData.metadata.lsd < 0 then Player.Functions.SetMetaData('lsd', 0) end
	end
end)


RegisterServerEvent('md-drugs:server:gettabpaper', function(num)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.gettabs[num]['loc']) then return end
	if Player.Functions.RemoveMoney('cash', Config.tabcost * 10) then
		AddItem('tab_paper', 10)
	else
		Notifys(Lang.lsd.broke, "error")
	end
end)
 
RegisterServerEvent('md-drugs:server:getlabkit', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, vector3(Config.buylsdlabkit.x, Config.buylsdlabkit.y, Config.buylsdlabkit.z)) then return end
	if Player.Functions.RemoveMoney('cash', Config.lsdlabkitcost) then
		AddItem('lsdlabkit', 1)
	else
		Notifys(Lang.lsd.broke, "error")
	end
end)




RegisterServerEvent('md-drugs:server:maketabpaper', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'tab_paper', 1, 'true') then return end
	if Player.Functions.RemoveItem('lsd_one_vial', 1) then
		RemoveItem('tab_paper', 1)
		AddItem('smileyfacesheet', 1)
	elseif Player.Functions.RemoveItem('lsd_vial_two', 1) then
		RemoveItem('tab_paper', 1)
		AddItem('wildcherrysheet', 1)
	elseif Player.Functions.RemoveItem('lsd_vial_three', 1) then
		RemoveItem('tab_paper', 1)
		AddItem('yinyangsheet', 1)
	elseif Player.Functions.RemoveItem('lsd_vial_four', 1) then
		RemoveItem('tab_paper', 1)
		AddItem('pineapplesheet', 1)
	elseif Player.Functions.RemoveItem('lsd_vial_five', 1) then
		RemoveItem('tab_paper', 1)
		AddItem('bartsheet', 1)
	elseif Player.Functions.RemoveItem('lsd_vial_six', 1) then
		RemoveItem('tab_paper', 1)
		AddItem('gratefuldeadsheet', 1)
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
		if Player.Functions.RemoveItem(v.item, 1) then
			Player.Functions.AddItem(v.recieve, math)
			TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[v.recieve], "add", math )
		end
	end)
end