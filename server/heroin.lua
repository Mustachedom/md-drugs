
local heroinLabKits = {}


Bridge.Callback.Register('md-drugs:server:removeCleaningKitHeroin', function(source)
	if heroinLabKits[source] then
		return Bridge.Inventory.RemoveItem(source, 'cleaningkit', 1)
	end
	return false
end)

local function getTier(source)
	if not Config.TierSystem then
		return 'tier1'
	end
	local heroin = tonumber(getRep(source, 'heroin'))
	if heroin <= Config.Tier1 then
		return 'tier1'
	elseif heroin >= Config.Tier1 and heroin <= Config.Tier2 then
		return'tier2'
	else
		return 'tier3'
	end
end

RegisterServerEvent('md-drugs:server:dryplant', function(num)
	local src = source

	if timeOut(src, 'md-drugs:server:dryplant') then return end

	if not checkDistance(src, Config.Heroin.Locations.dryplant[num].loc, 3.0, 'md-drugs:server:dryplant') then
		return
	end

	local tier = getTier(src)
	if not craft(src, Config.Heroin.Recipes.dryheroin[tier]) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:cutheroin', function(num)
	local src = source

	if timeOut(src, 'md-drugs:server:cutheroin') then return end

	if not checkDistance(src, Config.Heroin.Locations.cutheroinone[num].loc, 3.0, 'md-drugs:server:cutheroin') then
		return
	end

	local tier = 'tier1'
	if Config.TierSystem then
		local itemList = {
			heroin = 'tier1',
			heroinstagetwo = 'tier2',
			heroinstagethree = 'tier3'
		}
		for item, tiers in pairs (itemList) do
			if Bridge.Inventory.HasItem(src, item) then
				tier = tiers
				break
			end
		end
	end

	if not craft(src, Config.Heroin.Recipes.cutheroin[tier]) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkit', function(num)
	local src = source

	if timeOut(src, 'md-drugs:server:getheroinlabkit') then return end

	if not checkDistance(src, Config.Heroin.Locations.buyKit[num].loc, 3.0, 'md-drugs:server:getheroinlabkit') then
		return
	end

	local has = Bridge.Inventory.HasItem(src, 'heroinlabkit')
	if has then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('heroin.hasKitAlready'), 'error')
		return
	end
	if Bridge.Framework.RemoveAccountBalance(src, 'cash', Config.Heroin.prices.heroinlabkitprice) then
		Bridge.Inventory.AddItem(src, 'heroinlabkit', 1)
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('heroin.notEnoughMoney', Config.Heroin.prices.heroinlabkitprice), 'error')
	end
end)



RegisterServerEvent('md-drugs:server:getheroinlabkitback', function()
	local src = source

	if not heroinLabKits[src] then
		return
	end

	local loc = vector3(heroinLabKits[src].coords.x, heroinLabKits[src].coords.y, heroinLabKits[src].coords.z)
	if not checkDistance(src, loc, 5.0, 'md-drugs:server:getheroinlabkitback') then
		return
	end

	heroinLabKits[src] = nil
	Bridge.Inventory.AddItem(src, 'heroinlabkit', 1)
end)


Bridge.Framework.RegisterUsableItem('heroinlabkit', function(source, item)
	local src = source

	if not Bridge.Inventory.HasItem(src, 'heroinlabkit', 1) then
		return
	end

	if heroinLabKits[src] then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('heroin.hasKitAlreadyPlaced'), "error")
		return
	end

	local placed, loc = Bridge.Callback.Trigger('md-drugs:client:setheroinlabkit', src)
	if placed then
		if Bridge.Inventory.RemoveItem(src, 'heroinlabkit', 1) then
			heroinLabKits[src] = {
				src = src,
				coords = loc,
			}
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('heroin.placedKit'), "success")
		end
	end
end)

RegisterServerEvent('md-drugs:server:heatliquidheroin', function()
	local src = source

	if timeOut(src, 'md-drugs:server:heatliquidheroin') then return end

	if not heroinLabKits[src] then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.missedTable', Bridge.Framework.GetPlayerIdentifier(src), 'md-drugs:server:heatliquidheroin'), 'error')
		return
	end

	if not checkDistance(src, heroinLabKits[src].coords, 3.0, 'md-drugs:server:heatliquidheroin') then
		return
	end

	local tier = 'tier1'
	if Config.TierSystem then
		local itemList = {
			heroincut = 'tier1',
			heroincutstagetwo = 'tier2',
			heroincutstagethree = 'tier3'
		}
		for k, v in pairs(itemList) do
			if Bridge.Inventory.HasItem(src, k) then
				tier = v
				break
			end
		end
	end
	if not craft(src, Config.Heroin.Recipes.fillvial[tier]) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:failheatingheroin', function()
	local src = source

	if not heroinLabKits[src] then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.missedTable', Bridge.Framework.GetPlayerIdentifier(src), 'md-drugs:server:failheatingheroin'), 'error')
	end

	local itemList = {
		heroincut = 1,
		heroincutstagetwo = 1,
		heroincutstagethree = 1
	}

	for k, v in pairs(itemList) do
		if Bridge.Inventory.RemoveItem(src, k, v) then
			Bridge.Notify.SendNotify(src, Bridge.Language.Locale('heroin.failed'), "error")
			return
		end
	end
end)

RegisterServerEvent('md-drugs:server:fillneedle', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:fillneedle') then return end

	if not checkDistance(src, Config.Heroin.Locations.fillneedle[num].loc, 3.0, 'md-drugs:server:fillneedle') then
		return
	end
	local tier = 'tier1'
	if Config.TierSystem then
		local itemList = {
			heroinvial = 'tier1',
			heroinvialstagetwo = 'tier2',
			heroinvialstagethree = 'tier3'
		}	
		for item, tiers in pairs (itemList) do
			if Bridge.Inventory.HasItem(src, item) then
				tier = tiers
				break
			end
		end
	end
	if not craft(src, Config.Hero8in.Recipes.fillneedle[tier]) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:failheroin', function()
	local src = source
	if Config.TierSystem then
		local itemList = {
			heroinvial = 1,
			heroinvialstagetwo = 1,
			heroinvialstagethree = 1
		}
		for k, v in pairs (itemList) do
			if Bridge.Inventory.RemoveItem(src, k, v) then
				Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Heroin.failneedle'), "error")
				return
			end
		end
	else
		Bridge.Inventory.RemoveItem(src, 'heroinvial', 1)
	end
end)

AddEventHandler('playerDropped', function()
	local src = source
	if heroinLabKits[src] then
		heroinLabKits[src] = nil
		Bridge.Inventory.AddItem(src, 'heroinlabkit', 1)
	end
end)
