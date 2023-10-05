local QBCore = exports['qb-core']:GetCoreObject()
GlobalState.PoppyPlants = Config.PoppyPlants


Citizen.CreateThread(function()
    for _, v in pairs(Config.PoppyPlants) do
        v.taken = false
    end
end)


function heroinCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        Config.PoppyPlants[loc].taken = false
        GlobalState.PoppyPlants = Config.PoppyPlants
        Wait(1000)
        TriggerClientEvent('heroin:respawnCane', -1, loc)
    end)
end

RegisterServerEvent('md-drugs:server:removecleaningkitheroin', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem("cleaningkit", 1) then 
		TriggerClientEvent('QBCore:Notify', src, "Cleaned It Perfectly", "success")
		TriggerClientEvent("md-drugs:client:deletedirtyheroin", src)
		TriggerClientEvent("md-drugs:client:resetheroinkit", src)
	else
	TriggerClientEvent('QBCore:Notify', src, "You cant clean it with spit alone", "error")
	end
end)

RegisterNetEvent("heroin:pickupCane")
AddEventHandler("heroin:pickupCane", function(loc)
    if not Config.PoppyPlants[loc].taken then
        Config.PoppyPlants[loc].taken = true
        GlobalState.PoppyPlants = Config.PoppyPlants
        TriggerClientEvent("heroin:removeCane", -1, loc)
        heroinCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem(Config.rewardItemheroin, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.rewardItemheroin], "add")
    end
end)

RegisterServerEvent('md-drugs:server:dryplant', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local randomchance = math.random(1,100)
		
	if randomchance <= 75 then 
		if Player.Functions.RemoveItem("poppyresin", 1) then
    		Player.Functions.AddItem("heroin", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin'], "add", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", 1)
        end
	elseif randomchance >= 76 and randomchance <= 90 then
		if Player.Functions.RemoveItem("poppyresin", 1) then
    		Player.Functions.AddItem("heroinstagetwo", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokestagetwo'], "add", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", 1)
        end
	else
		if Player.Functions.RemoveItem("poppyresin", 1) then
		Player.Functions.AddItem("heroinstagethree", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinstagethree'], "add", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", 1)
        end
	end
end)


RegisterServerEvent('md-drugs:server:cutheroin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.RemoveItem('heroin', 1 ) then
		if Player.Functions.RemoveItem('bakingsoda', 1 ) then
			if Player.Functions.AddItem('heroincut',1) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincut'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 1)
			
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
		end
	elseif Player.Functions.RemoveItem('heroinstagetwo', 1 ) then
		if Player.Functions.RemoveItem('bakingsoda', 1 ) then
			if Player.Functions.AddItem('heroincutstagetwo', 1) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagetwo'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinstagetwo'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 1)
			
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
		end
	elseif Player.Functions.RemoveItem('heroinstagethree', 1 ) then
		if Player.Functions.RemoveItem('bakingsoda', 1 ) then
			if Player.Functions.AddItem('heroincutstagethree', 1) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagethree'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinstagethree'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", 1)
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
		end
	
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkit', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.RemoveMoney('cash', 10000) then
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinlabkit'], "add", 1)
	Player.Functions.AddItem('heroinlabkit', 1)
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkitback', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("heroinlabkit", 1) then
	end
end)

QBCore.Functions.CreateUseableItem('heroinlabkit', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if TriggerClientEvent("md-drugs:client:setheroinlabkit", src) then
		Player.Functions.RemoveItem("heroinlabkit", 1)
	end
end)



RegisterServerEvent('md-drugs:server:heatliquidheroin', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('heroincut', 1) then 
		if Player.Functions.RemoveItem('emptyvial', 1) then 
			Player.Functions.AddItem('heroinvial', 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincut'], "remove", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['emptyvial'], "remove", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvial'], "add", 1)
			TriggerClientEvent('QBCore:Notify', src, "you made some heroin", "success")
		else
		TriggerClientEvent('QBCore:Notify', src, "you aint got the right shit", "error")
		end
	elseif Player.Functions.RemoveItem('heroincutstagetwo', 1) then
		if Player.Functions.RemoveItem('emptyvial', 1) then
			Player.Functions.AddItem('heroinvialstagetwo', 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagetwo'], "remove", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['emptyvial'], "remove", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvialstagetwo'], "add", 1)
			TriggerClientEvent('QBCore:Notify', src, "you made some heroin", "success")
		else
		TriggerClientEvent('QBCore:Notify', src, "you aint got the right shit", "error")
		end
	elseif Player.Functions.RemoveItem('heroincutstagethree', 1) then
		if Player.Functions.RemoveItem('emptyvial', 1) then
			Player.Functions.AddItem('heroinvialstagethree', 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagethree'], "remove", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['emptyvial'], "remove", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvialstagethree'], "add", 1)
			TriggerClientEvent('QBCore:Notify', src, "you made some heroin", "success")
		else
		TriggerClientEvent('QBCore:Notify', src, "you aint got the right shit", "error")
		end
	else 
	TriggerClientEvent('QBCore:Notify', src, "you aint got the right shit", "error")
	end
end)

RegisterServerEvent('md-drugs:server:failheatingheroin', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.RemoveItem('heroincut', 1) then 
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincut'], "remove", 1)
		TriggerClientEvent('QBCore:Notify', src, "you overheated them idiot", "error")
	elseif Player.Functions.RemoveItem('heroincutstagetwo', 1) then 
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagetwo'], "remove", 1)
		TriggerClientEvent('QBCore:Notify', src, "you overheated them idiot", "error")
	else
		Player.Functions.RemoveItem('heroincutstagethree', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagethree'], "remove", 1)
		TriggerClientEvent('QBCore:Notify', src, "you overheated them idiot", "error")
	end

end)


RegisterServerEvent('md-drugs:server:fillneedle', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.RemoveItem('heroinvial', 1 ) then
		if Player.Functions.RemoveItem('needle', 1) then
			if Player.Functions.AddItem('heroin_ready', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin_ready'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvial'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['needle'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "you got bags", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you dont have a syringe", "error")
		end
	elseif Player.Functions.RemoveItem('heroinvialstagetwo', 1 ) then
		if Player.Functions.RemoveItem('needle', 1) then
			if Player.Functions.AddItem('heroin_readystagetwo', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin_readystagetwo'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvialstagetwo'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['needle'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "you got bags", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you dont have a syringe", "error")
		end
	elseif Player.Functions.RemoveItem('heroinvialstagethree', 1 ) then
		if Player.Functions.RemoveItem('needle', 1) then
			if Player.Functions.AddItem('heroin_readystagethree', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin_readystagethree'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvialstagethree'], "remove", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['needle'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "you got bags", "success")
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you dont have a syringe", "error")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the supplies", "error")
	end
end)



RegisterServerEvent('md-drugs:server:failheroin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.RemoveItem('heroinvialstagethree', 1 ) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvialstagethree'], "remove", 1)
	elseif Player.Functions.RemoveItem('heroinvialstagetwo', 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvialstagetwo'], "remove", 1)
	else 
		Player.Functions.RemoveItem('heroinvial', 1) 
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvial'], "remove", 1)
	end
end)

