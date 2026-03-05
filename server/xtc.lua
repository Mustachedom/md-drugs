if not Config.Drugs['xtc'] then return end
local activePresses = {}

RegisterServerEvent('md-drugs:server:stealisosafrole', function(num)
  	local src = source
	if not checkDistance(src, Config.XTC.Locations.isosafrole[num].loc, 3.0,'md-drugs:server:stealisosafrole') then
		return
	end
	if timeOut(src, 'md-drugs:server:stealisosafrole') then return end
  	Bridge.Inventory.AddItem(src, "isosafrole", 1)
end)

RegisterServerEvent('md-drugs:server:stealmdp2p', function(num)
  	local src = source
	if not checkDistance(src, Config.XTC.Locations.mdp2p[num].loc, 3.0,'md-drugs:server:stealmdp2p') then
		return
	end
	if timeOut(src, 'md-drugs:server:stealmdp2p') then return end
  	Bridge.Inventory.AddItem(src, "mdp2p", 1)
end)

local presses = {
	{item = 'singlepress',  data = 'singlestack', 	recipes = Config.XTC.Recipes.singlestack},
	{item = 'dualpress', 	data = 'dualstack', 	recipes = Config.XTC.Recipes.dualstack},
	{item = 'triplepress',  data = 'triplestack', 	recipes = Config.XTC.Recipes.triplestack},
	{item = 'quadpress',    data = 'quadstack', 	recipes = Config.XTC.Recipes.quadstack},
}

for k, v in pairs (presses) do
	Bridge.Framework.RegisterUsableItem(v.item, function(source, item)
	local src = source
	local location = Bridge.Callback.Trigger('md-drugs:client:setpress', src, v)
		if location then
			if Bridge.Inventory.RemoveItem(src, v.item, 1) then
				activePresses[src] = {
					press = v.data,
					get = v.item,
					owner = Bridge.Framework.GetPlayerName(src),
					ownerid = Bridge.Framework.GetPlayerIdentifier(src),
					src = src,
					loc = location
				}
			end
		end
	end)
end

RegisterServerEvent('md-drugs:server:getpressback', function()
	local src = source
	if not activePresses[src] then return end
	local press = activePresses[src]
	if not checkDistance(src, press.loc, 2.0,'md-drugs:server:getpressback' ) then
		return
	end
	Bridge.Inventory.AddItem(src, press.get, 1)
	activePresses[src] = nil
end)

RegisterServerEvent('md-drugs:server:makextc', function(data)
  	local src = source
  	if not activePresses[src] then
		Bridge.Prints.Warn(Bridge.Language.Locale('xtc.noActivePress', Bridge.Framework.GetPlayerIdentifier(src)))
		return
  	end
	if timeOut(src, 'md-drugs:server:makextc') then return end
	if not checkDistance(src, activePresses[src].loc, 2.0, 'md-drugs:server:makextc') then
		return
	end
	if not craft(src, Config.XTC.Recipes[activePresses[src].press][data]) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:buypress', function(loc, item)
	local src = source
	if not checkDistance(src, Config.XTC.Locations.xtcpress[loc].loc, 2.0, 'md-drugs:server:buypress') then
		return
	end
	if timeOut(src, 'md-drugs:server:buypress') then return end
	if Bridge.Framework.RemoveAccountBalance(src,"cash", Config.XTC.Recipes.presses['singlepress'].cash) then
		Bridge.Inventory.AddItem(src, "singlepress", 1)
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notEnoughMoney'), "error")
	end
end)

RegisterServerEvent('md-drugs:server:upgradepress', function(data, item)
  	local src = source
	if timeOut(src, 'md-drugs:server:upgradepress') then return end
  	if not checkDistance(src, Config.XTC.Locations.xtcpress[data].loc, 2.0, 'md-drugs:server:buypress') then
		return
	end
  	if not craft(src, Config.XTC.Recipes.presses[item]) then
		return
	end
end)

------------- making powder
RegisterServerEvent('md-drugs:server:makingrawxtc', function(num)
    local src = source
	if not checkDistance(src, Config.XTC.Locations.rawxtcloc[num].loc, 3.0, 'md-drugs:server:makingrawxtc') then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Checks.notIn'), "error")
		return
	end
	if timeOut(src, 'md-drugs:server:makingrawxtc') then return end
  	if not craft(src, Config.XTC.Recipes.raw.raw_xtc) then
		return
	end
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
	if not checkDistance(src, Config.XTC.Locations.stamp[num].loc, 3.0, 'md-drugs:server:stamp') then return end
	if timeOut(src, 'md-drugs:server:stamp') then return end
    local item = getColor(color)
	local colors = {
		white = 'white_xtc',
		red = 'red_xtc',
		orange = 'orange_xtc',
		blue = 'blue_xtc'
	}
	if Bridge.Inventory.RemoveItem(src, colors[color], 1) then
		Bridge.Inventory.AddItem(src, item, 1)
	elseif Bridge.Inventory.RemoveItem(src, colors[color].."2", 1) then
		Bridge.Inventory.AddItem(src, item..'2', 1)
	elseif Bridge.Inventory.RemoveItem(src, colors[color].."3", 1) then
		Bridge.Inventory.AddItem(src, item..'3', 1) 
	elseif Bridge.Inventory.RemoveItem(src, colors[color].."4", 1) then
		Bridge.Inventory.AddItem(src, item..'4', 1) 
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('xtc.noPills'), 'error')
	end
end)

AddEventHandler('playerDropped', function()
	local src = source
	if activePresses[src] then
		Bridge.Inventory.AddItem(src, activePresses[src].get, 1)
		activePresses[src] = nil
	end
end)