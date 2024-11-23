local QBCore = exports['qb-core']:GetCoreObject()
-------------------- stealing ingridients 
local activePresses = {}
RegisterServerEvent('md-drugs:server:stealisosafrole', function(num)
  	local src = source
  	local Player = getPlayer(src)
	if not checkLoc(src, 'isosafrole',num) then return end
  	if AddItem(src, "isosafrole", 1) then 
  	end
end)

RegisterServerEvent('md-drugs:server:stealmdp2p', function(num)
  	local src = source
  	local Player = getPlayer(src)
	if not checkLoc(src, 'mdp2p',num) then return end
  	if AddItem(src,"mdp2p", 1) then 
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
local Player = getPlayer(src)
local check, loc = lib.callback.await('md-drugs:client:setpress', src, v.data)
	if check then
		if RemoveItem(src, v.item, 1) then
			table.insert(activePresses, {
				press = v.data,
				get = v.item,
				owner = GetName(src),
				ownerid = Player.PlayerData.citizenid,
				src = src,
				loc = loc
			})
		end
	end
end)
end

RegisterServerEvent('md-drugs:server:getpressback', function(type)
local src = source
local Player = getPlayer(src)
	for k, v in pairs (activePresses) do 
		if v.ownerid == Player.PlayerData.citizenid then
			if v.press == type then
				table.remove(activePresses, k)
				AddItem(src, v.get, 1)
			end
		end
	end
end)

local function pressout(source)
	local src = source
	local Player = getPlayer(src)
	local ped = GetPlayerPed(src)
	local coords = GetEntityCoords(ped)
	for k, v in pairs (activePresses) do
		if v.ownerid == Player.PlayerData.citizenid then
			if  #(coords - v.loc) < 3.0 then
				return v.press
			end
		end
	end
	return 'none'
end

RegisterServerEvent('md-drugs:server:makextc', function(data)
  local src = source
  local Player = getPlayer(src)
  if not Itemcheck(src, 'raw_xtc', 1) then return end
  if pressout(src) == 'none' then return end
  	if pressout(src) == 'single' then 
		if data.color == 'white' then 
			if not GetRecipe(src, 'xtc', 'singlestack', 'white') then return end
		elseif data.color == 'red' then
			if not GetRecipe(src, 'xtc', 'singlestack', 'red') then return end
		elseif data.color == 'orange' then
			if not GetRecipe(src, 'xtc', 'singlestack', 'orange') then return end
		elseif data.color == 'blue' then
			if not GetRecipe(src, 'xtc', 'singlestack', 'blue') then return end
		end
	elseif pressout(src) == 'dual' then
		if data.color == 'white' then 
			if not GetRecipe(src, 'xtc', 'dualstack', 'white') then return end
		elseif data.color == 'red' then
			if not GetRecipe(src, 'xtc', 'dualstack', 'red') then return end
		elseif data.color == 'orange' then
			if not GetRecipe(src, 'xtc', 'dualstack', 'orange') then return end
		elseif data.color == 'blue' then
			if not GetRecipe(src, 'xtc', 'dualstack', 'blue') then return end
		end
	elseif pressout(src) == 'triple' then
		if data.color == 'white' then 
			if not GetRecipe(src, 'xtc', 'triplestack', 'white') then return end
		elseif data.color == 'red' then
			if not GetRecipe(src, 'xtc', 'triplestack', 'red') then return end
		elseif data.color == 'orange' then
			if not GetRecipe(src, 'xtc', 'triplestack', 'orange') then return end
		elseif data.color == 'blue' then
			if not GetRecipe(src, 'xtc', 'triplestack', 'blue') then return end
		end
	elseif pressout(src) == 'quad' then
		if data.color == 'white' then 
			if not GetRecipe(src, 'xtc', 'quadstack', 'white') then return end
		elseif data.color == 'red' then
			if not GetRecipe(src, 'xtc', 'quadstack', 'red') then return end
		elseif data.color == 'orange' then
			if not GetRecipe(src, 'xtc', 'quadstack', 'orange') then return end
		elseif data.color == 'blue' then
			if not GetRecipe(src, 'xtc', 'quadstack', 'blue') then return end
		end
	end
end)

RegisterServerEvent('md-drugs:server:buypress', function()
	local src = source
	local Player = getPlayer(src)
	
	  if Player.Functions.RemoveMoney("cash", 20000) then
		  AddItem(src, "singlepress", 1)
		  Log(GetName(source) .. ' Bought A Pill Press', 'xtc')
	  else
		  Notifys(Lang.xtc.cash, "error")
	  end
  end)

RegisterServerEvent('md-drugs:server:upgradepress', function(data)
  local src = source
    if data == 'dual' then
		if not GetRecipe(src, 'xtc', 'press', 'dual') then return end
    elseif data == 'triple' then
		if not GetRecipe(src, 'xtc', 'press', 'triple') then return end
    elseif data == 'quad' then
		if not GetRecipe(src, 'xtc', 'press', 'quad') then return end
	else
		Notifys(src, 'huh', 'error')
	end
end)

------------- making powder
RegisterServerEvent('md-drugs:server:makingrawxtc', function(num)
    local src = source
    local Player = getPlayer(src)
    if not checkLoc(src, 'rawxtcloc',num) then return end
  	if not GetRecipe(src, 'xtc', 'raw', 'raw_xtc') then return end
end)
  
RegisterServerEvent('md-drugs:server:stampwhite', function(num)
    local src = source
    local one = {'white_playboys', 'white_aliens', 'white_pl', 'white_trolls', 'white_cats'}
    local chance = math.random(#one)
    local two = {'white_playboys2', 'white_aliens2', 'white_pl2', 'white_trolls2', 'white_cats2'}
    local three = {'white_playboys3', 'white_aliens3', 'white_pl3', 'white_trolls3', 'white_cats3'}
    local four = {'white_playboys4', 'white_aliens4', 'white_pl4', 'white_trolls4', 'white_cats4'}
	if not checkLoc(src, 'stamp', num) then return end

	if RemoveItem(src, "white_xtc", 1) then
		AddItem(src, one[chance], 1)
	elseif RemoveItem(src, "white_xtc2", 1) then
		AddItem(src, two[chance], 1)
	elseif RemoveItem(src, "white_xtc3", 1) then
		AddItem(src, three[chance], 1) 
	elseif RemoveItem(src, "white_xtc4", 1) then
		AddItem(src, four[chance], 1) 
	else 
		Notifys('You Dont Have Unstamped White Pills', 'error')
	end
end)

RegisterServerEvent('md-drugs:server:stampred', function(num)
	local src = source
	local one = {'red_playboys', 'red_aliens', 'red_pl', 'red_trolls', 'red_cats'}
	local chance = math.random(#one)
	local two = {'red_playboys2', 'red_aliens2', 'red_pl2', 'red_trolls2', 'red_cats2'}
	local three = {'red_playboys3', 'red_aliens3', 'red_pl3', 'red_trolls3', 'red_cats3'}
	local four = {'red_playboys4', 'red_aliens4', 'red_pl4', 'red_trolls4', 'red_cats4'}
	if not checkLoc(src, 'stamp', num) then return end
  
	  if RemoveItem(src, "red_xtc", 1) then
		  AddItem(src, one[chance], 1)
	  elseif RemoveItem(src, "red_xtc2", 1) then
		  AddItem(src, two[chance], 1)
	  elseif RemoveItem(src, "red_xtc3", 1) then
		  AddItem(src, three[chance], 1) 
	  elseif RemoveItem(src, "red_xtc4", 1) then
		  AddItem(src, four[chance], 1) 
	  else 
		  Notifys('You Dont Have Unstamped red Pills', 'error')
	  end
end)

RegisterServerEvent('md-drugs:server:stamporange', function(num)
	local src = source
	local one = {'orange_playboys', 'orange_aliens', 'orange_pl', 'orange_trolls', 'orange_cats'}
	local two = {'orange_playboys2', 'orange_aliens2', 'orange_pl2', 'orange_trolls2', 'orange_cats2'}
	local three = {'orange_playboys3', 'orange_aliens3', 'orange_pl3', 'orange_trolls3', 'orange_cats3'}
	local four = {'orange_playboys4', 'orange_aliens4', 'orange_pl4', 'orange_trolls4', 'orange_cats4'}
	local chance = math.random(#one)
	if not checkLoc(src, 'stamp', num) then return end
  
	  if RemoveItem(src, "orange_xtc", 1) then
		  AddItem(src, one[chance], 1)
	  elseif RemoveItem(src, "orange_xtc2", 1) then
		  AddItem(src, two[chance], 1)
	  elseif RemoveItem(src, "orange_xtc3", 1) then
		  AddItem(src, three[chance], 1) 
	  elseif RemoveItem(src, "orange_xtc4", 1) then
		  AddItem(src, four[chance], 1) 
	  else 
		  Notifys('You Dont Have Unstamped orange Pills', 'error')
	  end
end)

RegisterServerEvent('md-drugs:server:stampblue', function(num)
	local src = source
	local one = {'blue_playboys', 'blue_aliens', 'blue_pl', 'blue_trolls', 'blue_cats'}
	local chance = math.random(#one)
	local two = {'blue_playboys2', 'blue_aliens2', 'blue_pl2', 'blue_trolls2', 'blue_cats2'}
	local three = {'blue_playboys3', 'blue_aliens3', 'blue_pl3', 'blue_trolls3', 'blue_cats3'}
	local four = {'blue_playboys4', 'blue_aliens4', 'blue_pl4', 'blue_trolls4', 'blue_cats4'}
	if not checkLoc(src, 'stamp', num) then return end
	  if RemoveItem(src, "blue_xtc", 1) then
		  AddItem(src, one[chance], 1)
	  elseif RemoveItem(src, "blue_xtc2", 1) then
		  AddItem(src, two[chance], 1)
	  elseif RemoveItem(src, "blue_xtc3", 1) then
		  AddItem(src, three[chance], 1) 
	  elseif RemoveItem(src, "blue_xtc4", 1) then
		  AddItem(src, four[chance], 1) 
	  else 
		  Notifys('You Dont Have Unstamped blue Pills', 'error')
	  end
end)

AddEventHandler('playerDropped', function()
	local src = source
	local Player = getPlayer(src)
	for k, v in pairs (activePresses) do
		if v.ownerid == Player.PlayerData.citizenid then
			table.remove(activePresses, k)
			AddItem(src, v.get, 1)
		end
	end
end)