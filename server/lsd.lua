local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:getlysergic', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.AddItem('lysergic_acid', 2) then
		TriggerClientEvent('QBCore:Notify', src, "you got Lysergic Acid", "success")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lysergic_acid'], "add", 2)
	end
end)

RegisterServerEvent('md-drugs:server:getdiethylamide', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.AddItem('diethylamide', 2) then 
	TriggerClientEvent('QBCore:Notify', src, "you got diethylamide", "success")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['diethylamide'], "add",  2)
	end
end)


QBCore.Functions.CreateUseableItem('lsdlabkit', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if TriggerClientEvent("md-drugs:client:setlsdlabkit", src) then
		Player.Functions.RemoveItem("lsdlabkit", 1)
	end
end)	


RegisterServerEvent('md-drugs:server:removecleaningkit', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem("cleaningkit", 1) then 
		TriggerClientEvent('QBCore:Notify', src, "Cleaned It Perfectly", "success")
		TriggerClientEvent("md-drugs:client:resetlsdkit", src)
	else
	TriggerClientEvent('QBCore:Notify', src, "You cant clean it with spit alone", "error")
	end
end)

RegisterServerEvent('md-drugs:server:getlabkitback', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("lsdlabkit", 1) then
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsdlabkit'], "add", 1)
	end
end)

RegisterServerEvent('md-drugs:server:heatliquid', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('diethylamide', 1) then 
		if Player.Functions.RemoveItem('lysergic_acid', 1) then 
			Player.Functions.AddItem('lsd_one_vial', 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['diethylamide'], "remove", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lysergic_acid'], "remove", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_one_vial'], "add", 1)
			TriggerClientEvent('QBCore:Notify', src, "you made some LSD", "success")
		else
		TriggerClientEvent('QBCore:Notify', src, "you aint got the right shit", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the right shit", "error")
	end
end)

RegisterServerEvent('md-drugs:server:failheating', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.RemoveItem('diethylamide', Config.diethylamideliquid) then 
	if Player.Functions.RemoveItem('lysergic_acid', Config.lysergicacidliquid) then 
		TriggerClientEvent('QBCore:Notify', src, "you overheated them idiot", "error")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['diethylamide'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lysergic_acid'], "remove", 1)
		end
	end
end)


RegisterServerEvent('md-drugs:server:refinequalityacid', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local randomchance = math.random(1,100)

if Player.Functions.RemoveItem('lsd_one_vial', 1) then 
	if randomchance <= 60 then 
		Player.Functions.AddItem('lsd_vial_two', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_two'], "add", 1)
		TriggerClientEvent('QBCore:Notify', src, "You Made Slightly Better LSD", "Success")
	elseif randomchance >= 61 and randomchance <= 75 then 
		Player.Functions.AddItem('lsd_vial_three', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_three'], "add", 1)
		TriggerClientEvent('QBCore:Notify', src, "You Made Decently Better LSD", "Success")
	elseif randomchance >= 76 and randomchance <= 85 then
		Player.Functions.AddItem('lsd_vial_four', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_four'], "add", 1)
		TriggerClientEvent('QBCore:Notify', src, "You Made Pretty good LSD", "Success")
	elseif randomchance >= 86 and randomchance <= 93 then
		Player.Functions.AddItem('lsd_vial_five', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_five'], "add", 1)		
		TriggerClientEvent('QBCore:Notify', src, "You Made Damn Good LSD", "Success")
	else 
		Player.Functions.AddItem('lsd_vial_six', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_six'], "add", 1)
		TriggerClientEvent('QBCore:Notify', src, "The Homies Will Be Trippin Balls", "Success")
		end
	end
end)

RegisterServerEvent('md-drugs:server:failrefinequality', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local randomchance = math.random(1,100)

if Player.Functions.RemoveItem('lsd_one_vial', 1) then 
	end
end)


RegisterServerEvent('md-drugs:server:gettabpaper', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local amount = math.random(5000, 20000)

	if Player.Functions.RemoveMoney('cash', amount) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['tab_paper'], "add", 10)
		Player.Functions.AddItem('tab_paper', 10)
	end
end)
 
RegisterServerEvent('md-drugs:server:getlabkit', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local amount = 10000

if Player.Functions.RemoveMoney('cash', 10000) then
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsdlabkit'], "add", 1)
	Player.Functions.AddItem('lsdlabkit', 1)
	end
end)




RegisterServerEvent('md-drugs:server:maketabpaper', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)


	if Player.Functions.RemoveItem('lsd_one_vial', 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_one_vial'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['tab_paper'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['smileyfacesheet'], "add", 1)
		Player.Functions.RemoveItem('tab_paper', 1)
		Player.Functions.AddItem('smileyfacesheet', 1)
	elseif Player.Functions.RemoveItem('lsd_vial_two', 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_two'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['tab_paper'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['wildcherrysheet'], "add", 1)
		Player.Functions.RemoveItem('tab_paper', 1)
		Player.Functions.AddItem('wildcherrysheet', 1)
	elseif Player.Functions.RemoveItem('lsd_vial_three', 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_three'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['tab_paper'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['yinyangsheet'], "add", 1)
		Player.Functions.RemoveItem('tab_paper', 1)
		Player.Functions.AddItem('yinyangsheet', 1)
	elseif Player.Functions.RemoveItem('lsd_vial_four', 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_four'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['tab_paper'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['pineapplesheet'], "add", 1)
		Player.Functions.RemoveItem('tab_paper', 1)
		Player.Functions.AddItem('pineapplesheet', 1)
	elseif  Player.Functions.RemoveItem('lsd_vial_five', 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_five'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['tab_paper'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bartsheet'], "add", 1)
		Player.Functions.RemoveItem('tab_paper', 1)
		Player.Functions.AddItem('bartsheet', 1)
	elseif Player.Functions.RemoveItem('lsd_vial_six', 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['lsd_vial_six'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['tab_paper'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['gratefuldeadsheet'], "add", 1)
		Player.Functions.RemoveItem('tab_paper', 1)
		Player.Functions.AddItem('gratefuldeadsheet', 1)
	else
	TriggerClientEvent('QBCore:Notify', src, "You Dont Got The Right Stuff", "error")
	end
end)	
	
	
QBCore.Functions.CreateUseableItem('smileyfacesheet', function(source)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local amount = math.random(1,10)

if Player.Functions.RemoveItem("smileyfacesheet", 1) then 
	Player.Functions.AddItem("Smiley_tabs", amount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['smileyfacesheet'], "remove", 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['Smiley_tabs'], "add", amount)
	end
end)

QBCore.Functions.CreateUseableItem('wildcherrysheet', function(source)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local amount = math.random(1,10)

if Player.Functions.RemoveItem("wildcherrysheet", 1) then 
	Player.Functions.AddItem("wildcherry_tabs", amount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['wildcherrysheet'], "remove", 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['wildcherry_tabs'], "add", amount)
	end
end)


QBCore.Functions.CreateUseableItem('yinyangsheet', function(source)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local amount = math.random(1,10)

if Player.Functions.RemoveItem("yinyangsheet", 1) then 
	Player.Functions.AddItem("yinyang_tabs", amount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['yinyangsheet'], "remove", 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['yinyang_tabs'], "add", amount)
	end
end)


QBCore.Functions.CreateUseableItem('pineapplesheet', function(source)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local amount = math.random(1,10)

if Player.Functions.RemoveItem("pineapplesheet", 1) then 
	Player.Functions.AddItem("pineapple_tabs", amount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['pineapplesheet'], "remove", 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['pineapple_tabs'], "add", amount)
	end
end)


QBCore.Functions.CreateUseableItem('bartsheet', function(source)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local amount = math.random(1,10)

if Player.Functions.RemoveItem("bartsheet", 1) then 
	Player.Functions.AddItem("bart_tabs", amount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bartsheet'], "remove", 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bart_tabs'], "add", amount)
	end
end)


QBCore.Functions.CreateUseableItem('gratefuldeadsheet', function(source)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local amount = math.random(1,10)

if Player.Functions.RemoveItem("gratefuldeadsheet", 1) then 
	Player.Functions.AddItem("gratefuldead_tabs", amount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['gratefuldeadsheet'], "remove", 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['gratefuldead_tabs'], "add", amount)
	end
end)

local lsd = { "smiley_tabs", "wildcherry_tabs", "yinyang_tabs", "pineapple_tabs", "bart_tabs",  "gratefuldead_tabs"}

for k, v in pairs (lsd) do QBCore.Functions.CreateUseableItem(v, function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if TriggerClientEvent('md-drugs:client:taketabs', src, item.name) then
	Player.Functions.RemoveItem(item.name, 1)
	end
end)
end
