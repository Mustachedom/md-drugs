local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('md-drugs:server:givevicodinprescription', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.AddItem('vicodin_prescription', 1 ) then
		TriggerClientEvent('QBCore:Notify', src, "Dont Forget to give it to them!", "success")
	end
end)

RegisterServerEvent('md-drugs:server:giveadderalprescription', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.AddItem('adderal_prescription', 1 ) then
		TriggerClientEvent('QBCore:Notify', src, "Dont Forget to give it to them!", "success")
	end
end)

RegisterServerEvent('md-drugs:server:givemorphineprescription', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.AddItem('morphine_prescription', 1 ) then
		TriggerClientEvent('QBCore:Notify', src, "Dont Forget to give it to them!", "success")
	end
end)

RegisterServerEvent('md-drugs:server:givexanaxprescription', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
	if Player.Functions.AddItem('xanax_prescription', 1 ) then
		TriggerClientEvent('QBCore:Notify', src, "Dont Forget to give it to them!", "success")
	end
end)

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

if Player.Functions.RemoveItem('vicodinbottle', 1) then
	Player.Functions.AddItem('vicodin', luck)
	TriggerClientEvent('QBCore:Notify', src,"You got ".. luck .. "Vicodin!", "success")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['vicodin'], "add", luck)
	end
end)

QBCore.Functions.CreateUseableItem('adderalbottle', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local luck = math.random(10,30)

if Player.Functions.RemoveItem('adderalbottle', 1) then
	Player.Functions.AddItem('adderal', luck)
	TriggerClientEvent('QBCore:Notify', src,"You got ".. luck .. "Adderal!", "success")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['adderal'], "add", luck)
	end
end)

QBCore.Functions.CreateUseableItem('morphinebottle', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local luck = math.random(10,30)

if Player.Functions.RemoveItem('morphinebottle', 1) then
	Player.Functions.AddItem('morphine', luck)
	TriggerClientEvent('QBCore:Notify', src,"You got ".. luck .. "Morphine!", "success")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['morphine'], "add", luck)
	end
end)

QBCore.Functions.CreateUseableItem('xanaxbottle', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local luck = math.random(10,30)

if Player.Functions.RemoveItem('xanaxbottle', 1) then
	Player.Functions.AddItem('xanax', luck)
	TriggerClientEvent('QBCore:Notify', src,"You got ".. luck .. "Xanax!", "success")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['xanax'], "add", luck)
	end
end)


local pharmadrugs = { "adderal", "vicodin", "xanax", "morphine"}
for k, v in pairs (pharmadrugs) do QBCore.Functions.CreateUseableItem(v, function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if TriggerClientEvent('md-drugs:client:takepharma', src, item.name) then
	Player.Functions.RemoveItem(item.name, 1)
	
	end
end)
end
