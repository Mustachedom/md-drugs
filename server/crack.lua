
RegisterServerEvent('md-drugs:server:makecrackone', function(num)
    local src = source
    local tier = 'tier1'
    if not ps.checkDistance(src, GlobalState.MDDrugsLocs.makecrack[num].loc, 2.0) then
        ps.notify(src, 'You are not in the correct location', 'error')
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
	if not GetRecipe(src, 'crack', 'cookcrack', tier) then return end
end)


RegisterServerEvent('md-drugs:server:bagcrack', function(num)
    local src = source
    local tier = 'tier1'
    if not ps.checkDistance(src, GlobalState.MDDrugsLocs.bagcrack[num].loc, 2.0) then
        ps.notify(src, 'You are not in the correct location', 'error')
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
	if not GetRecipe(src, 'crack', 'bagcrack', tier) then return end
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
    if not ps.checkDistance(src, GlobalState.MDDrugsLocs.makecrack[num].loc, 2.0) then
        ps.notify(src, 'You are not in the correct location', 'error')
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
            ps.notify(src, 'You failed to make crack and lost '..v..' '..k, 'error')
            return
        end
    end
end)