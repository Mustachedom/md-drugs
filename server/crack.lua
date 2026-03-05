if not Config.Drugs['crack'] then return end
RegisterServerEvent('md-drugs:server:makecrackone', function(num)
    local src = source

    if timeOut(src, 'md-drugs:server:makecrackone') then return end

    if not checkDistance(src, Config.Crack.Locations.makecrack[num].loc, 2.0, 'md-drugs:server:makecrackone') then
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
    if not craft(src, Config.Crack.Recipes.cookcrack[tier]) then
        return
    end
end)


RegisterServerEvent('md-drugs:server:bagcrack', function(num)
    local src = source

    if timeOut(src, 'md-drugs:server:bagcrack') then return end

    if not checkDistance(src, Config.Crack.Locations.bagcrack[num].loc, 2.0, 'md-drugs:server:bagcrack') then
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
    if not craft(src, Config.Crack.Recipes.bagcrack[tier]) then
        return
    end
end)

local cokecut = {
    crackrockstagetwo = {give = {crackrock = 2}, take = {crackrockstagetwo = 1, bakingsoda = 1}},
    crackrockstagethree = {  give = {crackrock = 3}, take = {crackrockstagethree = 1, bakingsoda = 1}},
}
for k, v in pairs (cokecut) do
	Bridge.Framework.RegisterUsableItem(k, function(source, item)
		local src = source
        local can = true
        for k, v in pairs (v.take) do
            local count = Bridge.Inventory.GetItemCount(src, k)
            if count < v then
                can = false
                break
            end
        end
        if not can then
            return craft(src, v)
        end
        local progress = Bridge.Callback.Trigger("md-drugs:client:uncuff", src, Bridge.Language.Locale('crack.breakdown'))
        if not progress then return end
        craft(src, v)
	end)
end

RegisterNetEvent("md-drugs:server:failcrackone", function(num)
    local src = source
    if not checkDistance(src, Config.Crack.Locations.makecrack[num].loc, 2.0, 'md-drugs:server:failcrackone') then
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