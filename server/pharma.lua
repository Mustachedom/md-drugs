local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('prescription_pad', function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.type == 'ems' then 
		TriggerClientEvent("md-drugs:client:prescriptionpad", src, item)
	end	
end)

RegisterServerEvent('md-drugs:server:giveprescription', function(item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem(item, 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", 1)
end)

RegisterServerEvent('md-drugs:server:unbottle', function(item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local amount = math.random(10,30)
	Player.Functions.AddItem(item, amount)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", amount)
end)

local pharmabottle = {'vicodinbottle', 'adderalbottle','morphinebottle','xanaxbottle'}
for m, d in pairs (pharmabottle) do
QBCore.Functions.CreateUseableItem(d, function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(d, 1) then
		TriggerClientEvent("md-drugs:client:unbottle", src, item)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[d], "remove", 1)
	end	
end)
end

local pharmadrugs = { "adderal", "vicodin", "xanax", "morphine"}
for k, v in pairs (pharmadrugs) do QBCore.Functions.CreateUseableItem(v, function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if TriggerClientEvent('md-drugs:client:takepharma', src, item.name) then
	Player.Functions.RemoveItem(item.name, 1)
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item.name], "remove", 1)
	
	end
end)
end
RegisterServerEvent('md-drugs:server:fillprescription', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if RemoveItem('vicodin_prescription', 1 ) then
		AddItem('vicodinbottle', 1) 
		Notifys(Lang.Pharma.pills, "success")
	elseif RemoveItem('adderal_prescription', 1 ) then
		AddItem('adderalbottle', 1) 
		Notifys(Lang.Pharma.pills, "success")
	elseif RemoveItem('morphine_prescription', 1 ) then
		AddItem('morphinebottle', 1) 
		Notifys(Lang.Pharma.pills, "success")
		
	elseif RemoveItem('xanax_prescription', 1 ) then
		AddItem('xanaxbottle', 1) 
		Notifys(Lang.Pharma.pills, "success")
		
	else
		Notifys(Lang.Pharma.no, "error")
	end
end)