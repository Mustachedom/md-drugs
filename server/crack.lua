local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:makecrackone', function(num)
    local src = source
    local Player = getPlayer(src)
    local count,type, tier = 0, 'cookcrack', 'tier1'
	if not checkLoc(src, 'makecrack', num) then return end
    if Config.TierSystem then
        local crackTiers = {
            {item = 'loosecoke', 		 tier = 'tier1', log = ' Cut Crack'},
            {item = 'loosecokestagetwo', tier = 'tier2', log = ' Cut Crack tier 2'},
            {item = 'loosecokestagethree', tier = 'tier3', log = ' Cut Crack tier 3'}
        }
        for _, v in ipairs(crackTiers) do
            if count >= 1 then break end
            print(v.item)
            if Player.Functions.GetItemByName(v.item) then
				tier = v.tier
				count = count + 1
                Log(GetName(src) .. v.log, 'crack')
            end
        end
    end
    print(tier)
	if not GetRecipe(src, 'crack', type, tier) then return end
end)


RegisterServerEvent('md-drugs:server:bagcrack', function(num)
    local src = source
    local Player = getPlayer(src)
    local count,type, tier = 0, 'bagcrack', 'tier1'
    if not checkLoc(src, 'bagcrack', num) then return end
    if Config.TierSystem then
        local crackTiers = {
            {item = 'crackrock', tier = 'tier1', log = ' Bagged Crack'},
            {item = 'crackrockstagetwo', tier = 'tier2', log = ' Bagged Crack tier 2'},
            {item = 'crackrockstagethree', tier = 'tier3', log = ' Bagged Crack tier 3'}
        }
        for _, v in ipairs(crackTiers) do
            if count >= 1 then break end
            if Player.Functions.GetItemByName(v.item) then
				tier = v.tier
				count = count + 1
                Log(GetName(src) .. v.log, 'crack') 
            end
        end
    end
	if not GetRecipe(src, 'crack', type, tier) then return end
end)

local cokecut = {crackrockstagetwo = 2, crackrockstagethree = 3}
for k, v in pairs (cokecut) do
	QBCore.Functions.CreateUseableItem(k, function(source, item)
		local src = source
		local Player = getPlayer(src)
		if Player.Functions.GetItemByName(item.name) then
			if not Itemcheck(src, 'bakingsoda', 1) then return end
			TriggerClientEvent('md-drugs:client:minusTier', src, {type = 'crack', xt = 'bakingsoda', item = k, amount =  v,recieve = 'crackrock'})
		end
	end)
end
