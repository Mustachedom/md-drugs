
RegisterServerEvent('md-drugs:server:makepowder', function(num)
    local src = source
    if not ps.checkDistance(src, GlobalState.MDDrugsLocs.MakePowder[num].loc, 3.5) then
        ps.notify(src, 'You are not in the correct location', 'error')
        return
    end
    local tier = 'tier1'
    if Config.TierSystem then
        local coke = getRep(src, 'coke')
        if coke > Config.Tier1 and coke <= Config.Tier2 then
            tier = 'tier2'
        elseif coke > Config.Tier2 then
            tier = 'tier3'
        end
    end
    if not GetRecipe(src, 'cocaine', 'cokepowder', tier) then return end
end)

RegisterServerEvent('md-drugs:server:cutcokeone', function(num)
    local src = source
    local tier = 'tier1'
    if not ps.checkDistance(src, GlobalState.MDDrugsLocs.CuttingCoke[num].loc, 2.5) then
        ps.notify(src, 'You are not in the correct location', 'error')
        return
    end
    if Config.TierSystem then
        local cokeTiers = {
            {item = 'coke', 		  tier = 'tier1', log = ' Cut Coke'},
            {item = 'cokestagetwo',   tier = 'tier2', log = ' Cut Coke tier 2'},
            {item = 'cokestagethree', tier = 'tier3', log = ' Cut Coke tier 3'}
        }
        for _, v in ipairs(cokeTiers) do
            if ps.hasItem(src, v.item) then
                tier = v.tier
                break
            end
        end
    end
    if not GetRecipe(src, 'cocaine', 'cutcoke', tier) then return end
end)

RegisterServerEvent('md-drugs:server:bagcoke', function(num)
    local src = source
    local tier = 'tier1'
    if not ps.checkDistance(src, GlobalState.MDDrugsLocs.BaggingCoke[num].loc, 2.5) then
        ps.notify(src, 'You are not in the correct location', 'error')
        return
    end
    if Config.TierSystem then
        local cokeTiers = {
            {item = 'loosecoke', 		   tier = 'tier1', log = ' Bagged Coke'},
            {item = 'loosecokestagetwo',   tier = 'tier2', log = ' Bagged Coke tier 2'},
            {item = 'loosecokestagethree', tier = 'tier3', log = ' Bagged Coke tier 3'}
        }
        for _, v in ipairs(cokeTiers) do
            if ps.hasItem(src, v.item) then
                tier = v.tier
                break
            end
        end
        if not GetRecipe(src, 'cocaine', 'bagcoke', tier) then return end
        AddRep(src, 'coke')
    else
        if not GetRecipe(src, 'cocaine', 'bagcoke', 'tier1') then return end
    end
end)

local cokecut = {loosecokestagetwo = 2, loosecokestagethree = 3}
for k, v in pairs (cokecut) do
	ps.createUseable(k, function(source, item)
		local src = source
        if not ps.hasItem(src, 'bakingsoda') then ps.notify(src, 'You Need Baking Soda For this', 'error') return end
		 if ps.hasItem(src,item.name) then
              local check = ps.callback('md-drugs:client:uncuff', src, 'Cutting It Further')
             if not check then return end
		     if ps.removeItem(src, k, 1) and ps.removeItem(src, 'bakingsoda', 1) then
                 ps.addItem(src, 'loosecoke', v)
             end
		 end
	end)
end
