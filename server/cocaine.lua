local QBCore = exports['qb-core']:GetCoreObject()

GlobalState.CocaPlant = Config.CocaPlant

Citizen.CreateThread(function()
    for _, v in pairs(Config.CocaPlant) do
        v.taken = false
    end
end)

function CaneCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        Config.CocaPlant[loc].taken = false
        GlobalState.CocaPlant = Config.CocaPlant
        Wait(1000)
        TriggerClientEvent('coke:respawnCane', -1, loc)
		Log('Coca Plant Respawned At ' .. Config.CocaPlant[loc].location, 'coke')
    end)
end

RegisterNetEvent("coke:pickupCane")
AddEventHandler("coke:pickupCane", function(loc)
	local src = source
	if CheckDist(src, Config.CocaPlant[loc].location) then return end
    if not Config.CocaPlant[loc].taken then
        Config.CocaPlant[loc].taken = true
        GlobalState.CocaPlant = Config.CocaPlant
        TriggerClientEvent("coke:removeCane", -1, loc)
        CaneCooldown(loc)
        AddItem(src, 'coca_leaf', 1)
		Log(GetName(src) .. ' Picked A Coca Leaf With a distance of ' .. dist(src, Config.CocaPlant[loc].location) .. ' vectors', 'coke')
    end
end)

RegisterServerEvent('md-drugs:server:makepowder', function(num)
    local src = source
    if CheckDist(src, Config.MakePowder[num]['loc']) then return end
    local tier = 'tier1'
    local logMessage = ' Made Raw Coke'
    if Config.TierSystem then
        local coke = getRep(src, 'coke')
        if coke > Config.Tier1 and coke <= Config.Tier2 then
            tier = 'tier2'
            logMessage = ' Made Raw Coke tier 2'
        elseif coke > Config.Tier2 then
            tier = 'tier3'
            logMessage = ' Made Raw Coke tier 3'
        end
    end
    if not GetRecipe(src, 'cocaine', 'cokepowder', tier) then return end
    Log(GetName(src) .. logMessage .. dist(src, Config.MakePowder[num]['loc']) .. ' vectors', 'coke')
end)

RegisterServerEvent('md-drugs:server:cutcokeone', function()
    local src = source
    local Player = getPlayer(src)
	local count = 0
    if Config.TierSystem then
        local cokeTiers = {
            {item = 'coke', 		  tier = 'tier1', log = ' Cut Coke'},
            {item = 'cokestagetwo',   tier = 'tier2', log = ' Cut Coke tier 2'},
            {item = 'cokestagethree', tier = 'tier3', log = ' Cut Coke tier 3'}
        }
        for _, v in ipairs(cokeTiers) do
			if count >= 1 then break end
            if Player.Functions.GetItemByName(v.item) then
                if not GetRecipe(src, 'cocaine', 'cutcoke', v.tier) then return end
                	Log(GetName(src) .. v.log, 'coke')
                return
            end
        end
        Notifys(src, Lang.Coke.nocutcoke, "error")
    else
        if not GetRecipe(src, 'cocaine', 'cutcoke', 'tier1') then return end
        Log(GetName(src) .. ' Cut Coke', 'coke')
    end
end)

RegisterServerEvent('md-drugs:server:bagcoke', function()
    local src = source
    local Player = getPlayer(src)
	local count = 0
    if Config.TierSystem then
        local coke = getRep(src, 'coke')
        local cokeTiers = {
            {item = 'loosecoke', 		   tier = 'tier1', log = ' Bagged Coke'},
            {item = 'loosecokestagetwo',   tier = 'tier2', log = ' Bagged Coke tier 2'},
            {item = 'loosecokestagethree', tier = 'tier3', log = ' Bagged Coke tier 3'}
        }
        for _, v in ipairs(cokeTiers) do
            if Player.Functions.GetItemByName(v.item) then
				if count >= 1 then break end
                if not GetRecipe(src, 'cocaine', 'bagcoke', v.tier) then return end
                AddRep(src, 'coke')
                Log(GetName(src) .. v.log .. ' and now has a rep of ' .. coke + 1, 'coke')
                return
            end
        end
        Notifys(src, Lang.Coke.nobagcoke, "error")
    else
        if not GetRecipe(src, 'cocaine', 'bagcoke', 'tier1') then return end
        Log(GetName(src) .. ' Bagged Coke', 'coke')
    end
end)

local cokecut = {loosecokestagetwo = 2, loosecokestagethree = 3}
for k, v in pairs (cokecut) do
	QBCore.Functions.CreateUseableItem(k, function(source, item)
		local src = source
		   local Player = getPlayer(src)
		if Player.Functions.GetItemByName(item.name) then
			if not Itemcheck(src, 'bakingsoda', 1) then return end
			TriggerClientEvent('md-drugs:client:minusTier', src, {type = 'coke', xt = 'bakingsoda', item = k, amount =  v,recieve = 'loosecoke'})
		end
	end)
end