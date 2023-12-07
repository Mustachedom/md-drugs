local QBCore = exports['qb-core']:GetCoreObject()
-------------------- stealing ingridients 
RegisterServerEvent('md-drugs:server:stealisosafrole', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  
  if Player.Functions.AddItem("isosafrole", 1) then 
	TriggerClientEvent('QBCore:Notify', src, "you stole isosafrole", "success")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['isosafrole'], "add",  1)
  end	
end)

RegisterServerEvent('md-drugs:server:stealmdp2p', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  
  if Player.Functions.AddItem("mdp2p", 1) then 
	TriggerClientEvent('QBCore:Notify', src, "you stole mdp2p", "success")
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['mdp2p'], "add",  1)
  end	
end)

QBCore.Functions.CreateUseableItem('singlepress', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if TriggerClientEvent("md-drugs:client:setpresssingle", src) then
		Player.Functions.RemoveItem("singlepress", 1)
	end
end)

RegisterServerEvent('md-drugs:server:getsinglepressback', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("singlepress", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['singlepress'], "add",  1)
	end
end)

QBCore.Functions.CreateUseableItem('dualpress', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if TriggerClientEvent("md-drugs:client:setpressdual", src) then
		Player.Functions.RemoveItem("dualpress", 1)
	end
end)

RegisterServerEvent('md-drugs:server:getdualpressback', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("dualpress", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['dualpress'], "add",  1)
	end
end)

QBCore.Functions.CreateUseableItem('triplepress', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if TriggerClientEvent("md-drugs:client:setpresstriple", src) then
		Player.Functions.RemoveItem("triplepress", 1)
	end
end)

RegisterServerEvent('md-drugs:server:gettriplepressback', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("triplepress", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['triplepress'], "add",  1)
	end
end)

QBCore.Functions.CreateUseableItem('quadpress', function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if TriggerClientEvent("md-drugs:client:setpressquad", src) then
		Player.Functions.RemoveItem("quadpress", 1)
	end
end)

RegisterServerEvent('md-drugs:server:getquadpressback', function()
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if Player.Functions.AddItem("quadpress", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['quadpress'], "add",  1)
	end
end)

RegisterServerEvent('md-drugs:server:buypress', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveMoney("cash", 20000) then
		Player.Functions.AddItem("singlepress", 1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['singlepress'], "add",  1)
	else
	TriggerClientEvent('QBCore:Notify', src, "give me 20k for a single press", "error")
	end
end)



RegisterServerEvent('md-drugs:server:upgradepress', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local dualpress = {"white_xtc", "blue_xtc", "red_xtc", "orange_xtc"}
  local triplepress = {"white_xtc2", "blue_xtc2", "red_xtc2", "orange_xtc2"}
  local quadpress = {"white_xtc3", "blue_xtc3", "red_xtc3", "orange_xtc3"}
  
	if Player.Functions.GetItemByName("singlepress", 1) then
		for k, v in pairs (dualpress) do Player.Functions.GetItemByName(v, 20) 
			if Player.Functions.RemoveItem(v, 20) then 
				if Player.Functions.RemoveItem("singlepress", 1) then
					Player.Functions.AddItem("dualpress", 1)
					TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["dualpress"], "add",  1)
					
				end
			end
		end
   elseif Player.Functions.GetItemByName("dualpress", 1) then
		for k, v in pairs (triplepress) do Player.Functions.GetItemByName(v, 50) 
			if Player.Functions.RemoveItem(v, 50) then 
				if Player.Functions.RemoveItem("dualpress", 1) then
					Player.Functions.AddItem("triplepress", 1)
					TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['triplepress'], "add",  1)
				end
			end
		end
	elseif Player.Functions.GetItemByName("triplepress", 1) then
		for k, v in pairs (quadpress) do Player.Functions.GetItemByName(v, 150) 
			if Player.Functions.RemoveItem(v, 150) then 
				if Player.Functions.RemoveItem("triplepress", 1) then
					Player.Functions.AddItem("quadpress", 1)
					TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items["quadpress"], "add",  1)
				end
			end
		end	
	else
	TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
	end
end)

------------- making powder
RegisterServerEvent('md-drugs:server:makingrawxtc', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  
  if Player.Functions.RemoveItem("mdp2p", 1) then 
      if Player.Functions.RemoveItem("isosafrole", 1) then
          Player.Functions.AddItem("raw_xtc", 1)
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "add",  1)
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['isosafrole'], "remove",  1)
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['mdp2p'], "remove",  1)
	  else
	  TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
	  Player.Functions.AddItem("mdp2p", 1)
	  end
  else 
  TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
  end	
end)
  ----------------------------------- White unstamped
RegisterServerEvent('md-drugs:server:makextcsingle', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		Player.Functions.AddItem("white_xtc", 1)
  else
		TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makextcdual', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc2'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		Player.Functions.AddItem("white_xtc2", 1)
  else
		TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makextctriple', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc3'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		Player.Functions.AddItem("white_xtc3", 1)
  else
		TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makextcquad', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc4'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		Player.Functions.AddItem("white_xtc4", 1)
  else
		TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

------------------------------------ red unstamped
RegisterServerEvent('md-drugs:server:makeredxtcsingle', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	 if Player.Functions.RemoveItem("loosecoke", 1) then
	 	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "add",  1)
	 	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
	 	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecoke'], "remove",  1)
	 	Player.Functions.AddItem("red_xtc", 1)
	 else 
	 	TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
	 	Player.Functions.AddItem("raw_xtc", 1)
	 end
   else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
   end
end)

RegisterServerEvent('md-drugs:server:makeredxtcdual', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("loosecoke", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc2'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecoke'], "remove",  1)
		Player.Functions.AddItem("red_xtc2", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makeredxtctriple', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("loosecoke", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc3'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecoke'], "remove",  1)
		Player.Functions.AddItem("red_xtc3", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makeredxtcquad', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("loosecoke", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc4'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['loosecoke'], "remove",  1)
		Player.Functions.AddItem("red_xtc4", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)
------------------------------- Orange unstamped

RegisterServerEvent('md-drugs:server:makeorangextcsingle', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("heroinvial", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvial'], "remove",  1)
		Player.Functions.AddItem("orange_xtc", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makeorangextcdual', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("heroinvial", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc2'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvial'], "remove",  1)
		Player.Functions.AddItem("orange_xtc2", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makeorangextctriple', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("heroinvial", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc3'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvial'], "remove",  1)
		Player.Functions.AddItem("orange_xtc3", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makeorangextcquad', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("heroinvial", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc4'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['heroinvial'], "remove",  1)
		Player.Functions.AddItem("orange_xtc4", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)
--------------------------------- blue unstamped
RegisterServerEvent('md-drugs:server:makebluextcsingle', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("crackrock", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrock'], "remove",  1)
		Player.Functions.AddItem("blue_xtc", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makebluextcdual', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("crackrock", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc2'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrock'], "remove",  1)
		Player.Functions.AddItem("blue_xtc2", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makebluextctriple', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("crackrock", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc3'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrock'], "remove",  1)
		Player.Functions.AddItem("blue_xtc3", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)

RegisterServerEvent('md-drugs:server:makebluextcquad', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then
	if Player.Functions.RemoveItem("crackrock", 1) then
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc4'], "add",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['raw_xtc'], "remove",  1)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['crackrock'], "remove",  1)
		Player.Functions.AddItem("blue_xtc4", 1)
	else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		Player.Functions.AddItem("raw_xtc", 1)
	end
  else
	TriggerClientEvent('QBCore:Notify', src, "How you gonna make xtc pills without xtc", "error")  
  end	
end)
---------------------------

RegisterServerEvent('md-drugs:server:stampwhite', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local luck = math.random(1,100)
  
	if luck <= 5 then 
		if Player.Functions.RemoveItem("white_xtc", 1) then
			Player.Functions.AddItem("white_playboys", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_playboys'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc2", 1) then
			Player.Functions.AddItem("white_playboys2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_playboys2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc3", 1) then
			Player.Functions.AddItem("white_playboys3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_playboys3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc4", 1) then
			Player.Functions.AddItem("white_playboys4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_playboys4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 6 and luck <= 22 then
		if Player.Functions.RemoveItem("white_xtc", 1) then
			Player.Functions.AddItem("white_aliens", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_aliens'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc2", 1) then
			Player.Functions.AddItem("white_aliens2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_aliens2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc3", 1) then
			Player.Functions.AddItem("white_aliens3", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_aliens3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)			
		elseif Player.Functions.RemoveItem("white_xtc4", 1) then
			Player.Functions.AddItem("white_aliens4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_aliens4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 23 and luck <= 43 then 
		if Player.Functions.RemoveItem("white_xtc", 1) then
			Player.Functions.AddItem("white_pl", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_pl'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc2", 1) then
			Player.Functions.AddItem("white_pl2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_pl2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc3", 1) then
			Player.Functions.AddItem("white_pl3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_pl3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc4", 1) then
			Player.Functions.AddItem("white_pl4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_pl4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 44 and luck <= 70 then 
		if Player.Functions.RemoveItem("white_xtc", 1) then
			Player.Functions.AddItem("white_trolls", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_trolls'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc2", 1) then
			Player.Functions.AddItem("white_trolls2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_trolls2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc3", 1) then
			Player.Functions.AddItem("white_trolls3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_trolls3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc4", 1) then
			Player.Functions.AddItem("white_trolls4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_trolls4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 71 and luck <= 100 then
		if Player.Functions.RemoveItem("white_xtc", 1) then
			Player.Functions.AddItem("white_cats", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_cats'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc2", 1) then
			Player.Functions.AddItem("white_cats2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_cats2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc3", 1) then
			Player.Functions.AddItem("white_cats3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_cats3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("white_xtc4", 1) then
			Player.Functions.AddItem("white_cats4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_cats4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['white_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	else 
	TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
	end
end)

RegisterServerEvent('md-drugs:server:stampred', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local luck = math.random(1,100)
  
	if luck <= 5 then 
		if Player.Functions.RemoveItem("red_xtc", 1) then
			Player.Functions.AddItem("red_playboys", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_playboys'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc2", 1) then
			Player.Functions.AddItem("red_playboys2", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_playboys2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)			
		elseif Player.Functions.RemoveItem("red_xtc3", 1) then
			Player.Functions.AddItem("red_playboys3", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_playboys3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc4", 1) then
			Player.Functions.AddItem("red_playboys4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_playboys4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 6 and luck <= 22 then
		if Player.Functions.RemoveItem("red_xtc", 1) then
			Player.Functions.AddItem("red_aliens", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_aliens'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc2", 1) then
			Player.Functions.AddItem("red_aliens2", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_aliens2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc3", 1) then
			Player.Functions.AddItem("red_aliens3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_aliens3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc4", 1) then
			Player.Functions.AddItem("red_aliens4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_aliens4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 23 and luck <= 43 then 
		if Player.Functions.RemoveItem("red_xtc", 1) then
			Player.Functions.AddItem("red_pl", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_pl'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc2", 1) then
			Player.Functions.AddItem("red_pl2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_pl2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc3", 1) then
			Player.Functions.AddItem("red_pl3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_pl3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc4", 1) then
			Player.Functions.AddItem("red_pl4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_pl4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 44 and luck <= 70 then 
		if Player.Functions.RemoveItem("red_xtc", 1) then
			Player.Functions.AddItem("red_trolls", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_trolls'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc2", 1) then
			Player.Functions.AddItem("red_trolls2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_trolls2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc3", 1) then
			Player.Functions.AddItem("red_trolls3", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_trolls3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)			
		elseif Player.Functions.RemoveItem("red_xtc4", 1) then
			Player.Functions.AddItem("red_trolls4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_trolls4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 71 and luck <= 100 then
		if Player.Functions.RemoveItem("red_xtc", 1) then
			Player.Functions.AddItem("red_cats", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_cats'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc2", 1) then
			Player.Functions.AddItem("red_cats2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_cats2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("red_xtc3", 1) then
			Player.Functions.AddItem("red_cats3", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_cats3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)			
		elseif Player.Functions.RemoveItem("red_xtc4", 1) then
			Player.Functions.AddItem("red_cats4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_cats4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['red_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	else 
	TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
	end
end)

RegisterServerEvent('md-drugs:server:stamporange', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local luck = math.random(1,100)
  
	if luck <= 5 then 
		if Player.Functions.RemoveItem("orange_xtc", 1) then
			Player.Functions.AddItem("orange_playboys", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_playboys'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc2", 1) then
			Player.Functions.AddItem("orange_playboys2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_playboys2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc3", 1) then
			Player.Functions.AddItem("orange_playboys3", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_playboys3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)			
		elseif Player.Functions.RemoveItem("orange_xtc4", 1) then
			Player.Functions.AddItem("orange_playboys4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_playboys4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 6 and luck <= 22 then
		if Player.Functions.RemoveItem("orange_xtc", 1) then
			Player.Functions.AddItem("orange_aliens", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_aliens'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc2", 1) then
			Player.Functions.AddItem("orange_aliens2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_aliens2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc3", 1) then
			Player.Functions.AddItem("orange_aliens3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_aliens3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc4", 1) then
			Player.Functions.AddItem("orange_aliens4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_aliens4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 23 and luck <= 43 then 
		if Player.Functions.RemoveItem("orange_xtc", 1) then
			Player.Functions.AddItem("orange_pl", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_pl'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc2", 1) then
			Player.Functions.AddItem("orange_pl2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_pl2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc3", 1) then
			Player.Functions.AddItem("orange_pl3", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_pl3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc4", 1) then
			Player.Functions.AddItem("orange_pl4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_pl4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 44 and luck <= 70 then 
		if Player.Functions.RemoveItem("orange_xtc", 1) then
			Player.Functions.AddItem("orange_trolls", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_trolls'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc2", 1) then
			Player.Functions.AddItem("orange_trolls2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_trolls2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc3", 1) then
			Player.Functions.AddItem("orange_trolls3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_trolls3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc4", 1) then
			Player.Functions.AddItem("orange_trolls4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_trolls4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 71 and luck <= 100 then
		if Player.Functions.RemoveItem("orange_xtc", 1) then
			Player.Functions.AddItem("orange_cats", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_cats'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc2", 1) then
			Player.Functions.AddItem("orange_cats2", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_cats2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)			
		elseif Player.Functions.RemoveItem("orange_xtc3", 1) then
			Player.Functions.AddItem("orange_cats3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_cats3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("orange_xtc4", 1) then
			Player.Functions.AddItem("orange_cats4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_cats4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	else 
	TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
	end
end)

RegisterServerEvent('md-drugs:server:stampblue', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local luck = math.random(1,100)
  
	if luck <= 5 then 
		if Player.Functions.RemoveItem("blue_xtc", 1) then
			Player.Functions.AddItem("blue_playboys", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_playboys'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc2", 1) then
			Player.Functions.AddItem("blue_playboys2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_playboys2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc3", 1) then
			Player.Functions.AddItem("blue_playboys3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_playboys3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc4", 1) then
			Player.Functions.AddItem("blue_playboys4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_playboys4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 6 and luck <= 22 then
		if Player.Functions.RemoveItem("blue_xtc", 1) then
			Player.Functions.AddItem("blue_aliens", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_aliens'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc2", 1) then
			Player.Functions.AddItem("blue_aliens2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_aliens2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc3", 1) then
			Player.Functions.AddItem("blue_aliens3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_aliens3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc4", 1) then
			Player.Functions.AddItem("blue_aliens4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_aliens4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 23 and luck <= 43 then 
		if Player.Functions.RemoveItem("blue_xtc", 1) then
			Player.Functions.AddItem("blue_pl", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_pl'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc2", 1) then
			Player.Functions.AddItem("blue_pl2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_pl2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc3", 1) then
			Player.Functions.AddItem("blue_pl3", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_pl3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)			
		elseif Player.Functions.RemoveItem("blue_xtc4", 1) then
			Player.Functions.AddItem("blue_pl4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_pl4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 44 and luck <= 70 then 
		if Player.Functions.RemoveItem("blue_xtc", 1) then
			Player.Functions.AddItem("blue_trolls", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_trolls'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc2", 1) then
			Player.Functions.AddItem("blue_trolls2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_trolls2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc3", 1) then
			Player.Functions.AddItem("blue_trolls3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_trolls3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc4", 1) then
			Player.Functions.AddItem("blue_trolls4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_trolls4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	elseif luck >= 71 and luck <= 100 then
		if Player.Functions.RemoveItem("blue_xtc", 1) then
			Player.Functions.AddItem("blue_cats", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_cats'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc2", 1) then
			Player.Functions.AddItem("blue_cats2", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_cats2'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc3", 1) then
			Player.Functions.AddItem("blue_cats3", 1) 
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_cats3'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		elseif Player.Functions.RemoveItem("blue_xtc4", 1) then
			Player.Functions.AddItem("blue_cats4", 1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_cats4'], "add",  1)
			TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['blue_xtc'], "remove",  1)
		else 
		TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
		end
	else 
	TriggerClientEvent('QBCore:Notify', src, "You Dont Have the stuff", "error")
	end
end)



