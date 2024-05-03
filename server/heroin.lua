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

RegisterServerEvent('md-drugs:server:removecleaningkitheroin', function(data)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if RemoveItem("cleaningkit", 1) then
		Notifys("Cleaned It Perfectly", "success")
		TriggerClientEvent("md-drugs:client:deletedirtyheroin", src, data)
	else
		Notifys("You cant clean it with spit alone", "error")
	end
end)


RegisterServerEvent("heroin:pickupCane", function(loc)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.PoppyPlants[loc].location) then return end
    if not Config.PoppyPlants[loc].taken then
        Config.PoppyPlants[loc].taken = true
        GlobalState.PoppyPlants = Config.PoppyPlants
        TriggerClientEvent("heroin:removeCane", -1, loc)
        heroinCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        AddItem('poppyresin', 1)
        
    end
end)

RegisterServerEvent('md-drugs:server:dryplant', function(num)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.dryplant[num]['loc']) then return end
	if not Itemcheck(Player, 'poppyresin', 1, 'true') then return end
	if Config.TierSystem then
		local heroin = Player.PlayerData.metadata['heroin']
		if heroin <= Config.Tier1 then
			if RemoveItem("poppyresin", 1) then
				AddItem("heroin", 1)
			end
		elseif heroin >= Config.Tier1 and heroin <= Config.Tier2 then
			if RemoveItem("poppyresin", 1) then
				AddItem("heroinstagetwo", 1)
			end
		else
			if RemoveItem("poppyresin", 1) then
				AddItem("heroinstagethree", 1)
			end
		end
	else
		if RemoveItem("poppyresin", 1) then
			AddItem("heroin", 1)	
		end
	end
end)


RegisterServerEvent('md-drugs:server:cutheroin', function(num)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.cutheroinone[num]['loc']) then return end
	if not Itemcheck(Player, 'bakingsoda', 1, 'true') then return end
	if Config.TierSystem then
		local rawh = Player.Functions.GetItemByName('heroin')
		local rawh2 = Player.Functions.GetItemByName('heroinstagetwo')
		local rawh3 = Player.Functions.GetItemByName('heroinstagethree')
		if rawh then
			RemoveItem('heroin', 1 ) 
			RemoveItem('bakingsoda', 1 ) 
			AddItem('heroincut',1) 
			Notifys(Lang.Heroin.cutheroin, "success")
		elseif rawh2 then
			RemoveItem('heroinstagetwo', 1 ) 
			RemoveItem('bakingsoda', 1 ) 
			AddItem('heroincutstagetwo', 1) 
			Notifys(Lang.Heroin.cutheroin, "success")	
		elseif rawh3 then
			RemoveItem('heroinstagethree', 1 ) 
			RemoveItem('bakingsoda', 1 ) 
			AddItem('heroincutstagethree', 1) 
			Notifys(Lang.Heroin.cutheroin, "success")
		else
			Notifys(Lang.Heroin.noheroin, "error")
		end
	else
		if RemoveItem('heroin', 1 ) then
			RemoveItem('bakingsoda', 1 )
			AddItem('heroincut',1)
			Notifys(Lang.Heroin.cutheroin, "success")
		else
			Notifys(Lang.Heroin.noheroin, "error")
		end
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkit', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)

	if CheckDist(source, playerPed, vector3(Config.buyheroinlabkit.x,Config.buyheroinlabkit.y,Config.buyheroinlabkit.z)) then return end
	if Player.Functions.RemoveMoney('cash', Config.heroinlabkitprice) then
		AddItem('heroinlabkit', 1)
	else
		Notifys('You Need '.. Config.heroinlabkitprice .. ' In Cash For This', 'error')
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkitback', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("heroinlabkit", 1) then
		Notifys('You Got Your Lab Kit Back', 'Success')
	end
end)

QBCore.Functions.CreateUseableItem('heroinlabkit', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'heroinlabkit', 1, 'true') then return end
	if TriggerClientEvent("md-drugs:client:setheroinlabkit", src) then
		Player.Functions.RemoveItem("heroinlabkit", 1)
	end
end)



RegisterServerEvent('md-drugs:server:heatliquidheroin', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'emptyvial', 1, 'true') then return end
	if Config.TierSystem then
		local cuth = Player.Functions.GetItemByName('heroincut')
		local cuth2 = Player.Functions.GetItemByName('heroincutstagetwo')
		local cuth3 = Player.Functions.GetItemByName('heroincutstagethree')
		if cuth then
			RemoveItem('heroincut', 1) 
			RemoveItem('emptyvial', 1) 
			AddItem('heroinvial', 1)
			Notifys(Lang.Heroin.vial, "success")
		elseif cuth2 then
			RemoveItem('heroincutstagetwo', 1) 
			RemoveItem('emptyvial', 1) 
			AddItem('heroinvialstagetwo', 1)
			Notifys(Lang.Heroin.vial, "success")
		elseif cuth3 then
			RemoveItem('heroincutstagethree', 1) 
			RemoveItem('emptyvial', 1) 
			AddItem('heroinvialstagethree', 1)
			Notifys(Lang.Heroin.vial, "success")
		else
			Notifys(Lang.Heroin.novial, "error")
		end
	else
		if RemoveItem('heroincut', 1) then
			RemoveItem('emptyvial', 1) 
			AddItem('heroinvial', 1)
			Notifys(Lang.Heroin.vial, "success")
		else
			Notifys(Lang.Heroin.novial, "error")
		end
	end
end)

RegisterServerEvent('md-drugs:server:failheatingheroin', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local cuth = Player.Functions.GetItemByName('heroincut')
local cuth2 = Player.Functions.GetItemByName('heroincutstagetwo')
local cuth3 = Player.Functions.GetItemByName('heroincutstagethree')

	if cuth then
		RemoveItem('heroincut', 1) 
		Notifys(Lang.Heroin.fail, "error")
	elseif cuth2 then
		RemoveItem('heroincutstagetwo', 1) 
		Notifys(Lang.Heroin.fail, "error")
	elseif cuth3 then
		RemoveItem('heroincutstagethree', 1)
		Notifys(Lang.Heroin.fail, "error")
	end
end)


RegisterServerEvent('md-drugs:server:fillneedle', function(num)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.fillneedle[num]['loc']) then return end
	if not Itemcheck(Player, 'needle', 1, 'true') then return end
	if Config.TierSystem then
		local heroin = Player.PlayerData.metadata['heroin']
		local vh = Player.Functions.GetItemByName('heroinvial')
		local vh2 = Player.Functions.GetItemByName('heroinvialstagetwo')
		local vh3 = Player.Functions.GetItemByName('heroinvialstagethree')
		if vh then
			RemoveItem('heroinvial', 1 ) 
			RemoveItem('needle', 1) 
			AddItem('heroin_ready', 1) 
			Player.Functions.SetMetaData('heroin',  (heroin + 1))
			Notifys(Lang.Heroin.fill, "success")
		elseif vh2 then
			RemoveItem('heroinvialstagetwo', 1 ) 
			RemoveItem('needle', 1) 
			AddItem('heroin_readystagetwo', 1) 
			Player.Functions.SetMetaData('heroin',  (heroin + 1))
			Notifys(Lang.Heroin.fill, "success")
		elseif vh3 then
			RemoveItem('heroinvialstagethree', 1 ) 
			RemoveItem('needle', 1) 
			AddItem('heroin_readystagethree', 1) 
			Player.Functions.SetMetaData('heroin',  (heroin + 1))
			Notifys(Lang.Heroin.fill, "success")
		else
			Notifys(Lang.Heroin.nofill, "error")
		end
	else
		if RemoveItem('heroinvial', 1 ) then
		 	RemoveItem('needle', 1)
			AddItem('heroin_ready', 1)
			Notifys(Lang.Heroin.fill, "success")
		else
			Notifys(Lang.Heroin.nofill, "error")
		end
	end
end)



RegisterServerEvent('md-drugs:server:failheroin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Config.TierSystem then
		local vh = Player.Functions.GetItemByName('heroinvial')
		local vh2 = Player.Functions.GetItemByName('heroinvialstagetwo')
		local vh3 = Player.Functions.GetItemByName('heroinvialstagethree')
		if vh then RemoveItem('heroinvialstagethree', 1 ) 
		elseif vh2 then RemoveItem('heroinvialstagetwo', 1) 
		elseif vh3 then RemoveItem('heroinvial', 1)
		end
	else
		RemoveItem('heroinvial', 1)
	end
end)

