local heroinLabKits = {}
local heroinRecipes = {
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
       tier2 = {take = {heroinvialstagetwo = 1,  needle = 1}, give = {heroin_readystagetwo = 1}},
       tier3 = {take = {heroinvialstagethree = 1,  needle = 1}, give = {heroin_readystagethree = 1}},
   }
}

local heroinLocations = {
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

local prices = {
	heroinlabkitprice = 10000
}

ps.registerCallback('md-drugs:server:GetHeroinLocations', function(source)
	return heroinLocations
end)


ps.registerCallback('removeCleaningkit', function(source)
	for k, v in pairs(heroinLabKits) do
		if v.ownerid == ps.getIdentifier(source) then
			ps.removeItem(source, 'cleaningkit', 1)
			return true
		end
	end
	return false
end)

RegisterServerEvent('md-drugs:server:dryplant', function(num)
	local src = source

	if timeOut(src, 'md-drugs:server:dryplant') then return end
	if not ps.checkDistance(src, heroinLocations.dryplant[num].loc, 3.0) then 
		ps.notify(src, ps.lang('Catches.notIn'), 'error')
		return
	end

	local tier = 'tier1'
	if Config.TierSystem then
		local heroin = tonumber(getRep(src, 'heroin'))
		if heroin <= Config.Tier1 then
			tier = 'tier1'
		elseif heroin >= Config.Tier1 and heroin <= Config.Tier2 then
			tier = 'tier2'
		else
			tier = 'tier3'
		end
	end
	if not ps.craftItem(src, heroinRecipes['dryheroin'][tier]) then
		verifyHas(src, heroinRecipes['dryheroin'][tier].take)
		return
	end
end)

RegisterServerEvent('md-drugs:server:cutheroin', function(num)
	local src = source

	if timeOut(src, 'md-drugs:server:cutheroin') then return end

	if not ps.checkDistance(src, heroinLocations.cutheroinone[num].loc, 3.0) then
		ps.notify(src, ps.lang('Catches.notIn'), 'error')
		return
	end
	if Config.TierSystem then
		local itemList = {
			heroin = 'tier1',
			heroinstagetwo = 'tier2',
			heroinstagethree = 'tier3'
		}
		for k, v in pairs(itemList) do
			local cuth = ps.hasItem(src, k)
			if cuth then
				if not ps.craftItem(src, heroinRecipes['cutheroin'][v]) then
					verifyHas(src, heroinRecipes['cutheroin'][v].take)
					return
				end
				AddRep(src, 'heroin')
				return
			end
		end
	else
		if not ps.craftItem(src, heroinRecipes['cutheroin']['tier1']) then
			verifyHas(src, heroinRecipes['cutheroin']['tier1'].take)
			return
		end
	end
end)

RegisterServerEvent('md-drugs:server:getheroinlabkit', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:getheroinlabkit') then return end
	if not ps.checkDistance(src, heroinLocations.buyKit[num].loc, 3.0) then
		ps.notify(src, ps.lang('Catches.notIn'), 'error')
		return
	end
	local has = ps.hasItem(src, 'heroinlabkit')
	if has then ps.notify(src, ps.lang('heroin.hasKitAlready'), 'error') return end
	if ps.removeMoney(src, 'cash', prices.heroinlabkitprice) then
		ps.addItem(src, 'heroinlabkit', 1)
	else
		ps.notify(src, ps.lang('heroin.notEnoughMoney', prices.heroinlabkitprice), 'error')
	end
end)

local function hasHKit(src)
	for k, v in pairs(heroinLabKits) do
		if v.ownerid == ps.getIdentifier(src) then
			return true
		end
	end
	return false
end

RegisterServerEvent('md-drugs:server:getheroinlabkitback', function()
	local src = source
	if not hasHKit(src) then return end
	for k, v in pairs (heroinLabKits) do
		if v.ownerid == ps.getIdentifier(src) then
			table.remove(heroinLabKits, k)
			ps.addItem(src, 'heroinlabkit', 1)
		end
	end
end)


ps.createUseable('heroinlabkit', function(source, item)
	local src = source
	if not ps.hasItem(src, 'heroinlabkit', 1) then return end
	local placed, loc = ps.callback('md-drugs:client:setheroinlabkit', src)
	if placed then
		if ps.removeItem(src, 'heroinlabkit', 1) then
			table.insert(heroinLabKits, {
				src = src,
				ownerid = ps.getIdentifier(src),
				coords = loc,
				name = ps.getPlayerName(src)
			})
			ps.notify(src, ps.lang('heroin.placedKit'), "success")
		end
	end
end)

RegisterServerEvent('md-drugs:server:heatliquidheroin', function()
	local src = source

	if timeOut(src, 'md-drugs:server:heatliquidheroin') then return end

	if not hasHKit(src) then return end
	if not ps.hasItem(src, 'emptyvial', 1) then return end
	
	if Config.TierSystem then
		local itemList = {
			heroincut = 'tier1',
			heroincutstagetwo = 'tier2',
			heroincutstagethree = 'tier3'
		}
		for k, v in pairs(itemList) do
			local cuth = ps.hasItem(src, k)
			if cuth then
				if not ps.craftItem(src, heroinRecipes['fillvial'][v]) then
					verifyHas(src, heroinRecipes['fillvial'][v].take)
					return
				end
				AddRep(src, 'heroin')
				return
			end
		end
	else
		if not ps.craftItem(src, heroinRecipes['fillvial']['tier1']) then
			verifyHas(src, heroinRecipes['fillvial']['tier1'].take)
			return
		end
	end
end)

RegisterServerEvent('md-drugs:server:failheatingheroin', function()
	local src = source
	if not hasHKit(src) then return end
	local itemList = {
		heroincut = 1,
		heroincutstagetwo = 1,
		heroincutstagethree = 1
	}
	for k, v in pairs(itemList) do
		local cuth = ps.hasItem(src, k)
		if cuth then
			ps.removeItem(src, k, v)
			ps.notify(src, ps.lang('heroin.failed'), "error")
			return
		end
	end
end)

RegisterServerEvent('md-drugs:server:fillneedle', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:fillneedle') then return end
	if not ps.checkDistance(src, heroinLocations.fillneedle[num].loc, 3.0) then
		ps.notify(src, ps.lang('Catches.notIn'), 'error')
		return
	end
	if not ps.hasItem(src, 'needle', 1) then return end
	if Config.TierSystem then
		local itemList = {
			{item = 'heroinvial', 		  	tier = 'tier1',   log = ' Filled Heroin Needle'},
			{item = 'heroinvialstagetwo',   tier = 'tier2', log = ' Filled Heroin Needle tier 2'},
			{item = 'heroinvialstagethree', tier = 'tier3', log = ' Filled Heroin Needle tier 3'}
		}
		for k, v in pairs(itemList) do
			local vh = ps.hasItem(src, v.item)
			if vh then
				if not ps.craftItem(src, heroinRecipes['fillneedle'][v.tier]) then
					verifyHas(src, heroinRecipes['fillneedle'][v.tier].take)
					return
				end
				AddRep(src, 'heroin')
				return
			end
		end
	else
		if not ps.craftItem(src, heroinRecipes['fillneedle']['tier1']) then
			verifyHas(src, heroinRecipes['fillneedle']['tier1'].take)
			return
		end
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
			local cuth = ps.hasItem(src, k)
			if cuth then
				ps.removeItem(src, k, v)
				ps.notify(src, ps.lang('Heroin.failneedle'), "error")
				return
			end
		end
	else
		ps.removeItem(src, 'heroinvial', 1)
	end
end)

AddEventHandler('playerDropped', function()
	local src = source
	for k, v in pairs(heroinLabKits) do
		if v.src == src then
			table.remove(heroinLabKits, k)
			ps.addItem(src, 'heroinlabkit', 1)
		end
	end

end)
