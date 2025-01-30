
RegisterServerEvent('md-drugs:server:makecrackone', function(num)
    local src = source
    local type, tier ='cookcrack', 'tier1'
	if not checkLoc(src, 'makecrack', num) then return end
    if Config.TierSystem then
        local crackTiers = {
            {item = 'loosecoke', 		 tier = 'tier1', log = ' Cut Crack'},
            {item = 'loosecokestagetwo', tier = 'tier2', log = ' Cut Crack tier 2'},
            {item = 'loosecokestagethree', tier = 'tier3', log = ' Cut Crack tier 3'}
        }
        for _, v in ipairs(crackTiers) do
            if hasItem(src, v.item, 1) then
				tier = v.tier
                break
            end
        end
    end
	if not GetRecipe(src, 'crack', type, tier) then return end
end)


RegisterServerEvent('md-drugs:server:bagcrack', function(num)
    local src = source
    local type, tier = 'bagcrack', 'tier1'
    if not checkLoc(src, 'bagcrack', num) then return end
    if Config.TierSystem then
        local crackTiers = {
            {item = 'crackrock', tier = 'tier1', log = ' Bagged Crack'},
            {item = 'crackrockstagetwo', tier = 'tier2', log = ' Bagged Crack tier 2'},
            {item = 'crackrockstagethree', tier = 'tier3', log = ' Bagged Crack tier 3'}
        }
        for _, v in ipairs(crackTiers) do
            if hasItem(src, v.item, 1) then
				tier = v.tier
				break
            end
        end
    end
	if not GetRecipe(src, 'crack', type, tier) then return end
end)

local cokecut = {crackrockstagetwo = 2, crackrockstagethree = 3}
for k, v in pairs (cokecut) do
	CUI(k, function(source, item)
		local src = source
		if hasItem(src, k, 1) then
			if not Itemcheck(src, 'bakingsoda', 1) then return end
            local check = lib.callback.await('md-drugs:client:uncuff', src, 'Cutting Crack Rock Further')
            if not check then return end
            if RemoveItem(src, k, 1) and RemoveItem(src, 'bakingsoda', 1) then
                AddItem(src, 'crackrock', v)
            end
		end
	end)
end
