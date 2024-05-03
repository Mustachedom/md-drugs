local QBCore = exports['qb-core']:GetCoreObject()
-------------------- stealing ingridients 
RegisterServerEvent('md-drugs:server:stealisosafrole', function(num)
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.isosafrole[num]['loc']) then return end
  	if AddItem("isosafrole", 1) then 
  	end	
end)

RegisterServerEvent('md-drugs:server:stealmdp2p', function(num)
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.mdp2p[num]['loc']) then return end
  	if AddItem("mdp2p", 1) then 
  	end	
end)
local presses = {
	{item = 'singlepress',  data = 'single'},
	{item = 'dualpress', 	data = 'dual'},
	{item = 'triplepress',  data = 'triple'},
	{item = 'quadpress',    data = 'quad'},
}
for k, v in pairs (presses) do 
QBCore.Functions.CreateUseableItem(v.item, function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if TriggerClientEvent("md-drugs:client:setpress", src, v.data) then
		Player.Functions.RemoveItem(v.item, 1)
	end
end)
end

RegisterServerEvent('md-drugs:server:getpressback', function(type)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

	if type == 'single' then
		if Player.Functions.GetItemByName('singlepress') then  Notifys('You Already Have A Kit') return end
		AddItem('singlepress', 1)
	elseif type == 'dual' then
		if Player.Functions.GetItemByName('dualpress') then  Notifys('You Already Have A Kit') return end
		AddItem('dualpress', 1)
	elseif type == 'triple' then
		if Player.Functions.GetItemByName('triplepress') then  Notifys('You Already Have A Kit') return end
		AddItem('triplepress', 1)
	elseif type == 'quad' then
		if Player.Functions.GetItemByName('quadpress') then  Notifys('You Already Have A Kit') return end
		AddItem('quadpress', 1)
	end		
end)


RegisterServerEvent('md-drugs:server:makextc', function(data)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
  	if data.data == 'single' then 
		if data.color == 'white' then 
			if RemoveItem('raw_xtc', 1) then
				AddItem('white_xtc', 1)
			end
		elseif data.color == 'red' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'loosecoke', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('loosecoke', 1)
			AddItem('red_xtc', 1)
		elseif data.color == 'orange' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'heroinvial', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('heroinvial', 1)
			AddItem('orange_xtc', 1)
		elseif data.color == 'blue' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'crackrock', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('crackrock', 1)
			AddItem('blue_xtc', 1)
		end
	elseif data.data == 'dual' then
		if data.color == 'white' then 
			if RemoveItem('raw_xtc', 1) then
				AddItem('white_xtc2', 1)
			end
		elseif data.color == 'red' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'loosecoke', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('loosecoke', 1)
			AddItem('red_xtc2', 1)
		elseif data.color == 'orange' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'heroinvial', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('heroinvial', 1)
			AddItem('orange_xtc2', 1)
		elseif data.color == 'blue' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'crackrock', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('crackrock', 1)
			AddItem('blue_xtc2', 1)
		end
	elseif data.data == 'triple' then
		if data.color == 'white' then 
			if RemoveItem('raw_xtc', 1) then
				AddItem('white_xtc3', 1)
			end
		elseif data.color == 'red' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'loosecoke', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('loosecoke', 1)
			AddItem('red_xtc3', 1)
		elseif data.color == 'orange' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'heroinvial', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('heroinvial', 1)
			AddItem('orange_xtc3', 1)
		elseif data.color == 'blue' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'crackrock', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('crackrock', 1)
			AddItem('blue_xtc3', 1)
		end
	elseif data.data == 'quad' then
		if data.color == 'white' then 
			if RemoveItem('raw_xtc', 1) then
				AddItem('white_xtc4', 1)
			end
		elseif data.color == 'red' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'loosecoke', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('loosecoke', 1)
			AddItem('red_xtc4', 1)
		elseif data.color == 'orange' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'heroinvial', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('heroinvial', 1)
			AddItem('orange_xtc4', 1)
		elseif data.color == 'blue' then
			if not Itemcheck(Player, 'raw_xtc', 1, 'true') then return end
			if not Itemcheck(Player, 'crackrock', 1, 'true') then return end
			RemoveItem('raw_xtc', 1)
			RemoveItem('crackrock', 1)
			AddItem('blue_xtc4', 1)
		end
	end
end)

RegisterServerEvent('md-drugs:server:buypress', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
	  if Player.Functions.RemoveMoney("cash", 20000) then
		  AddItem("singlepress", 1)
	  else
		  Notifys(Lang.xtc.cash, "error")
	  end
  end)

RegisterServerEvent('md-drugs:server:upgradepress', function(data)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local playerPed = GetPlayerPed(source)

    if CheckDist(source, playerPed, Config.buypress) then return end
    if data == 'dual' then
		local have = 0
		local pill = {'white_xtc', 'blue_xtc', 'red_xtc', 'orange_xtc'}
		for k, v in pairs (pill) do
			if Itemcheck(Player, v, 20, 'true') then have = have + 1 end
		end
	 	if have == 4 then 
			if not Itemcheck(Player, 'singlepress', 1, 'true') then return end
			RemoveItem('white_xtc', 20)
			RemoveItem('blue_xtc', 20)
			RemoveItem('red_xtc', 20)
			RemoveItem('orange_xtc', 20)
			RemoveItem('singlepress', 1)
			AddItem('dualpress', 1)
		end
    elseif data == 'triple' then
		local have = 0
		local pill = {'white_xtc2', 'blue_xtc2', 'red_xtc2', 'orange_xtc2'}
		for k, v in pairs (pill) do
			if Itemcheck(Player, v, 50, 'true') then have = have + 1 end
		end
	 	if have == 4 then 
		  RemoveItem('dualpress', 1)
		  RemoveItem('white_xtc2', 50)
		  RemoveItem('blue_xtc2', 50)
		  RemoveItem('red_xtc2', 50)
		  RemoveItem('orange_xtc2', 50)
		  AddItem('triplepress', 1)
	  end
    elseif data == 'quad' then
		local have = 0
		local pill = {'white_xtc3', 'blue_xtc3', 'red_xtc3', 'orange_xtc3'}
		for k, v in pairs (pill) do
			if Itemcheck(Player, v, 150, 'true') then have = have + 1 end
		end
	 	if have == 4 then 
		  RemoveItem('triplepress', 1)
		  RemoveItem('white_xtc3', 150)
		  RemoveItem('blue_xtc3', 150)
		  RemoveItem('red_xtc3', 150)
		  RemoveItem('orange_xtc3', 150)
		  AddItem('quadpress', 1)
	  end
	else
		Notify('huh', 'error')
	end
end)

------------- making powder
RegisterServerEvent('md-drugs:server:makingrawxtc', function(num)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local playerPed = GetPlayerPed(source)
  if CheckDist(source, playerPed, Config.rawxtcloc[num]['loc']) then return end
  if not Itemcheck(Player, 'mdp2p', 1, 'true') and not Itemcheck(Player, 'isosafrole', 1, 'true') then return end
	RemoveItem('mdp2p', 1)
	RemoveItem('isosafrole', 1)
    AddItem("raw_xtc", 1)	
end)
  
RegisterServerEvent('md-drugs:server:stampwhite', function(num)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local one = {'white_playboys', 'white_aliens', 'white_pl', 'white_trolls', 'white_cats'}
  local chance = math.random(#one)
  local two = {'white_playboys2', 'white_aliens2', 'white_pl2', 'white_trolls2', 'white_cats2'}
  local chance2 = math.random(#one)
  local three = {'white_playboys3', 'white_aliens3', 'white_pl3', 'white_trolls3', 'white_cats3'}
  local chance3 = math.random(#one)
  local four = {'white_playboys4', 'white_aliens4', 'white_pl4', 'white_trolls4', 'white_cats4'}
  local chance4 = math.random(#one)
  local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.stamp[num]['loc']) then return end

	if Player.Functions.RemoveItem("white_xtc", 1) then
		AddItem(one[chance], 1)
	elseif Player.Functions.RemoveItem("white_xtc2", 1) then
		AddItem(two[chance2], 1)
		
	elseif Player.Functions.RemoveItem("white_xtc3", 1) then
		AddItem(three[chance3], 1) 
		
	elseif Player.Functions.RemoveItem("white_xtc4", 1) then
		AddItem(four[chance4], 1) 
	else 
		Notifys('You Dont Have Unstamped White Pills', 'error')
	end
end)

RegisterServerEvent('md-drugs:server:stampred', function(num)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local one = {'red_playboys', 'red_aliens', 'red_pl', 'red_trolls', 'red_cats'}
	local chance = math.random(#one)
	local two = {'red_playboys2', 'red_aliens2', 'red_pl2', 'red_trolls2', 'red_cats2'}
	local chance2 = math.random(#one)
	local three = {'red_playboys3', 'red_aliens3', 'red_pl3', 'red_trolls3', 'red_cats3'}
	local chance3 = math.random(#one)
	local four = {'red_playboys4', 'red_aliens4', 'red_pl4', 'red_trolls4', 'red_cats4'}
	local chance4 = math.random(#one)
	local playerPed = GetPlayerPed(source)
	  if CheckDist(source, playerPed, Config.stamp[num]['loc']) then return end
  
	  if Player.Functions.RemoveItem("red_xtc", 1) then
		  AddItem(one[chance], 1)
	  elseif Player.Functions.RemoveItem("red_xtc2", 1) then
		  AddItem(two[chance2], 1)
		  
	  elseif Player.Functions.RemoveItem("red_xtc3", 1) then
		  AddItem(three[chance3], 1) 
		  
	  elseif Player.Functions.RemoveItem("red_xtc4", 1) then
		  AddItem(four[chance4], 1) 
	  else 
		  Notifys('You Dont Have Unstamped red Pills', 'error')
	  end
end)

RegisterServerEvent('md-drugs:server:stamporange', function(num)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local one = {'orange_playboys', 'orange_aliens', 'orange_pl', 'orange_trolls', 'orange_cats'}
	local chance = math.random(#one)
	local two = {'orange_playboys2', 'orange_aliens2', 'orange_pl2', 'orange_trolls2', 'orange_cats2'}
	local chance2 = math.random(#one)
	local three = {'orange_playboys3', 'orange_aliens3', 'orange_pl3', 'orange_trolls3', 'orange_cats3'}
	local chance3 = math.random(#one)
	local four = {'orange_playboys4', 'orange_aliens4', 'orange_pl4', 'orange_trolls4', 'orange_cats4'}
	local chance4 = math.random(#one)
	local playerPed = GetPlayerPed(source)
	  if CheckDist(source, playerPed, Config.stamp[num]['loc']) then return end
  
	  if Player.Functions.RemoveItem("orange_xtc", 1) then
		  AddItem(one[chance], 1)
	  elseif Player.Functions.RemoveItem("orange_xtc2", 1) then
		  AddItem(two[chance2], 1)
		  
	  elseif Player.Functions.RemoveItem("orange_xtc3", 1) then
		  AddItem(three[chance3], 1) 
		  
	  elseif Player.Functions.RemoveItem("orange_xtc4", 1) then
		  AddItem(four[chance4], 1) 
	  else 
		  Notifys('You Dont Have Unstamped orange Pills', 'error')
	  end
end)

RegisterServerEvent('md-drugs:server:stampblue', function(num)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local one = {'blue_playboys', 'blue_aliens', 'blue_pl', 'blue_trolls', 'blue_cats'}
	local chance = math.random(#one)
	local two = {'blue_playboys2', 'blue_aliens2', 'blue_pl2', 'blue_trolls2', 'blue_cats2'}
	local chance2 = math.random(#one)
	local three = {'blue_playboys3', 'blue_aliens3', 'blue_pl3', 'blue_trolls3', 'blue_cats3'}
	local chance3 = math.random(#one)
	local four = {'blue_playboys4', 'blue_aliens4', 'blue_pl4', 'blue_trolls4', 'blue_cats4'}
	local chance4 = math.random(#one)
	local playerPed = GetPlayerPed(source)
	  if CheckDist(source, playerPed, Config.stamp[num]['loc']) then return  end
  
	  if Player.Functions.RemoveItem("blue_xtc", 1) then
		  AddItem(one[chance], 1)
	  elseif Player.Functions.RemoveItem("blue_xtc2", 1) then
		  AddItem(two[chance2], 1)
		  
	  elseif Player.Functions.RemoveItem("blue_xtc3", 1) then
		  AddItem(three[chance3], 1) 
		  
	  elseif Player.Functions.RemoveItem("blue_xtc4", 1) then
		  AddItem(four[chance4], 1) 
	  else 
		  Notifys('You Dont Have Unstamped blue Pills', 'error')
	  end
end)