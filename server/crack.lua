local crackRecipe = {
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

local CrackLocations = {
    makecrack = { -- make crack with baking soda with cut coke 1-3
        {loc = vector3(2433.47, 4970.02, 42.18), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    bagcrack = {  ---  bag crack 1-3 stages
        {loc = vector3(2436.55, 4964.96, 42.18), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
}


ps.registerCallback('md-drugs:server:GetCrackLocations', function()
    return CrackLocations
end)

RegisterServerEvent('md-drugs:server:makecrackone', function(num)
    local src = source
    local tier = 'tier1'
    if timeOut(src, 'md-drugs:server:makecrackone') then return end
    if not ps.checkDistance(src, CrackLocations.makecrack[num].loc, 2.0) then
        ps.notify(src, ps.lang('Catches.notIn'), 'error')
        return
    end

    if Config.TierSystem then
        local crackTiers = {
            {item = 'loosecoke', 		 tier = 'tier1'},
            {item = 'loosecokestagetwo', tier = 'tier2'},
            {item = 'loosecokestagethree', tier = 'tier3'}
        }
        for _, v in ipairs(crackTiers) do
            if ps.hasItem(src, v.item) then
                tier = v.tier
                break
            end
        end
    end
    if not ps.craftItem(src, crackRecipe['cookcrack'][tier]) then
        verifyHas(src, crackRecipe['cookcrack'][tier].take)
        return
    end
end)


RegisterServerEvent('md-drugs:server:bagcrack', function(num)
    local src = source
    local tier = 'tier1'
    if timeOut(src, 'md-drugs:server:bagcrack') then return end
    if not ps.checkDistance(src, CrackLocations.bagcrack[num].loc, 2.0) then
        ps.notify(src, ps.lang('Catches.notIn'), 'error')
        return
    end
    if Config.TierSystem then
        local crackTiers = {
            {item = 'crackrock', tier = 'tier1'},
            {item = 'crackrockstagetwo', tier = 'tier2'},
            {item = 'crackrockstagethree', tier = 'tier3'}
        }
        for _, v in ipairs(crackTiers) do
            if ps.hasItem(src, v.item) then
                tier = v.tier
                break
            end
        end
    end
    if not ps.craftItem(src, crackRecipe['bagcrack'][tier]) then
        verifyHas(src, crackRecipe['bagcrack'][tier].take)
        return
    end
end)

local cokecut = {crackrockstagetwo = 2, crackrockstagethree = 3}
for k, v in pairs (cokecut) do
	ps.createUseable(k, function(source, item)
		local src = source
		if ps.hasItem(src, item.name) then
			if not ps.hasItem(src, 'bakingsoda', 1) then return end
            local check = ps.callback('md-drugs:client:uncuff', src, 'Cutting Crack Rock Further')
            if not check then return end
            if ps.removeItem(src, k, 1) and ps.removeItem(src, 'bakingsoda', 1) then
                ps.addItem(src, 'crackrock', v)
            end
		end
	end)
end

RegisterNetEvent("md-drugs:server:failcrackone", function(num)
    local src = source
    if not ps.checkDistance(src, CrackLocations.makecrack[num].loc, 2.0) then
        ps.notify(src, ps.lang('Catches.notIn'), 'error')
        return
    end
    local items = {
        loosecoke = 1,
        loosecokestagetwo = 1,
        loosecokestagethree = 1
    }
    for k,v in pairs(items) do
        if ps.hasItem(src, k, v) then
            ps.removeItem(src, k, v)
            return
        end
    end
end)