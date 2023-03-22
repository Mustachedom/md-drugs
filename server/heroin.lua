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
		Player.Functions.RemoveItem("poppyresin", 1)
		Player.Functions.AddItem("heroin", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin'], "add", Config.cokerecieve)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", Config.cocaleafbreakdown)
	elseif randomchance >= 76 and randomchance <= 90 then
		Player.Functions.RemoveItem("poppyresin", 1)
		Player.Functions.AddItem("heroinstagetwo", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cokestagetwo'], "add", Config.cokerecieve)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", Config.cocaleafbreakdown)
	else
		Player.Functions.RemoveItem("poppyresin", 1)
		Player.Functions.AddItem("heroinstagethree", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinstagethree'], "add", Config.cokerecieve)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['poppyresin'], "remove", Config.cocaleafbreakdown)
	end
end)


RegisterServerEvent('md-drugs:server:cutheroin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,4)
	if Player.Functions.RemoveItem('heroin', chance ) then
		if Player.Functions.RemoveItem('bakingsoda', chance ) then
			if Player.Functions.AddItem('heroincut',chance) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincut'], "add", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroin'], "remove", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", chance)
			
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
		end
	elseif Player.Functions.RemoveItem('heroinstagetwo', chance ) then
		if Player.Functions.RemoveItem('bakingsoda', chance ) then
			if Player.Functions.AddItem('heroincutstagetwo', chance) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagetwo'], "add", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinstagetwo'], "remove", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", chance)
			
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
		end
	elseif Player.Functions.RemoveItem('heroinstagethree', chance ) then
		if Player.Functions.RemoveItem('bakingsoda', chance ) then
			if Player.Functions.AddItem('heroincutstagethree', chance) then
				TriggerClientEvent('QBCore:Notify', src, "you make some cut coke", "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagethree'], "add", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinstagethree'], "remove", chance)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['bakingsoda'], "remove", chance)
			end
		else 
		TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
		end
	
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the powder", "error")
	end
end)

	
QBCore.Functions.CreateUseableItem('heroinlabkit', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local randomchance = math.random(1,100)

if Player.Functions.RemoveItem("heroinlabkit", 1) then
	if randomchance <= 80 then 
		TriggerClientEvent("md-drugs:client:heatliquidheroin", src)
		Player.Functions.AddItem("heroinlabkit", 1)
		TriggerClientEvent('QBCore:Notify', src, "you got some heroin", "success")
	else
		Player.Functions.AddItem('dirtyheroinlabkit', 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['dirtyheroinlabkit'], "add", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinlabkit'], "remove", 1)
		TriggerClientEvent('QBCore:Notify', src, "you ruined your kit!", "error")
	end
end
end)


QBCore.Functions.CreateUseableItem('dirtyheroinlabkit', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.RemoveItem("cleaningkit", 1) then
	if Player.Functions.RemoveItem("dirtyheroinlabkit", 1) then
		Player.Functions.AddItem("heroinlabkit", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['dirtyheroinlabkit'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cleaningkit'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinlabkit'], "add", 1)
		TriggerClientEvent('QBCore:Notify', src, "You cleaned that so well!", "success")
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the right stuff", "error")
	end
else
TriggerClientEvent('QBCore:Notify', src, "how you gonna clean that?", "error")
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
	if Player.Functions.RemoveItem('heroincutstagetwo', 1) then 
		Player.Functions.RemoveItem('heroincutstagethree', 1)
		TriggerClientEvent('QBCore:Notify', src, "you overheated them idiot", "error")
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincut'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagetwo'], "remove", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroincutstagethree'], "remove", 1)
	
	end
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
		TriggerClientEvent('QBCore:Notify', src, "you dont have a syring", "error")
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
		TriggerClientEvent('QBCore:Notify', src, "you dont have a syring", "error")
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
		TriggerClientEvent('QBCore:Notify', src, "you dont have a syring", "error")
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

