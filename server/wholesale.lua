local QBCore = exports['qb-core']:GetCoreObject()



QBCore.Functions.CreateUseableItem("cokeburner", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	
	if Player.Functions.RemoveItem("cokeburner", 1) then
	TriggerClientEvent("md-drugs:client:getloccoke", src)
	TriggerClientEvent('QBCore:Notify', src, "Bring Me 100 Of One Type Of Coke", "success")
	end 
end)
 
RegisterServerEvent('md-drugs:server:wholesalecoke', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local income = math.random(1000,2000)
	local income2 = math.random(1200,2200)
	local income3 = math.random(1400,1600)
	
	if Player.Functions.RemoveItem("cokebaggy", 100) then
		if Player.Functions.AddMoney("cash", income) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggy'], "remove", 100)
		end
	elseif Player.Functions.RemoveItem("cokebaggystagetwo", 100) then
		if Player.Functions.AddMoney("cash", income2) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggystagetwo'], "remove", 100)
		end	
	elseif Player.Functions.RemoveItem("cokebaggystagethree", 100) then
		if Player.Functions.AddMoney("cash", income3) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokebaggystagethree'], "remove", 100)
		end
	else 
	TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
	end
end)

--------------------- crack


QBCore.Functions.CreateUseableItem("crackburner", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	
	if Player.Functions.RemoveItem("crackburner", 1) then
	TriggerClientEvent("md-drugs:client:getloccrack", src)
	TriggerClientEvent('QBCore:Notify', src, "Bring Me 100 Of One Type Of Crack", "success")
	end 
end)
 
RegisterServerEvent('md-drugs:server:wholesalecrack', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local income = math.random(1000,2000)
	local income2 = math.random(1200,2200)
	local income3 = math.random(1400,2400)
	
	if Player.Functions.RemoveItem("baggedcracked", 100) then
		if Player.Functions.AddMoney("cash", income) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['baggedcracked'], "remove", 100)
		end
	elseif Player.Functions.RemoveItem("baggedcrackedstagetwo", 100) then
		if Player.Functions.AddMoney("cash", income2) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['baggedcrackedstagetwo'], "remove", 100)
		end	
	elseif Player.Functions.RemoveItem("baggedcrackedstagethree", 100) then
		if Player.Functions.AddMoney("cash", income3) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['baggedcrackedstagethree'], "remove", 100)
		end
	else 
	TriggerClientEvent('QBCore:Notify', src, "you aint got bags", "error")
	end
end)
----------------- lsd

QBCore.Functions.CreateUseableItem("lsdburner", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	
	if Player.Functions.RemoveItem("lsdburner", 1) then
	TriggerClientEvent("md-drugs:client:getloclsd", src)
	TriggerClientEvent('QBCore:Notify', src, "Bring Me 500 Of One Type Of Tabs", "success")
	end 
end)
 
RegisterServerEvent('md-drugs:server:wholesalelsd', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local income = math.random(1000,2000)
	local income2 = math.random(1200,2200)
	local income3 = math.random(1400,2400)
	local income4 = math.random(1600,2600)
	local income5 = math.random(1800, 2800)
	local income6 = math.random(2000,3000)
	
	if Player.Functions.RemoveItem("smiley_tabs", 500) then
		if Player.Functions.AddMoney("cash", income) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['smiley_tabs'], "remove", 500)
		end
	elseif Player.Functions.RemoveItem("wildcherry_tabs", 500) then
		if Player.Functions.AddMoney("cash", income2) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['wildcherry_tabs'], "remove", 500)
		end	
	elseif Player.Functions.RemoveItem("yinyang_tabs", 500) then
		if Player.Functions.AddMoney("cash", income3) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['yinyang_tabs'], "remove", 500)
		end
	elseif Player.Functions.RemoveItem("pineapple_tabs", 500) then
		if Player.Functions.AddMoney("cash", income4) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['pineapple_tabs'], "remove", 500)
		end	
	elseif Player.Functions.RemoveItem("bart_tabs", 500) then
		if Player.Functions.AddMoney("cash", income5) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bart_tabs'], "remove", 500)
		end
	elseif Player.Functions.RemoveItem("gratefuldead_tabs", 500) then
		if Player.Functions.AddMoney("cash", income6) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['gratefuldead_tabs'], "remove", 500)
		end
	else 
	TriggerClientEvent('QBCore:Notify', src, "you aint got enough tabs", "error")
	end
end)
----------------- heroin

QBCore.Functions.CreateUseableItem("heroinburner", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	
	if Player.Functions.RemoveItem("heroinburner", 1) then
	TriggerClientEvent("md-drugs:client:getlocheroin", src)
	TriggerClientEvent('QBCore:Notify', src, "Bring Me 100 Of One Type Of Heroin", "success")
	end 
end)
 
RegisterServerEvent('md-drugs:server:wholesaleheroin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local income = math.random(1000,2000)
	local income2 = math.random(1200,2200)
	local income3 = math.random(1400,2400)
	
	if Player.Functions.RemoveItem("heroin_ready", 100) then
		if Player.Functions.AddMoney("cash", income) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin_ready'], "remove", 100)
		end
	elseif Player.Functions.RemoveItem("heroin_readystagetwo", 100) then
		if Player.Functions.AddMoney("cash", income2) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin_readystagetwo'], "remove", 100)
		end	
	elseif Player.Functions.RemoveItem("heroin_readystagethree", 100) then
		if Player.Functions.AddMoney("cash", income3) then
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin_readystagethree'], "remove", 100)
		end
	else 
	TriggerClientEvent('QBCore:Notify', src, "you aint got needles", "error")
	end
end)









