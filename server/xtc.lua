
-------------------- stealing ingridients 
local RecipeList = {
	 raw = {
        raw_xtc = {take = {mdp2p = 1, isosafrole = 1}, give = {raw_xtc = 1}}
    },
	singlestack = {
	    white_xtc =  {amount = 1,    take = {raw_xtc = 1}},
		red_xtc = 	 {amount = 1,    take = {raw_xtc = 1, loosecoke = 1},},
		orange_xtc = {amount = 1,    take = {raw_xtc = 1, heroinvial = 1},},
		blue_xtc = 	 {amount = 1,    take = {raw_xtc = 1, crackrock = 1},},
	 },
	 dualstack = {
	    white_xtc2 =  {amount = 1,    take = {raw_xtc = 1},},
		red_xtc2 =    {amount = 1,    take = {raw_xtc = 1, loosecoke = 1},},
		orange_xtc2 = {amount = 1,    take = {raw_xtc = 1, heroinvial = 1},},
		blue_xtc2 =   {amount = 1,    take = {raw_xtc = 1, crackrock = 1},},
	 },
	 triplestack = {
	     white_xtc3 =   {amount = 1, take = {raw_xtc = 1},},
		red_xtc3 = 	   {amount = 1, take = {raw_xtc = 1, loosecoke = 1},},
		orange_xtc3 =  {amount = 1, take = {raw_xtc = 1, heroinvial = 1},},
		blue_xtc3 =    {amount = 1, take = {raw_xtc = 1, crackrock = 1},},
	 },
	 quadstack = {
		white_xtc4 = 	{amount = 1,    take = {raw_xtc = 1},},
		red_xtc4 = 		{amount = 1,    take = {raw_xtc = 1, loosecoke = 1},},
		orange_xtc4 = 	{amount = 1,    take = {raw_xtc = 1, heroinvial = 1},},
		blue_xtc4 = 	{amount = 1,    take = {raw_xtc = 1, crackrock = 1},},
	 },
	presses = {
		singlepress = {cash = 10000},
		dualpress =   {amount = 1, take = {white_xtc = 20, blue_xtc = 20, red_xtc = 20, orange_xtc = 20, singlepress = 1}},
		triplepress = {amount = 1, take = {white_xtc2 = 50, blue_xtc2 = 50, red_xtc2 = 50, orange_xtc2 = 50, dualpress = 1}},
		quadpress =   {amount = 1, take = {white_xtc3 = 50, blue_xtc3 = 50, red_xtc3 = 50, orange_xtc3 = 50, triplepress = 1}},
	}
}

local xtcLocations = {
	isosafrole = { -- where to steal isosafrole
        {loc = vector3(844.39, -902.92, 25.42), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    mdp2p = { -- where to steal mdp2p
        {loc = vector3(844.4, -898.79, 25.23), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    rawxtcloc = { --  where to combine the 2 ingridents to make raw xtc
        {loc = vector3(844.71, -910.33, 25.37), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    xtcpress = {
        {ped = 'g_f_y_families_01',loc = vector4(845.82, -884.79, 25.18, 180.0), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    stamp = {  --  where to stamp pills
        {loc = vector3(844.71, -900.56, 25.43), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
}

ps.registerCallback('md-drugs:server:GetXtcLocs', function(source)
	return xtcLocations
end)

local function craft(source, tbl, item)
    local src = source
    local need, have = 0,0
    for k, v in pairs(tbl.take) do
        if ps.hasItem(src, k, v) then
            have = have + v
        end
        need = need + v
    end
    if need == have then
        for k, v in pairs (tbl.take) do
            ps.removeItem(src, k, v)
        end
        ps.addItem(src, item , tbl.amount)
        return true
    end
    return false
end

local activePresses = {}
local timeout = {}

local function timeOut(src)
	CreateThread(function()
		timeout[ps.getIdentifier(src)] = true
		Wait(3000)
		timeout[ps.getIdentifier(src)] = nil
	end)
end

RegisterServerEvent('md-drugs:server:stealisosafrole', function(num)
  	local src = source
	if not ps.checkDistance(src, xtcLocations.isosafrole[num].loc, 3.0) then
		ps.notify(src, ps.lang('Checks.notIn'), "error")
		return
	end
	if timeout[ps.getIdentifier(src)] then
		ps.notify(src, ps.lang('Catches.cooldown'),	 'error')
		return
	end
	timeOut(src)
  	ps.addItem(src, "isosafrole", 1)
end)

RegisterServerEvent('md-drugs:server:stealmdp2p', function(num)
  	local src = source
	if not ps.checkDistance(src, xtcLocations.mdp2p[num].loc, 3.0) then
		ps.notify(src, ps.lang('Checks.notIn'), "error")
		return
	end
  	if timeout[ps.getIdentifier(src)] then
		ps.notify(src, ps.lang('Catches.cooldown'),	 'error')
		return
	end
	timeOut(src)
  	ps.addItem(src, "mdp2p", 1)
end)

local presses = {
	{item = 'singlepress',  data = 'singlestack', 	recipes = RecipeList.singlestack},
	{item = 'dualpress', 	data = 'dualstack', 	recipes = RecipeList.dualstack},
	{item = 'triplepress',  data = 'triplestack', 	recipes = RecipeList.triplestack},
	{item = 'quadpress',    data = 'quadstack', 	recipes = RecipeList.quadstack},
}

for k, v in pairs (presses) do
ps.createUseable(v.item, function(source, item)
	local src = source
	local check, loc = ps.callback('md-drugs:client:setpress', src, v)
		if check then
			if ps.removeItem(src, v.item, 1) then
				activePresses[ps.getIdentifier(src)] = {
					press = v.data,
					get = v.item,
					owner = ps.getPlayerName(src),
					ownerid = ps.getIdentifier(src),
					src = src,
					loc = loc
				}
			end
		end
	end)
end

RegisterServerEvent('md-drugs:server:getpressback', function()
	local src = source
	if not activePresses[ps.getIdentifier(src)] then return end
	local press = activePresses[ps.getIdentifier(src)]
	ps.addItem(src, press.get, 1)
	activePresses[ps.getIdentifier(src)] = nil
end)

RegisterServerEvent('md-drugs:server:makextc', function(data)
  	local src = source
  	if not activePresses[ps.getIdentifier(src)] then
		ps.notify(src, ps.lang('xtc.noPressOut'), 'error')
		return
  	end
  	craft(src, RecipeList[activePresses[ps.getIdentifier(src)].press][data], data)
end)

RegisterServerEvent('md-drugs:server:buypress', function()
	local src = source
	if ps.removeMoney(src,"cash", RecipeList.presses['singlepress'].cash) then
		ps.addItem(src, "singlepress", 1)
	else
		ps.notify(src, ps.lang('Catches.notEnoughMoney'), "error")
	end
end)

RegisterServerEvent('md-drugs:server:upgradepress', function(data)
  	local src = source
  	if not ps.checkDistance(src, xtcLocations.xtcpress[data].loc, 2.0) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return
  	end
    craft(src, RecipeList.presses[data], data)
end)

ps.registerCallback('md-drugs:server:getpressrecipes', function(source)
	return RecipeList.presses
end)
------------- making powder
RegisterServerEvent('md-drugs:server:makingrawxtc', function(num)
    local src = source
	if not ps.checkDistance(src, xtcLocations.rawxtcloc[num].loc, 3.0) then
		ps.notify(src, ps.lang('Checks.notIn'), "error")
		return
	end
	if timeout[ps.getIdentifier(src)] then
		ps.notify(src, ps.lang('Catches.cooldown'), 'error')
		return
	end
	timeOut(src)
  	if not ps.craftItem(src, RecipeList.raw.raw_xtc) then return end
end)

local function getColor(color)
	local colors = {
		white = {'white_playboys', 'white_aliens', 'white_pl', 'white_trolls', 'white_cats'},
		red = {'red_playboys', 'red_aliens', 'red_pl', 'red_trolls', 'red_cats'},
		orange = {'orange_playboys', 'orange_aliens', 'orange_pl', 'orange_trolls', 'orange_cats'},
		blue = {'blue_playboys', 'blue_aliens', 'blue_pl', 'blue_trolls', 'blue_cats'}
	}
	if colors[color] then
		return colors[color][math.random(#colors[color])]
	end
	return nil
end

RegisterServerEvent('md-drugs:server:stamp', function(num, color)
    local src = source
	if not ps.checkDistance(src, xtcLocations.stamp[num].loc, 3.0) then return end
    local item = getColor(color)
	local colors = {
		white = 'white_xtc',
		red = 'red_xtc',
		orange = 'orange_xtc',
		blue = 'blue_xtc'
	}
	if ps.removeItem(src, colors[color], 1) then
		ps.addItem(src, item, 1)
	elseif ps.removeItem(src, colors[color].."2", 1) then
		ps.addItem(src, item..'2', 1)
	elseif ps.removeItem(src, colors[color].."3", 1) then
		ps.addItem(src, item..'3', 1) 
	elseif ps.removeItem(src, colors[color].."4", 1) then
		ps.addItem(src, item..'4', 1) 
	else
		ps.notify(src, ps.lang('xtc.noPills'), 'error')
	end
end)

AddEventHandler('playerDropped', function()
	local src = source
	if activePresses[ps.getIdentifier(src)] then
		ps.addItem(src, activePresses[ps.getIdentifier(src)].get, 1)
		activePresses[ps.getIdentifier(src)] = nil
	end
end)