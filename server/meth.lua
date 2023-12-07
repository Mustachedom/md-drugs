local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:startcook', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local recipe = {"ephedrine", "acetone"}
  local ephedrine = Player.Functions.GetItemByName("ephedrine")
  local acetone = Player.Functions.GetItemByName("acetone")
  for k, v in pairs (recipe) do 
		if ephedrine and ephedrine.amount > 0 then
			if acetone and acetone.amount > 0 then
				if Player.Functions.RemoveItem(v, 1) then
					TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v], "remove", 1)
				end	
			end	
		end
	end	
	TriggerClientEvent('QBCore:Notify', src, "Adding Things To The Mix", "success")
end)

RegisterServerEvent('md-drugs:server:givemethingridients', function()
  local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,100)
	local amount = math.random(1,5)
	if chance <= 50 then 
		if Player.Functions.AddItem('ephedrine', amount) then
			TriggerClientEvent('QBCore:Notify', src, "You Got Some Ephedrine", "success")
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['ephedrine'], "add", amount)
		end
	else
		if Player.Functions.AddItem('acetone', amount) then
			TriggerClientEvent('QBCore:Notify', src, "You Got Some Acetone", "success")
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['acetone'], "add", amount)
		end
	end	
end)

RegisterServerEvent('md-drugs:server:getmeth', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local amount = math.random(1,5)
 
  if Player.Functions.RemoveItem("empty_weed_bag", amount) then
		Player.Functions.AddItem("methbags", amount)
		TriggerClientEvent('QBCore:Notify', src, "You Made " .. amount .. " Bags Of Meth!", "success")
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['methbags'], "add", amount)
		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['empty_weed_bag'], "remove", amount)
	else
	TriggerClientEvent('QBCore:Notify', src, "Cant Bag This Without Bags", "error")
	end
end)