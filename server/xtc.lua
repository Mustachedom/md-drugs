local QBCore = exports['qb-core']:GetCoreObject()
-------------------- stealing ingridients 
RegisterServerEvent('md-drugs:server:stealisosafrole', function(num)
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	if CheckDist(source, Config.isosafrole[num]['loc']) then return end
  	if AddItem(src, "isosafrole", 1) then 
		Log(GetName(source) .. ' Stole isosafrole with a distance of  ' .. dist(source, Config.isosafrole[num]['loc']) .. ' vectors!', 'xtc')
  	end	
end)

RegisterServerEvent('md-drugs:server:stealmdp2p', function(num)
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	if CheckDist(source, Config.mdp2p[num]['loc']) then return end
  	if AddItem(src,"mdp2p", 1) then 
		Log(GetName(source) .. ' Stole MDP2P with a distance of  ' .. dist(source, Config.mdp2p[num]['loc']) .. ' vectors!', 'xtc')
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
		RemoveItem(src, v.item, 1)
		Log(GetName(source) .. ' Placed A ' .. v.item .. ' At ' .. GetCoords(source) .. '!', 'xtc')
	end
end)
end

RegisterServerEvent('md-drugs:server:getpressback', function(type)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if type == 'single' then
		if Player.Functions.GetItemByName('singlepress') then  Notifys(src, 'You Already Have A Kit') return end
		AddItem(src, 'singlepress', 1)
		Log(GetName(source) .. ' Picked Their Single Press At ' .. GetCoords(source) .. '!', 'xtc')
	elseif type == 'dual' then
		if Player.Functions.GetItemByName('dualpress') then  Notifys(src, 'You Already Have A Kit') return end
		AddItem(src, 'dualpress', 1)
		Log(GetName(source) .. ' Picked Their Dual Press At ' .. GetCoords(source) .. '!', 'xtc')
	elseif type == 'triple' then
		if Player.Functions.GetItemByName('triplepress') then  Notifys(src, 'You Already Have A Kit') return end
		AddItem(src, 'triplepress', 1)
		Log(GetName(source) .. ' Picked Their Triple Press At ' .. GetCoords(source) .. '!', 'xtc')
	elseif type == 'quad' then
		if Player.Functions.GetItemByName('quadpress') then  Notifys(src, 'You Already Have A Kit') return end
		AddItem(src, 'quadpress', 1)
		Log(GetName(source) .. ' Picked Their Quad Press At ' .. GetCoords(source) .. '!', 'xtc')
	end		
end)


RegisterServerEvent('md-drugs:server:makextc', function(data)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if not Itemcheck(src, 'raw_xtc', 1) then return end
  	if data.data == 'single' then 
		if data.color == 'white' then 
			if not GetRecipe(src, 'xtc', 'singlestack', 'white') then return end
				Log(GetName(source) .. ' Made A Single Stack White Pill!', 'xtc')
		elseif data.color == 'red' then
			if not GetRecipe(src, 'xtc', 'singlestack', 'red') then return end
			Log(GetName(source) .. ' Made A Single Stack Red Pill!', 'xtc')
		elseif data.color == 'orange' then
			if not GetRecipe(src, 'xtc', 'singlestack', 'orange') then return end
			Log(GetName(source) .. ' Made A Single Stack Orange Pill!', 'xtc')
		elseif data.color == 'blue' then
			if not GetRecipe(src, 'xtc', 'singlestack', 'blue') then return end
			Log(GetName(source) .. ' Made A Single Stack Blue Pill!', 'xtc')
		end
	elseif data.data == 'dual' then
		if data.color == 'white' then 
			if not GetRecipe(src, 'xtc', 'dualstack', 'white') then return end
				Log(GetName(source) .. ' Made A Dual Stack White Pill!', 'xtc')
		elseif data.color == 'red' then
			if not GetRecipe(src, 'xtc', 'dualstack', 'red') then return end
			Log(GetName(source) .. ' Made A Dual Stack Red Pill!', 'xtc')
		elseif data.color == 'orange' then
			if not GetRecipe(src, 'xtc', 'dualstack', 'orange') then return end
			Log(GetName(source) .. ' Made A Dual Stack Orange Pill!', 'xtc')
		elseif data.color == 'blue' then
			if not GetRecipe(src, 'xtc', 'dualstack', 'blue') then return end
			Log(GetName(source) .. ' Made A Dual Stack Blue Pill!', 'xtc')
		end
	elseif data.data == 'triple' then
		if data.color == 'white' then 
			if not GetRecipe(src, 'xtc', 'triplestack', 'white') then return end
				Log(GetName(source) .. ' Made A Triple Stack White Pill!', 'xtc')
		elseif data.color == 'red' then
			if not GetRecipe(src, 'xtc', 'triplestack', 'red') then return end
			Log(GetName(source) .. ' Made A Triple Stack Red Pill!', 'xtc')
		elseif data.color == 'orange' then
			if not GetRecipe(src, 'xtc', 'triplestack', 'orange') then return end
			Log(GetName(source) .. ' Made A Triple Stack Orange Pill!', 'xtc')
		elseif data.color == 'blue' then
			if not GetRecipe(src, 'xtc', 'triplestack', 'blue') then return end
			Log(GetName(source) .. ' Made A Triple Stack Blue Pill!', 'xtc')
		end
	elseif data.data == 'quad' then
		if data.color == 'white' then 
			if not GetRecipe(src, 'xtc', 'quadstack', 'white') then return end
				Log(GetName(source) .. ' Made A Quad Stack White Pill!', 'xtc')
		elseif data.color == 'red' then
			if not GetRecipe(src, 'xtc', 'quadstack', 'red') then return end
			Log(GetName(source) .. ' Made A Quad Stack Red Pill!', 'xtc')
		elseif data.color == 'orange' then
			if not GetRecipe(src, 'xtc', 'quadstack', 'orange') then return end
			Log(GetName(source) .. ' Made A Quad Stack Orange Pill!', 'xtc')
		elseif data.color == 'blue' then
			if not GetRecipe(src, 'xtc', 'quadstack', 'blue') then return end
			Log(GetName(source) .. ' Made A Quad Stack Blue Pill!', 'xtc')
		end
	end
end)

RegisterServerEvent('md-drugs:server:buypress', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	
	  if Player.Functions.RemoveMoney("cash", 20000) then
		  AddItem(src, "singlepress", 1)
		  Log(GetName(source) .. ' Bought A Pill Press', 'xtc')
	  else
		  Notifys(Lang.xtc.cash, "error")
	  end
  end)

RegisterServerEvent('md-drugs:server:upgradepress', function(data)
  local src = source

    if CheckDist(source, Config.buypress) then return end
    if data == 'dual' then
		if not GetRecipe(src, 'xtc', 'press', 'dual') then return end
		Log(GetName(source) .. ' Upgraded Press To Dual Press', 'xtc')
    elseif data == 'triple' then
		if not GetRecipe(src, 'xtc', 'press', 'triple') then return end
		Log(GetName(source) .. ' Upgraded Press To Triple Press', 'xtc')
    elseif data == 'quad' then
		if not GetRecipe(src, 'xtc', 'press', 'quad') then return end
		  Log(GetName(source) .. ' Upgraded Press To Quad Press', 'xtc')
	else
		Notifys(src, 'huh', 'error')
	end
end)

------------- making powder
RegisterServerEvent('md-drugs:server:makingrawxtc', function(num)
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  	if CheckDist(source, Config.rawxtcloc[num]['loc']) then return end
  	if not GetRecipe(src, 'xtc', 'raw', 'raw_xtc') then return end
	Log(GetName(source) .. ' Made Raw XTC With A Distance Of ' .. dist(source, Config.rawxtcloc[num]['loc']) .. '!', 'xtc')
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
	if CheckDist(source, Config.stamp[num]['loc']) then return end

	if RemoveItem(src, "white_xtc", 1) then
		AddItem(src, one[chance], 1)
		Log(GetName(source) .. ' Stamped A Single White Pill And Got ' .. one[chance] .. '!', 'xtc')
	elseif RemoveItem(src, "white_xtc2", 1) then
		AddItem(src, two[chance2], 1)
		Log(GetName(source) .. ' Stamped A Dual White Pill And Got ' .. two[chance2] .. '!', 'xtc')
	elseif RemoveItem(src, "white_xtc3", 1) then
		AddItem(src, three[chance3], 1) 
		Log(GetName(source) .. ' Stamped A Triple White Pill And Got ' .. three[chance3] .. '!', 'xtc')
	elseif RemoveItem(src, "white_xtc4", 1) then
		AddItem(src, four[chance4], 1) 
		Log(GetName(source) .. ' Stamped A Quad White Pill And Got ' .. four[chance4] .. '!', 'xtc')
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
	  if CheckDist(source, Config.stamp[num]['loc']) then return end
  
	  if RemoveItem(src, "red_xtc", 1) then
		  AddItem(src, one[chance], 1)
		  Log(GetName(source) .. ' Stamped A Single Red Pill And Got ' .. one[chance] .. '!', 'xtc')
	  elseif RemoveItem(src, "red_xtc2", 1) then
		  AddItem(src, two[chance2], 1)
		  Log(GetName(source) .. ' Stamped A Dual Red Pill And Got ' .. two[chance2] .. '!', 'xtc')
	  elseif RemoveItem(src, "red_xtc3", 1) then
		  AddItem(src, three[chance3], 1) 
		  Log(GetName(source) .. ' Stamped A Triple Red Pill And Got ' .. three[chance3] .. '!', 'xtc')
	  elseif RemoveItem(src, "red_xtc4", 1) then
		  AddItem(src, four[chance4], 1) 
		  Log(GetName(source) .. ' Stamped A Quad Red Pill And Got ' .. four[chance4] .. '!', 'xtc')
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
	  if CheckDist(source, Config.stamp[num]['loc']) then return end
  
	  if RemoveItem(src, "orange_xtc", 1) then
		  AddItem(src, one[chance], 1)
		  Log(GetName(source) .. ' Stamped A Single Orange Pill And Got ' .. one[chance] .. '!', 'xtc')
	  elseif RemoveItem(src, "orange_xtc2", 1) then
		  AddItem(src, two[chance2], 1)
		  Log(GetName(source) .. ' Stamped A Dual Orange Pill And Got ' .. two[chance2] .. '!', 'xtc')
	  elseif RemoveItem(src, "orange_xtc3", 1) then
		  AddItem(src, three[chance3], 1) 
		  Log(GetName(source) .. ' Stamped A Triple Orange Pill And Got ' .. three[chance3] .. '!', 'xtc')
	  elseif RemoveItem(src, "orange_xtc4", 1) then
		  AddItem(src, four[chance4], 1) 
		  Log(GetName(source) .. ' Stamped A Quad Orange Pill And Got ' .. four[chance4] .. '!', 'xtc')
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
	  if CheckDist(source, Config.stamp[num]['loc']) then return  end
	  Log(GetName(source) .. ' Stamped A Single Blue Pill And Got ' .. one[chance] .. '!', 'xtc')
	  if RemoveItem(src, "blue_xtc", 1) then
		  AddItem(src, one[chance], 1)
	  elseif RemoveItem(src, "blue_xtc2", 1) then
		  AddItem(src, two[chance2], 1)
		  Log(GetName(source) .. ' Stamped A Dual Blue Pill And Got ' .. two[chance2] .. '!', 'xtc')
	  elseif RemoveItem(src, "blue_xtc3", 1) then
		  AddItem(src, three[chance3], 1) 
		  Log(GetName(source) .. ' Stamped A Triple Blue Pill And Got ' .. three[chance3] .. '!', 'xtc')
	  elseif RemoveItem(src, "blue_xtc4", 1) then
		  AddItem(src, four[chance4], 1) 
		  Log(GetName(source) .. ' Stamped A Quad Blue Pill And Got ' .. four[chance4] .. '!', 'xtc')
	  else 
		  Notifys('You Dont Have Unstamped blue Pills', 'error')
	  end
end)