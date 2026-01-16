Recipes, Locations = Recipes or {}, Locations or {}

Recipes.Crack = {
    cookcrack = {
        tier1 = {take = {loosecoke = 1,          bakingsoda = 1}, give = {crackrock = 1}},
        tier2 = {take = {loosecokestagetwo = 1,  bakingsoda = 1}, give = {crackrockstagetwo = 1}},
        tier3 = {take = {loosecokestagethree = 1,bakingsoda = 1}, give = {crackrockstagethree = 1}},
    },
    bagcrack = {
        tier1 = {take = {crackrock = 1,           empty_weed_bag = 1}, give = {baggedcracked = 1}},
        tier2 = {take = {crackrockstagetwo = 1,   empty_weed_bag = 1}, give = {baggedcrackedstagetwo = 1}},
        tier3 = {take = {crackrockstagethree = 1, empty_weed_bag = 1}, give = {baggedcrackedstagethree = 1}},
    }
}
GlobalState.MDDrugsRecipes = Recipes

Locations.Crack = {
    makecrack = { -- make crack with baking soda with cut coke 1-3
        {loc = vector3(2433.47, 4970.02, 42.18), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    bagcrack = {  ---  bag crack 1-3 stages
        {loc = vector3(2436.55, 4964.96, 42.18), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
}
GlobalState.MDDrugsLocations = Locations

RegisterServerEvent('md-drugs:server:makecrackone', function(num)
    local src = source

    if timeOut(src, 'md-drugs:server:makecrackone') then return end

    if not checkDistance(src, Locations.Crack.makecrack[num].loc, 2.0) then
        Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
        return
    end
    local tier = 'tier1'
    if Config.TierSystem then
        local crackTiers = {
            {item = 'loosecoke', 		 tier = 'tier1'},
            {item = 'loosecokestagetwo', tier = 'tier2'},
            {item = 'loosecokestagethree', tier = 'tier3'}
        }
        for _, v in ipairs(crackTiers) do
            if Bridge.Inventory.HasItem(src, v.item) then
                tier = v.tier
                break
            end
        end
    end
    if not craft(src, Recipes.Crack.cookcrack[tier]) then
        return
    end
end)


RegisterServerEvent('md-drugs:server:bagcrack', function(num)
    local src = source

    if timeOut(src, 'md-drugs:server:bagcrack') then return end

    if not checkDistance(src, Locations.Crack.bagcrack[num].loc, 2.0) then
        Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
        return
    end

    local tier = 'tier1'
    if Config.TierSystem then
        local crackTiers = {
            {item = 'crackrock',           tier = 'tier1'},
            {item = 'crackrockstagetwo',   tier = 'tier2'},
            {item = 'crackrockstagethree', tier = 'tier3'}
        }
        for _, v in ipairs(crackTiers) do
            if Bridge.Inventory.HasItem(src, v.item) then
                tier = v.tier
                break
            end
        end
    end
    if not craft(src, Recipes.Crack.bagcrack[tier]) then
        return
    end
end)

local cokecut = {crackrockstagetwo = 2, crackrockstagethree = 3}
for k, v in pairs (cokecut) do
	Bridge.Framework.RegisterUsableItem(k, function(source, item)
		local src = source
        if not Bridge.Inventory.HasItem(src, 'bakingsoda') then
            Bridge.Notify.SendNotify(src, Bridge.Language.Locale('coke.needBakingSoda'), 'error')
            return
        end
		if Bridge.Inventory.HasItem(src,item.name) then
            local check = ps.callback('md-drugs:client:uncuff', src, 'Cutting It Further')
            if not check then return end
		    if Bridge.Inventory.RemoveItem(src, k, 1) and Bridge.Inventory.RemoveItem(src, 'bakingsoda', 1) then
               Bridge.Inventory.AddItem(src, 'crackrock', v)
            end
		end
	end)
end

RegisterNetEvent("md-drugs:server:failcrackone", function(num)
    local src = source
    if not checkDistance(src, Locations.Crack.makecrack[num].loc, 2.0) then
        Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
        return
    end
    local items = {
        'loosecoke',
        'loosecokestagetwo',
        'loosecokestagethree',
    }
    for k,v in pairs(items) do
        if Bridge.Inventory.HasItem(src, v) then
            Bridge.Inventory.RemoveItem(src, v, 1)
            return
        end
    end
end)