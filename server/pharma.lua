local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:fillprescription', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.RemoveItem('vicodin_prescription', 1 ) then
		if Player.Functions.AddItem('vicodinbottle', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['vicodinbottle'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['vicodin_prescription'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "got some pills!", "success")
		end
	elseif Player.Functions.RemoveItem('adderal_prescription', 1 ) then
		if Player.Functions.AddItem('adderalbottle', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['adderalbottle'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['adderal_prescription'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "got some pills!", "success")
		end
	elseif Player.Functions.RemoveItem('morphine_prescription', 1 ) then
		if Player.Functions.AddItem('morphinebottle', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['vicodinbottle'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['morphine_prescription'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "got some pills!", "success")
		end
	elseif Player.Functions.RemoveItem('xanax_prescription', 1 ) then
		if Player.Functions.AddItem('xanaxbottle', 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['xanaxbottle'], "add", 1)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['vicodin_prescription'], "remove", 1)
				TriggerClientEvent('QBCore:Notify', src, "got some pills!", "success")
		end
	else
	TriggerClientEvent('QBCore:Notify', src, "you aint got the supplies", "error")
	end
end)

QBCore.Functions.CreateUseableItem('vicodinbottle', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local luck = math.random(10,30)

if TriggerClientEvent('md-drugs:client:openingvicodin', src, item.name) then
	Player.Functions.AddItem('vicodin', luck)
	Player.Functions.RemoveItem('vicodinbottle', 1)
	TriggerClientEvent('QBCore:Notify', src,"You got ".. luck .. "Vicodin!", "success")
	end
end)

QBCore.Functions.CreateUseableItem('adderalbottle', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local luck = math.random(10,30)

if TriggerClientEvent('md-drugs:client:openingadderal', src, item.name) then
	Player.Functions.AddItem('adderal', luck)
	Player.Functions.RemoveItem('adderalbottle', 1)
	TriggerClientEvent('QBCore:Notify', src,"You got ".. luck .. "Adderal!", "success")
	end
end)

QBCore.Functions.CreateUseableItem('morphinebottle', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local luck = math.random(10,30)

if TriggerClientEvent('md-drugs:client:openingmorphine', src, item.name) then
	Player.Functions.AddItem('morphine', luck)
	Player.Functions.RemoveItem('morphinebottle', 1)
	TriggerClientEvent('QBCore:Notify', src,"You got ".. luck .. "Morphine!", "success")
	end
end)

QBCore.Functions.CreateUseableItem('xanaxbottle', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local luck = math.random(10,30)

if TriggerClientEvent('md-drugs:client:openingxanax', src, item.name) then
	Player.Functions.AddItem('xanax', luck)
	Player.Functions.RemoveItem('xanaxbottle', 1)
	TriggerClientEvent('QBCore:Notify', src,"You got ".. luck .. "Xanax!", "success")
	end
end)

QBCore.Functions.CreateUseableItem('vicodin', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)


if TriggerClientEvent('md-drugs:client:takevicodin', src, item.name) then
	Player.Functions.RemoveItem('vicodin', 1)
	TriggerClientEvent('QBCore:Notify', src,"You Took Vicodin", "success")
	end
end)

QBCore.Functions.CreateUseableItem('adderal', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)


if TriggerClientEvent('md-drugs:client:takeadderal', src, item.name) then
	Player.Functions.RemoveItem('adderal', 1)
	TriggerClientEvent('QBCore:Notify', src,"You Took adderal", "success")
	end
end)

QBCore.Functions.CreateUseableItem('xanax', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)


if TriggerClientEvent('md-drugs:client:takexanax', src, item.name) then
	Player.Functions.RemoveItem('xanax', 1)
	TriggerClientEvent('QBCore:Notify', src,"You Took xanax", "success")
	end
end)

QBCore.Functions.CreateUseableItem('morphine', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)


if TriggerClientEvent('md-drugs:client:takemorphine', src, item.name) then
	Player.Functions.RemoveItem('morphine', 1)
	TriggerClientEvent('QBCore:Notify', src,"You Took morphine", "success")
	end
end)


