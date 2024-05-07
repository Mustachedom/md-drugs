local QBCore = exports['qb-core']:GetCoreObject()
local QBCore = exports['qb-core']:GetCoreObject()

GlobalState.WeedPlant = Config.WeedPlant

Citizen.CreateThread(function()
    for _, v in pairs(Config.WeedPlant) do
        v.taken = false
    end
end)

function WeedCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        Config.WeedPlant[loc].taken = false
        GlobalState.WeedPlant = Config.WeedPlant
        Wait(1000)
        TriggerClientEvent('weed:respawnCane', -1, loc)
    end)
end

RegisterNetEvent("weed:pickupCane")
AddEventHandler("weed:pickupCane", function(loc)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.WeedPlant[loc].location) then return end
    if not Config.WeedPlant[loc].taken then
        Config.WeedPlant[loc].taken = true
        GlobalState.WeedPlant = Config.WeedPlant
        TriggerClientEvent("weed:removeCane", -1, loc)
        WeedCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        AddItem('wetcannabis', 1)
    end
end)
--------------- events
RegisterServerEvent('md-drugs:server:dryoutweed', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if RemoveItem("wetcannabis", 1) then
    	AddItem("drycannabis", 1)
    else
		Notifys(Lang.Weed.nodry, "error")
	end
end)


RegisterServerEvent('md-drugs:server:makebutter', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'mdbutter', 1, 'true') and  not Itemcheck(Player, 'grindedweed', 1, 'true') then return end		
	  RemoveItem('mdbutter', 1) 
	  RemoveItem('grindedweed', 1) 
	  AddItem('cannabutter', 1 )
		
end)


RegisterServerEvent('md-drugs:server:makebrownies', function()
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)

	if not Itemcheck(Player, 'cannabutter', 1, 'true') and  not Itemcheck(Player, 'flour', 1, 'true') and  not Itemcheck(Player,'chocolate', 1, 'true') then return end
		RemoveItem('cannabutter', 1)
		RemoveItem('flour', 1)
		RemoveItem('chocolate', 1)
		AddItem('specialbrownie', 1 )
end)

RegisterServerEvent('md-drugs:server:makecookies', function()
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'cannabutter', 1, 'true') and not Itemcheck(Player, 'flour', 1, 'true') then return end
		RemoveItem('cannabutter', 1)
		RemoveItem('flour', 1)
		AddItem('specialcookie', 1 ) 
end)

RegisterServerEvent('md-drugs:server:makechocolate', function()
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
 	if not Itemcheck(Player, 'cannabutter', 1, 'true') and not Itemcheck(Player, 'chocolate', 1, 'true') then return end
		RemoveItem('cannabutter', 1)
		RemoveItem('chocolate', 1)
		AddItem('specialchocolate', 1 ) 
end)

RegisterServerEvent('md-drugs:server:makemuffin', function()
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'cannabutter', 1, 'true') and not Itemcheck(Player, 'flour', 1, 'true') then return end
		RemoveItem('cannabutter', 1)
		RemoveItem('flour', 1)
		AddItem('specialmuffin', 1 )
end)

RegisterServerEvent('md-drugs:server:makeoil', function()
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'grindedweed', 1, 'true') and not Itemcheck(Player, 'butane', 1, 'true') then return end
		RemoveItem('butane', 1)
		RemoveItem('grindedweed', 1)
		AddItem('shatter', 1 ) 
end)



RegisterServerEvent('md-drugs:server:rollblunt', function()
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
  
  	if not Itemcheck(Player, 'grindedweed', 1, 'true') and not Itemcheck(Player, 'bluntwrap', 1, 'true') then return end
	  TriggerClientEvent("md-drugs:client:rollanim", src)
 	 	RemoveItem('bluntwrap', 1)
  		RemoveItem('grindedweed', 1)
		AddItem('blunt', 1 ) 
end)

RegisterServerEvent('md-drugs:server:rollleanblunt', function()
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
  	local chance = math.random(1,10)
  	if not Itemcheck(Player, 'mdlean', 1, 'true') and not Itemcheck(Player, 'bluntwrap', 1, 'true') then return end
	  TriggerClientEvent("md-drugs:client:rollanim", src)
		RemoveItem("bluntwrap", 1)
		AddItem("leanbluntwrap", 1)
	if chance > 8 then
		RemoveItem("mdlean", 1)
	end
	
end)

RegisterServerEvent('md-drugs:server:rolldextroblunt', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local chance = math.random(1,10)
  if not Itemcheck(Player, 'mdreddextro', 1, 'true') and not Itemcheck(Player, 'bluntwrap', 1, 'true') then return end
	RemoveItem("bluntwrap", 1)
	AddItem("dextrobluntwrap", 1)
	TriggerClientEvent("md-drugs:client:rollanim", src)
	if chance > 8 then
		Player.Functions.RemoveItem("mdreddextro", 1)
	end	
end)

RegisterServerEvent('md-drugs:server:rollchewyblunt', function()
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
  	if not Itemcheck(Player, 'loosecoke', 1, 'true') and not Itemcheck(Player, 'bluntwrap', 1, 'true') and not Itemcheck(Player, 'grindedweed', 1, 'true') then return end
		RemoveItem("bluntwrap", 1)
		RemoveItem("loosecoke", 1)
		RemoveItem("grindedweed", 1)
		AddItem("chewyblunt", 1)
		TriggerClientEvent("md-drugs:client:rollanim", src)
end)
------------------------ usuable items
QBCore.Functions.CreateUseableItem("leanbluntwrap", function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local keef = Player.Functions.GetItemByName("grindedweed")
	
	if keef and keef.amount > 0 then 
		if Player.Functions.RemoveItem('grindedweed', 1) then
			TriggerClientEvent("md-drugs:client:rollanim", src)
			Player.Functions.RemoveItem("leanbluntwrap", 1) 
			Player.Functions.AddItem('leanblunts', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['leanblunts'], "add", 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['grindedweed'], "remove", 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['leanbluntwrap'], "remove", 1)
		end
	else
		Notifys(Lang.Weed.noweed, "error")
	end
end)
QBCore.Functions.CreateUseableItem("dextrobluntwrap", function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local keef = Player.Functions.GetItemByName("grindedweed")
	
	if keef and keef.amount > 0 then 
		if Player.Functions.RemoveItem('grindedweed', 1) then
			TriggerClientEvent("md-drugs:client:rollanim", src)
			Player.Functions.RemoveItem("dextrobluntwrap", 1) 
			Player.Functions.AddItem('dextroblunts', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['dextroblunts'], "add", 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['grindedweed'], "remove", 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['dextrobluntwrap'], "remove", 1)
		end
	else
		Notifys(Lang.Weed.noweed, "error")
	end
end)





QBCore.Functions.CreateUseableItem("dabrig", function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.GetItemByName("butanetorch") then 
	if Player.Functions.RemoveItem("shatter", 1) then
    	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["shatter"], "remove", 1)
    	TriggerClientEvent("md-drugs:client:dodabs", src)
	else
        Notifys(Lang.Weed.noshat, "error")
    end
else
Notifys(Lang.Weed.notorch, "error")
end
end)
QBCore.Functions.CreateUseableItem("bluntwrap", function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
TriggerClientEvent('md-drugs:client:bluntwraps', src)
end)

QBCore.Functions.CreateUseableItem("weedgrinder", function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
if Player.Functions.RemoveItem("drycannabis",1 ) then 
	Player.Functions.AddItem("grindedweed", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["grindedweed"], "add", 1)
	TriggerClientEvent("md-drugs:client:grind", src)
end
end)

QBCore.Functions.CreateUseableItem("mdwoods", function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
TriggerClientEvent("md-drugs:client:rollanim", src)
Wait(4000)
if Player.Functions.RemoveItem("mdwoods",1 ) then 
	Player.Functions.AddItem("bluntwrap", 5)
	Player.Functions.AddItem("tobacco", 5)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["bluntwrap"], "add", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["tobacco"], "add", 1)
end
end)

