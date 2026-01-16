Recipes = Recipes or {}
Locations = Locations or {}

Recipes.Cocaine = {
   cokepowder = {
        tier1 = {take = {coca_leaf = 1}, give = {coke = 1}},
        tier2 = {take = {coca_leaf = 1}, give = {cokestagetwo = 1}},
        tier3 = {take = {coca_leaf = 1}, give = {cokestagethree = 1}},
   },
   cutcoke = {
        tier1 = {take = {coke = 1,           bakingsoda = 1}, give = {loosecoke = 1}},
        tier2 = {take = {cokestagetwo = 1,   bakingsoda = 1}, give = {loosecokestagetwo = 1}},
        tier3 = {take = {cokestagethree = 1, bakingsoda = 1}, give = {loosecokestagethree = 1}},
   },
   bagcoke = {
        tier1 = {take = {loosecoke = 1,             empty_weed_bag = 1}, give = {cokebaggy = 1}},
        tier2 = {take = {loosecokestagetwo = 1,     empty_weed_bag = 1}, give = {cokebaggystagetwo = 1}},
        tier3 = {take = {loosecokestagethree = 1,   empty_weed_bag = 1}, give = {cokebaggystagethree = 1}},
   }
}
GlobalState.MDDrugsRecipes = Recipes

Locations.Cocaine = {
    MakePowder = {
        {loc = vector3(1086.20, -3195.30, -39.20), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    CuttingCoke = {
        {loc = vector3(1095.61, -3195.62, -39.13), l = 1.0, w = 1.0, rot = 45.0, offset = vec3(-1.782227, 0.445068, -0.502701), rotation = vector3(0,0,0), gang = ""},
    },
    BaggingCoke = {
        {loc = vector3(1093.16, -3195.78, -39.19), l = 1.0, w = 1.0, rot = 45.0,offset = vec3(4.515137, 2.542969, -0.814194), rotation = vector3(0,0,180.0), gang = ""},
    },
    cokeTele = {
        {inside = vector3(1088.81, -3187.57, -38.99), outside = vector3(198.16, -1276.92, 29.33), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    }
}
GlobalState.MDDrugsLocations = Locations

local function getTier(source)
    if not Config.TierSystem then
        return 'tier1'
    end
    local rep = tonumber(getRep(source, 'coke'))
    if not rep then
        return
    end
    if rep < Config.Tier1 then
        return 'tier1'
    end
    if rep >= Config.Tier1 and rep <= Config.Tier2 then
        return 'tier2'
    end
    if rep >= Config.Tier2 then
        return 'tier3'
    end
    return nil
end

RegisterServerEvent('md-drugs:server:makepowder', function(num)
    local src = source

    if timeOut(src, 'md-drugs:server:makepowder') then return end

    if not checkDistance(src, Locations.Cocaine.MakePowder[num].loc, 3.5) then
        Bridge.Prints.Warm(Bridge.Language.Locale('Catches.notIn', ps.getPlayerName(src)), 'md-drugs:server:makepowder')
        return
    end

    local tier = getTier(src)
    if not tier then
        return
    end

    if not craft(src, Recipes.Cocaine.cokepowder[tier]) then
        return
    end
end)

RegisterServerEvent('md-drugs:server:cutcokeone', function(num)
    local src = source

    if timeOut(src, 'md-drugs:server:cutcokeone') then return end

    if not checkDistance(src, Locations.Cocaine.CuttingCoke[num].loc, 2.5) then
        Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
        return
    end
    local tier = 'tier1'
    local itemCheck = {
        {check = Bridge.Inventory.HasItem(src,'loosecoke'),              tier = 'tier1'},
        {check = Bridge.Inventory.HasItem(src, 'loosecokestagetwo'),     tier = 'tier2'},
        {check = Bridge.Inventory.HasItem(src, 'loosecokestagethree'),   tier = 'tier3'},
    }
    for i = 1, #itemCheck do
        if itemCheck[i].check then
            tier = itemCheck[i].tier
            break
        end
    end
    if not craft(src, Recipes.Cocaine.cutcoke[tier]) then
        return
    end
end)

RegisterServerEvent('md-drugs:server:bagcoke', function(num)
    local src = source

    if timeOut(src, 'md-drugs:server:bagcoke') then return end

    if not checkDistance(src, Locations.Cocaine.BaggingCoke[num].loc, 2.5) then
        Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), 'error')
        return
    end
    local tier = 'tier1'
    local itemCheck = {
        {check = Bridge.Inventory.HasItem(src,'coke'),              tier = 'tier1'},
        {check = Bridge.Inventory.HasItem(src, 'cokestagetwo'),     tier = 'tier2'},
        {check = Bridge.Inventory.HasItem(src, 'cokestagethree'),   tier = 'tier3'},
    }
    for i = 1, #itemCheck do
        if itemCheck[i].check then
            tier = itemCheck[i].tier
            break
        end
    end
    if not craft(src, Recipes.Cocaine.bagcoke[tier]) then
        return
    end
    AddRep(src, 'coke', 1)
end)

local cokecut = {loosecokestagetwo = 2, loosecokestagethree = 3}
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
               Bridge.Inventory.AddItem(src, 'loosecoke', v)
            end
		end
	end)
end