Recipes, Locations = Recipes or {}, Locations or {}

local heroinLabKits = {}
Recipes.Heroin = {
   dryheroin = {
       tier1 = {take = {poppyresin = 1}, give = {heroin = 1}},
       tier2 = {take = {poppyresin = 1}, give = {heroinstagetwo = 1}},
       tier3 = {take = {poppyresin = 1}, give = {heroinstagethree = 1}},
   },
   cutheroin = {
       tier1 = {take = {heroin = 1,            bakingsoda = 1}, give = {heroincut = 1}},
       tier2 = {take = {heroinstagetwo = 1,    bakingsoda = 1}, give = {heroincutstagetwo = 1}},
       tier3 = {take = {heroinstagethree = 1,  bakingsoda = 1}, give = {heroincutstagethree = 1}},
   },
   fillvial = {
       tier1 = {take = {heroincut = 1,            emptyvial = 1}, give = {heroinvial = 1}},
       tier2 = {take = {heroincutstagetwo = 1,    emptyvial = 1}, give = {heroinvialstagetwo = 1}},
       tier3 = {take = {heroincutstagethree = 1,  emptyvial = 1}, give = {heroinvialstagethree = 1}},
   },
   fillneedle = {
       tier1 = {take = {heroinvial = 1,            needle = 1}, give = {heroin_ready = 1}},
       tier2 = {take = {heroinvialstagetwo = 1,    needle = 1}, give = {heroin_readystagetwo = 1}},
       tier3 = {take = {heroinvialstagethree = 1,  needle = 1}, give = {heroin_readystagethree = 1}},
   }
}
GlobalState.MDDrugsRecipes = Recipes

Locations.Heroin = {
    dryplant = {  -- turn resin into powder
        {loc = vector3(-1353.77, -335.58, 43.92), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    cutheroinone = {  -- cut heroin stage 1-3 with baking soda
        {loc = vector3(-1360.14, -337.03, 43.92), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    }, 
    fillneedle = { -- fill needles with heroin
        {loc = vector3(-1366.32, -334.40, 44.44), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
	buyKit = {
		{ped = 'a_m_m_farmer_01',loc = vector4(-1366.32, -334.40, 44.44,180.0), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
	}
}
GlobalState.MDDrugsLocations = Locations

local prices = {
	heroinlabkitprice = 10000
}


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

	if not checkDistance(src, Locations.Heroin.dryplant[num].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
		return
	end

	local tier = getTier(src)
	if not craft(src, Recipes.Heroin.dryheroin[tier]) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:cutheroin', function(num)
	local src = source

	if timeOut(src, 'md-drugs:server:cutheroin') then return end

	if not checkDistance(src, Locations.Heroin.cutheroinone[num].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
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
			end
		end
	end

	if not craft(src, Recipes.Heroin.cutheroin[tier]) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkit', function(num)
	local src = source

	if timeOut(src, 'md-drugs:server:getheroinlabkit') then return end

	if not checkDistance(src, Locations.Heroin.buyKit[num].loc, 3.0) then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
		return
	end

	local has = Bridge.Inventory.HasItem(src, 'heroinlabkit')
	if has then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('heroin.hasKitAlready'), 'error')
		return
	end
	if Bridge.Framework.RemoveAccountBalance(src, 'cash', prices.heroinlabkitprice) then
		Bridge.Inventory.AddItem(src, 'heroinlabkit', 1)
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('heroin.notEnoughMoney', prices.heroinlabkitprice), 'error')
	end
end)



RegisterServerEvent('md-drugs:server:getheroinlabkitback', function()
	local src = source

	if not heroinLabKits[src] then
		return
	end

	local loc = vector3(heroinLabKits[src].coords.x, heroinLabKits[src].coords.y, heroinLabKits[src].coords.z)
	if not checkDistance(src, loc, 5.0) then
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
				ownerid = Bridge.Framework.GetPlayerIdentifier(src),
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
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
		return
	end

	if not Bridge.Inventory.HasItem(src, 'emptyvial', 1) then return end
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
	if not craft(src, Recipes.Heroin.fillvial[tier]) then
		return
	end
end)

RegisterServerEvent('md-drugs:server:failheatingheroin', function()
	local src = source

	if not heroinLabKits[src] then
		Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
		return
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

	if not checkDistance(src, Locations.Heroin.fillneedle[num].loc, 3.0) then
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notIn'), 'error')
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
	if not craft(src, Recipes.Heroin.fillneedle[tier]) then
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
