local QBCore = exports['qb-core']:GetCoreObject()
local lean = { 'mdlean', 'mdreddextro'}
RegisterServerEvent('md-drugs:server:givelean', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,100)
	local amount = math.random(1,5)
	if chance <= 50 then 
		if Player.Functions.AddItem('mdlean', amount) then
			TriggerClientEvent('QBCore:Notify', src, "You Got Some Purple Lean", "success")
		end
	else
		if Player.Functions.AddItem('mdreddextro', amount) then
			TriggerClientEvent('QBCore:Notify', src, "You Got Red Dextro", "success")
		end
	end	
end)

for k, v in pairs (lean) do QBCore.Functions.CreateUseableItem(v, function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if Player.Functions.RemoveItem(item.name, 1) then
	TriggerClientEvent('md-drugs:client:consumelean', src)
end

end)
end

QBCore.Functions.CreateUseableItem('leancup', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
local recipe1 = { 'mdlean', 'sprunk', 'leancup'}
local recipe2 = {'mdreddextro', 'sprunk', 'leancup'}
local lean = Player.Functions.GetItemByName('mdlean')
local dextro = Player.Functions.GetItemByName('mdreddextro')
local sprunk = Player.Functions.GetItemByName('sprunk')
local price = 0
for k, v in pairs (recipe1) do 
	if lean and lean.amount > 0  then 
		if sprunk and sprunk.amount > 0 then
			if Player.Functions.RemoveItem(v, 1) then
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[v], "add", 1)
				price = 1
			end
		end
	end
end
if price == 1 then
Player.Functions.AddItem('cupoflean', 1)
TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cupoflean'], "add", 1)
end
for m, d in pairs (recipe2) do 
	if dextro and dextro.amount > 0  then 
		if sprunk and sprunk.amount > 0 then
			if Player.Functions.RemoveItem(d, 1) then 
				price = 2
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[v], "remove", 1)
			end	
		end
	end
end
if price == 2 then
Player.Functions.AddItem('cupofdextro', 1)
TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cupofdextro'], "add", 1)
end
end)

