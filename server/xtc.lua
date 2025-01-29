
-------------------- stealing ingridients 
local activePresses = {}
RegisterServerEvent('md-drugs:server:stealisosafrole', function(num)
  	local src = source
	if not checkLoc(src, 'isosafrole',num) then return end
  	if AddItem(src, "isosafrole", 1) then
  	end
end)

RegisterServerEvent('md-drugs:server:stealmdp2p', function(num)
  	local src = source
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
CUI(v.item, function(source, item)
local src = source
local Player = getPlayer(src)
local check, loc = lib.callback.await('md-drugs:client:setpress', src, v.data)
	if check then
		if RemoveItem(src, v.item, 1) then
			table.insert(activePresses, {
				press = v.data,
				get = v.item,
				owner = GetName(src),
				ownerid = getCid(source),
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
		if v.ownerid == getCid(source) then
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
		if v.ownerid == getCid(source) then
			if  #(coords - v.loc) < 3.0 then
				return v.press
			end
		end
	end
	return 'none'
end

RegisterServerEvent('md-drugs:server:makextc', function(data)
    local src = source
    if not Itemcheck(src, 'raw_xtc', 1) then return end

    local pressType = pressout(src)
    if pressType == 'none' then return end

    local validColors = {'white', 'red', 'orange', 'blue'}
    local isValidColor = false

    for _, color in ipairs(validColors) do
        if data.color == color then
            isValidColor = true
            break
        end
    end

    if not isValidColor then return end

    local stackType = pressType .. 'stack'
    if not GetRecipe(src, 'xtc', stackType, data.color) then return end
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
  if not GetRecipe(src, 'xtc', 'press', data) then return end
end)

------------- making powder
RegisterServerEvent('md-drugs:server:makingrawxtc', function(num)
    local src = source
    if not checkLoc(src, 'rawxtcloc',num) then return end
  	if not GetRecipe(src, 'xtc', 'raw', 'raw_xtc') then return end
end)
  
RegisterServerEvent('md-drugs:server:stampwhite', function(num)
    local src = source
    local whitePills = {
        {item = 'white_xtc',  stamped = {'white_playboys', 'white_aliens', 'white_pl', 'white_trolls', 'white_cats'}},
        {item = 'white_xtc2', stamped = {'white_playboys2', 'white_aliens2', 'white_pl2', 'white_trolls2', 'white_cats2'}},
        {item = 'white_xtc3', stamped = {'white_playboys3', 'white_aliens3', 'white_pl3', 'white_trolls3', 'white_cats3'}},
        {item = 'white_xtc4', stamped = {'white_playboys4', 'white_aliens4', 'white_pl4', 'white_trolls4', 'white_cats4'}}
    }
    local chance = math.random(1, 5)

    if not checkLoc(src, 'stamp', num) then return end
    for k, v in ipairs(whitePills) do
        if RemoveItem(src, v.item, 1) then
            AddItem(src, v.stamped[chance], 1)
            return
        end
    end
    Notifys('You Dont Have Unstamped White Pills', 'error')
end)

RegisterServerEvent('md-drugs:server:stampred', function(num)
	local src = source
	if not checkLoc(src, 'stamp', num) then return end
	local redPills = {
		{item = 'red_xtc',  stamped = {'red_playboys', 'red_aliens', 'red_pl', 'red_trolls', 'red_cats'}},
		{item = 'red_xtc2', stamped = {'red_playboys2', 'red_aliens2', 'red_pl2', 'red_trolls2', 'red_cats2'}},
		{item = 'red_xtc3', stamped = {'red_playboys3', 'red_aliens3', 'red_pl3', 'red_trolls3', 'red_cats3'}},
		{item = 'red_xtc4', stamped = {'red_playboys4', 'red_aliens4', 'red_pl4', 'red_trolls4', 'red_cats4'}}
	}
	local chance = math.random(1, 5)

    if not checkLoc(src, 'stamp', num) then return end
    for k, v in ipairs(redPills) do
        if RemoveItem(src, v.item, 1) then
            AddItem(src, v.stamped[chance], 1)
            return
        end
    end
    Notifys('You Dont Have Unstamped Red Pills', 'error')
end)

RegisterServerEvent('md-drugs:server:stamporange', function(num)
	local src = source
	local orangePills = {
		{item = 'orange_xtc',  stamped = {'orange_playboys', 'orange_aliens', 'orange_pl', 'orange_trolls', 'orange_cats'}},
		{item = 'orange_xtc2', stamped = {'orange_playboys2', 'orange_aliens2', 'orange_pl2', 'orange_trolls2', 'orange_cats2'}},
		{item = 'orange_xtc3', stamped = {'orange_playboys3', 'orange_aliens3', 'orange_pl3', 'orange_trolls3', 'orange_cats3'}},
		{item = 'orange_xtc4', stamped = {'orange_playboys4', 'orange_aliens4', 'orange_pl4', 'orange_trolls4', 'orange_cats4'}}
	}
	local chance = math.random(1, 5)

    if not checkLoc(src, 'stamp', num) then return end
    for k, v in ipairs(orangePills) do
        if RemoveItem(src, v.item, 1) then
            AddItem(src, v.stamped[chance], 1)
            return
        end
    end
    Notifys('You Dont Have Unstamped Orange Pills', 'error')
end)

RegisterServerEvent('md-drugs:server:stampblue', function(num)
	local src = source

	local bluePills = {
		{item = 'blue_xtc',  stamped = {'blue_playboys', 'blue_aliens', 'blue_pl', 'blue_trolls', 'blue_cats'}},
		{item = 'blue_xtc2', stamped = {'blue_playboys2', 'blue_aliens2', 'blue_pl2', 'blue_trolls2', 'blue_cats2'}},
		{item = 'blue_xtc3', stamped = {'blue_playboys3', 'blue_aliens3', 'blue_pl3', 'blue_trolls3', 'blue_cats3'}},
		{item = 'blue_xtc4', stamped = {'blue_playboys4', 'blue_aliens4', 'blue_pl4', 'blue_trolls4', 'blue_cats4'}}
	}
	local chance = math.random(1, 5)

	if not checkLoc(src, 'stamp', num) then return end
	for k, v in ipairs(bluePills) do
		if RemoveItem(src, v.item, 1) then
			AddItem(src, v.stamped[chance], 1)
			return
		end
	end
	Notifys('You Dont Have Unstamped Blue Pills', 'error')
end)

AddEventHandler('playerDropped', function()
	local src = source
	for k, v in pairs (activePresses) do
		if v.ownerid == getCid(source) then
			table.remove(activePresses, k)
			AddItem(src, v.get, 1)
		end
	end
end)