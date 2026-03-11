if not Config.Drugs['cocaine'] then return end
local Locations = Config.Cocaine.Locations
local Recipes = Config.Cocaine.Recipes

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

    if not checkDistance(src, Locations.MakePowder[num].loc, 3.5, 'md-drugs:server:makepowder') then
        return
    end

    local tier = getTier(src)
    if not tier then
        return
    end

    if not craft(src, Recipes.cokepowder[tier]) then
        return
    end
end)

RegisterServerEvent('md-drugs:server:cutcokeone', function(num)
    local src = source

    if timeOut(src, 'md-drugs:server:cutcokeone') then return end

    if not checkDistance(src, Locations.CuttingCoke[num].loc, 2.5, 'md-drugs:server:cutcokeone') then
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
    if not craft(src, Recipes.cutcoke[tier]) then
        return
    end
end)

RegisterServerEvent('md-drugs:server:bagcoke', function(num)
    local src = source

    if timeOut(src, 'md-drugs:server:bagcoke') then return end

    if not checkDistance(src, Locations.BaggingCoke[num].loc, 2.5, 'md-drugs:server:bagcoke') then
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
    if not craft(src, Recipes.bagcoke[tier]) then
        return
    end
    AddRep(src, 'coke', 1)
end)

local cokecut = {
    loosecokestagetwo = {give = {loosecoke =2}, take = {loosecokestagetwo = 1, bakingsoda = 1}},
    loosecokestagethree = {give = {loosecokestagetwo = 3}, take = {loosecokestagethree = 1, bakingsoda = 1}},
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
        local progress = Bridge.Callback.Trigger("md-drugs:client:uncuff", src, Bridge.Language.Locale('coke.cutCokeAgain'))
        if not progress then return end
        craft(src, v)
	end)
end