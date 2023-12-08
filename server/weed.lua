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
    if not Config.WeedPlant[loc].taken then
        Config.WeedPlant[loc].taken = true
        GlobalState.WeedPlant = Config.WeedPlant
        TriggerClientEvent("weed:removeCane", -1, loc)
        WeedCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.AddItem(Config.rewardWeed, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.rewardWeed], "add")
    end
end)
--------------- events
RegisterServerEvent('md-drugs:server:dryoutweed', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem("wetcannabis", 1) then
    	Player.Functions.AddItem("drycannabis", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['drycannabis'], "add", 1)
    		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['wetcannabis'], "remove", 1)
     else
	TriggerClientEvent('QBCore:Notify', src, "Nothing To Dry", "error")
	end
end)


RegisterServerEvent('md-drugs:server:makebutter', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local recipe = {"mdbutter", "grindedweed"}
  local grind = Player.Functions.GetItemByName("grindedweed")
  local lock = Player.Functions.GetItemByName('mdbutter') 
  local price = 0
  for k, v in pairs (recipe) do 
		if lock and lock.amount > 0 then
			if grind and grind.amount > 0 then
				if Player.Functions.RemoveItem(v, 1) then
					price = 1
				end
			end	
		end
	end				
	if price == 1 then 
		Player.Functions.AddItem('cannabutter', 1 )
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cannabutter'], "add", 1)
		
	end
end)


RegisterServerEvent('md-drugs:server:makebrownies', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local recipe = {"cannabutter", "flour", "chocolate"}
  local butter = Player.Functions.GetItemByName("cannabutter")
  local flour = Player.Functions.GetItemByName('flour') 
   local choc = Player.Functions.GetItemByName('chocolate') 
  local price = 0
  for k, v in pairs (recipe) do 
		if butter and butter.amount > 0 then
			if flour and flour.amount > 0 then
				if choc and choc.amount > 0 then
					if Player.Functions.RemoveItem(v, 1) then
						price = 1
					end
				end	
			end	
		end
	end				
	if price == 1 then 
		Player.Functions.AddItem('specialbrownie', 1 )
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['specialbrownie'], "add", 1)
	end
end)

RegisterServerEvent('md-drugs:server:makecookies', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local recipe = {"cannabutter", "flour"}
  local butter = Player.Functions.GetItemByName("cannabutter")
  local flour = Player.Functions.GetItemByName('flour')  
  local price = 0
  for k, v in pairs (recipe) do 
		if butter and butter.amount > 0 then
			if flour and flour.amount > 0 then
				if Player.Functions.RemoveItem(v, 1) then
					price = 1
				end
				
			end	
		end
	end				
	if price == 1 then 
		Player.Functions.AddItem('specialcookie', 1 ) 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['specialcookie'], "add", 1)
	end
end)

RegisterServerEvent('md-drugs:server:makechocolate', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local recipe = {"cannabutter", "chocolate"}
  local butter = Player.Functions.GetItemByName("cannabutter")
  local choc = Player.Functions.GetItemByName('chocolate')  
  local price = 0
  for k, v in pairs (recipe) do 
		if butter and butter.amount > 0 then
			if choc and choc.amount > 0 then
				if Player.Functions.RemoveItem(v, 1) then
					price = 1
				end
				
			end	
		end
	end				
	if price == 1 then 
		Player.Functions.AddItem('specialchocolate', 1 ) 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['specialchocolate'], "add", 1)
	end
end)

RegisterServerEvent('md-drugs:server:makemuffin', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local recipe = {"cannabutter", "flour"}
  local butter = Player.Functions.GetItemByName("cannabutter")
  local flour = Player.Functions.GetItemByName('flour')  
  local price = 0
  for k, v in pairs (recipe) do 
		if butter and butter.amount > 0 then
			if flour and flour.amount > 0 then
				if Player.Functions.RemoveItem(v, 1) then
					price = 1
				end
				
			end	
		end
	end				
	if price == 1 then 
		Player.Functions.AddItem('specialmuffin', 1 ) 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['specialmuffin'], "add", 1)
	end
end)

RegisterServerEvent('md-drugs:server:makeoil', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local recipe = {"butane", "grindedweed"}
  local grind = Player.Functions.GetItemByName("grindedweed")
  local butane = Player.Functions.GetItemByName('butane') 
  local price = 0
  for k, v in pairs (recipe) do 
		if butane and butane.amount > 0 then
			if grind and grind.amount > 0 then
				if Player.Functions.RemoveItem(v, 1) then
					price = 1
				end
			end	
		end
	end				
	if price == 1 then 
		Player.Functions.AddItem('shatter', 1 ) 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['shatter'], "add", 1)
	end
end)



RegisterServerEvent('md-drugs:server:rollblunt', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local recipe = {"bluntwrap", "grindedweed"}
  local grind = Player.Functions.GetItemByName("grindedweed")
  local butane = Player.Functions.GetItemByName('bluntwrap') 
  local price = 0
  for k, v in pairs (recipe) do 
		if butane and butane.amount > 0 then
			if grind and grind.amount > 0 then
				if Player.Functions.RemoveItem(v, 1) then
					TriggerClientEvent("md-drugs:client:rollanim", src)
					price = 1
				end
			end	
		end
	end				
	if price == 1 then 
		Player.Functions.AddItem('blunt', 1 ) 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['blunt'], "add", 1)
	end
end)

RegisterServerEvent('md-drugs:server:rollleanblunt', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local grind = Player.Functions.GetItemByName("mdlean")
  local wrap = Player.Functions.GetItemByName('bluntwrap') 
  local chance = math.random(1,10)
	if grind.amount > 0 then
		if wrap.amount > 0 then
			Player.Functions.RemoveItem("bluntwrap", 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bluntwrap'], "remove", 1)
			TriggerClientEvent("md-drugs:client:rollanim", src)
			if chance > 8 then
				Player.Functions.RemoveItem("mdlean", 1)
			end
			Player.Functions.AddItem("leanbluntwrap", 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['leanbluntwrap'], "add", 1)
		end
	end
end)

RegisterServerEvent('md-drugs:server:rolldextroblunt', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local grind = Player.Functions.GetItemByName("mdreddextro")
  local wrap = Player.Functions.GetItemByName('bluntwrap') 
  local chance = math.random(1,10)
	if grind and grind.amount > 0 then
		if wrap and wrap.amount > 0 then
			Player.Functions.RemoveItem("bluntwrap", 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bluntwrap'], "remove", 1)
			TriggerClientEvent("md-drugs:client:rollanim", src)
			if chance > 8 then
				Player.Functions.RemoveItem("mdreddextro", 1)
			end	
			Player.Functions.AddItem("dextrobluntwrap", 1)
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['dextrobluntwrap'], "add", 1)
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "You Need Red Dextro", "error")
	end
end)

RegisterServerEvent('md-drugs:server:rollchewyblunt', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local coke = Player.Functions.GetItemByName("loosecoke")
  local wrap = Player.Functions.GetItemByName('bluntwrap') 
  local keef = Player.Functions.GetItemByName('grindedweed') 
  local chance = math.random(1,10)
	if coke and coke.amount > 0 then
		if wrap and wrap.amount > 0 then
			if keef and keef.amount > 0 then
				Player.Functions.RemoveItem("bluntwrap", 1)
				TriggerClientEvent("md-drugs:client:rollanim", src)
				Player.Functions.RemoveItem("loosecoke", 1)
				Player.Functions.RemoveItem("grindedweed", 1)
				Player.Functions.AddItem("chewyblunt", 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['chewyblunt'], "add", 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['loosecoke'], "remove", 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['grindedweed'], "remove", 1)
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bluntwrap'], "remove", 1)
			else
			TriggerClientEvent('QBCore:Notify', src, "You Need Some Keef", "error")
			end	
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "You Need Some Loose Coke", "error")
	end
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
	TriggerClientEvent('QBCore:Notify', src, "Cant Roll A blunt With Air", "error")
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
	TriggerClientEvent('QBCore:Notify', src, "Cant Roll A blunt With Air", "error")
	end
end)

local blunts = { 'dextroblunts', 'leanblunts', "chewyblunt", 'blunt' }
for k, v in pairs (blunts) do QBCore.Functions.CreateUseableItem(v, function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if TriggerClientEvent('md-drugs:client:smokeblunts', source, item.name) then
		Player.Functions.RemoveItem(item.name, 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item.name], "remove", 1)
	end
end)
end

local edibles = { 'specialcookie', 'specialbrownie', "specialmuffin", 'specialchocolate' }
for k, v in pairs (edibles) do QBCore.Functions.CreateUseableItem(v, function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if TriggerClientEvent("md-drugs:client:edibles", source, item.name) then
		Player.Functions.RemoveItem(item.name, 1)
	end
end)
end

QBCore.Functions.CreateUseableItem("dabrig", function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.GetItemByName("butanetorch") then 
	if Player.Functions.RemoveItem("shatter", 1) then
    	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["shatter"], "remove", 1)
    	TriggerClientEvent("md-drugs:client:dodabs", src)
	end
else
TriggerClientEvent('QBCore:Notify', src, "You Need A Butane Torch", "error")
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
	TriggerClientEvent("md-drugs:client:rollanim", src)
end
end)

QBCore.Functions.CreateUseableItem("mdwoods", function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.RemoveItem("mdwoods",1 ) then 
	Player.Functions.AddItem("bluntwrap", 5)
	Player.Functions.AddItem("tobacco", 5)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["bluntwrap"], "add", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["tobacco"], "add", 1)
	TriggerClientEvent("md-drugs:client:rollanim", src)
end
end)

