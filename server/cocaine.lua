local QBCore = exports['qb-core']:GetCoreObject()
local cokeplants = {
    { location = vector3(1474.25, -2643.87, 42.88),    heading = 334.49,     model = "prop_plant_01a" },
    { location = vector3(1472.35, -2649.3, 41.87),     heading = 329.56,     model = "prop_plant_01a" }, 
    { location = vector3(1475.7, -2652.9, 40.8),       heading = 25.16,      model = "prop_plant_01a" }, 
    { location = vector3(1481.0, -2654.99, 39.86),     heading = 21.52,      model = "prop_plant_01a" }, 
    { location = vector3(1480.9, -2660.63, 38.68),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(1477.18, -2666.53, 38.19),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(1477.58, -2670.82, 37.73),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(1476.56, -2675.82, 37.46),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(1474.8, -2680.19, 37.03),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(1471.52, -2685.0, 36.82),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(1462.82, -2676.58, 38.83),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(1461.31, -2667.74, 39.67),    heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(1456.3, -2647.61, 43.39),     heading = 202.97,     model = "prop_plant_01a" },
    { location = vector3(1453.65, -2641.56, 45.0),     heading = 202.97,     model = "prop_plant_01a" },
}

GlobalState.CocaPlant = cokeplants

Citizen.CreateThread(function()
    for _, v in pairs(cokeplants) do
        v.taken = false
    end
end)

function CaneCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        cokeplants[loc].taken = false
        GlobalState.CocaPlant = cokeplants
        Wait(1000)
        TriggerClientEvent('coke:respawnCane', -1, loc)
		Log('Coca Plant Respawned At ' .. cokeplants[loc].location, 'coke')
    end)
end

RegisterNetEvent("coke:pickupCane")
AddEventHandler("coke:pickupCane", function(loc)
	local src = source
	if CheckDist(src, cokeplants[loc].location) then return end
    if not cokeplants[loc].taken then
        cokeplants[loc].taken = true
        GlobalState.CocaPlant = cokeplants
        TriggerClientEvent("coke:removeCane", -1, loc)
        CaneCooldown(loc)
        AddItem(src, 'coca_leaf', 1)
    end
end)

RegisterServerEvent('md-drugs:server:makepowder', function(num)
    local src = source
    if not checkLoc(src, 'MakePowder', num) then return end
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
    local Player = getPlayer(src)
	local count = 0
    if Config.FancyCokeAnims then
        if not checkLoc(src, 'singleSpot', 'cutcoke') then return end
    else
        if not checkLoc(src, 'CuttingCoke', num) then return end
    end
    if Config.TierSystem then
        local tier = ''
        local cokeTiers = {
            {item = 'coke', 		  tier = 'tier1', log = ' Cut Coke'},
            {item = 'cokestagetwo',   tier = 'tier2', log = ' Cut Coke tier 2'},
            {item = 'cokestagethree', tier = 'tier3', log = ' Cut Coke tier 3'}
        }
        for _, v in ipairs(cokeTiers) do
			if count >= 1 then break end
            if Player.Functions.GetItemByName(v.item) then
                tier = v.tier
                count = count + 1
            end
        end
        if not GetRecipe(src, 'cocaine', 'cutcoke', tier) then return end
    else
        if not GetRecipe(src, 'cocaine', 'cutcoke', 'tier1') then return end
    end
end)

RegisterServerEvent('md-drugs:server:bagcoke', function(num)
    local src = source
    local Player = getPlayer(src)
	local count = 0
    local tier = ''
    if Config.FancyCokeAnims then
        if not checkLoc(src, 'singleSpot', 'bagcokepowder') then return end
    else
        if not checkLoc(src, 'BaggingCoke', num) then return end
    end
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
                count = count + 1
                tier = v.tier 
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
	QBCore.Functions.CreateUseableItem(k, function(source, item)
		local src = source
		local Player = getPlayer(src)
		 if Player.Functions.GetItemByName(item.name) then
		    if not Itemcheck(src, 'bakingsoda', 1) then return end
             local check = lib.callback.await('md-drugs:client:uncuff', src, 'Cutting It Further')
             if not check then return end
		    if RemoveItem(src, k, 1) then
                 AddItem(src, 'loosecoke', v)
             end
		 end
	end)
end