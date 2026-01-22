
local burners = {
    cokeburner = { "cokebaggy", "cokebaggystagethree", "cokebaggystagetwo"},
    crackburner = {"baggedcracked", "baggedcrackedstagetwo", "baggedcrackedstagethree"},
    lsdburner = {'smiley_tabs', 'yinyang_tabs', 'wildcherry_tabs', 'pineapple_tabs', 'bart_tabs', 'gratefuldead_tabs'},
    heroinburner = {'heroin_ready', 'heroin_readystagetwo', 'heroin_readystagethree'},
    xtcburner = {"white_playboys",  "white_playboys2",  "white_playboys3",  "white_playboys4", "blue_playboys",  "blue_playboys2",  "blue_playboys3",  "blue_playboys4",  "red_playboys",  "red_playboys2",  "red_playboys3",  "red_playboys4",  "orange_playboys",  "orange_playboy2s",  "orange_playboys3",  "orange_playboys4",  "white_aliens",  "white_aliens2",  "white_aliens3",  "white_aliens4",  "blue_aliens",  "blue_aliens2",  "blue_aliens3",  "blue_aliens4",  "red_aliens",  "red_aliens3",  "red_aliens2",  "red_aliens4",  "orange_aliens",  "orange_aliens2",  "orange_aliens3",  "orange_aliens4",  "white_pl",  "white_pl2",  "white_pl3",  "white_pl4", "blue_pl",  "blue_pl2",  "blue_pl3",  "blue_pl4",  "red_pl",  "red_pl2",  "red_pl3",  "red_pl4",  "orange_pl",  "orange_pl2",  "orange_pl3",  "orange_pl4",  "white_trolls",  "white_trolls2",  "white_trolls3",  "white_trolls4", "blue_trolls",  "blue_trolls2",  "blue_trolls3",  "blue_trolls4",  "red_trolls",  "red_trolls2",  "red_trolls3",  "red_trolls4",  "orange_trolls",  "orange_trolls2",  "orange_trolls3",  "orange_trolls4",  "white_cats2",  "white_cats3",  "white_cats4",  "white_cats", "blue_cats",  "blue_cats3",  "blue_cats2",  "blue_cats4",  "red_cats",  "red_cats2",  "red_cats3",  "red_cats4",  "orange_cats",  "orange_cats2",  "orange_cats3",  "orange_cats4" },
    methburner = {'methbaggy'},
}
local active = {}
local settings = {}

settings.WholesaleQuantityBonus = 0.05 -- 5% bonus per 10 units sold (up to 20%)
settings.WholesaleMaxBonus = 0.20 -- Maximum 20% bonus
settings.WholesaleMinQuantity = 5 -- Minimum quantity required for wholesale
settings.WholesaleAmbushEnabled = true -- Enable or disable ambush on failed deals
settings.WholesaleAmbushBase = 2 -- Base number of attackers on failed deals
settings.WholesaleAmbushScale = true -- Scale number of attackers based on drug quantity
settings.WholesaleAmbushTier1 = 10 -- Drug quantity threshold for 3 attackers
settings.WholesaleAmbushTier2 = 20 -- Drug quantity threshold for 4 attackers
settings.WholesaleAmbushTier3 = 30 -- Drug quantity threshold for 5 attackers
settings.FailChance = 20 -- Percentage chance of ambush occurring on a failed deal
settings.PoliceCount = 0 -- Minimum police required to initiate a wholesale deal
local Price = {
    cokeburner = {
        min = 25, 
        max = 50
    },
    crackburner = {
         min = 25, 
        max = 50
    },
    lsdburner = {
         min = 25, 
        max = 50
    },
    heroinburner = {
        min = 25, 
        max = 50
    },
    xtcburner = {
         min = 25, 
        max = 50
    },
    methburner = {
        min = 25, 
        max = 50
    }
}

settings.Locs = {
    vector4(-2352.32, 266.78, 165.3, 23.46),
    vector4(-1467.49, 874.01, 183.59, 298.45),
    vector4(-856.71, 874.26, 202.85, 205.3),
    vector4(950.58, -128.49, 74.42, 205.3),
    vector4(1152.71, -328.43, 69.21, 205.3),
	vector4(112.66, -1955.67, 20.75, 37.94),
	vector4(-544.4, -1684.8, 19.89, 252.07),
	vector4(-1185.02, -1805.4, 3.91, 184.83),
	vector4(-1641.4, -981.99, 7.58, 35.38),
	vector4(-1827.93, 782.36, 138.29, 219.99),
	vector4(-320.84, 2818.73, 59.45, 337.22),
	vector4(474.88, 2609.56, 44.48, 357.0),
}
Locations = Locations or {}


GlobalState.MDDrugsLocations.Wholesale = settings

for k, v in pairs (burners) do
    Bridge.Framework.RegisterUsableItem(k, function(source, item)
        local src = source
        if active[source] then
            TriggerClientEvent("md-drugs:client:MarkLocation", src, active[source].location)
            return
        end
        if #Bridge.Framework.GetPlayersByJob('police') < settings.PoliceCount then
            return Bridge.Notify.SendNotify(source, Bridge.Language.Locale('wholesale.not_enough_police'), 'error')
        end
        local itemCount, itemList = 0, {}
        for m, d in pairs (v) do
            local amt = Bridge.Inventory.GetItemCount(source, d) or 0
            if amt > 0 then
                itemCount = itemCount + amt
                itemList[d] = amt
            end
        end
        if itemCount < settings.WholesaleMinQuantity then
            return Bridge.Notify.SendNotify(source, Bridge.Language.Locale('wholesale.not_enough_drugs'), 'error')
        end

        if Bridge.Inventory.RemoveItem(src, k, 1) then
            active[src] = {
                count = itemCount,
                itemList = itemList,
                location =  settings.Locs[math.random(1, #settings.Locs)],
                price = math.random(Price[k].min, Price[k].max),
                drugType = k,
                ambush = math.random(1, 100) <= settings.FailChance and true or false,
            }
            if active[src].ambush and settings.WholesaleAmbushEnabled then
                active[src].attackerCount = settings.WholesaleAmbushBase
                if settings.WholesaleAmbushScale then
                    if active[src].count > settings.WholesaleAmbushTier1 then
                        active[src].attackerCount = active[src].attackerCount + 1
                    end
                    if active[src].count > settings.WholesaleAmbushTier2 then
                        active[src].attackerCount = active[src].attackerCount + 1
                    end
                    if active[src].count > settings.WholesaleAmbushTier3 then
                        active[src].attackerCount = active[src].attackerCount + 1
                    end
                end
            else
                active[src].attackerCount = 0
            end
            TriggerClientEvent("md-drugs:client:GetLocation", src, active[src])
        end
    end)
end

RegisterNetEvent('md-drugs:server:SuccessSale', function(entity)
    local src = source
    if not active[src] then
        return
    end
    if active[src].ambush then
       Bridge.Prints.Warn(Bridge.Language.Locale('wholesale.ambush_fail_warn', Bridge.Framework.GetPlayerIdentifier(src)))
        return
    end
    if not checkDistance(src, active[src].location, 5.0, 'md-drugs:server:SuccessSale') then
        return
    end
    local basePrice = active[src].price * active[src].count
    local bonusMultiplier = math.min(math.floor(active[src].count / 10) * settings.WholesaleQuantityBonus, settings.WholesaleMaxBonus)
    local totalPrice = math.floor(basePrice * (1 + bonusMultiplier))
    for k, v in pairs (active[src].itemList) do
        local has = Bridge.Inventory.GetItemCount(src, k) or 0
        if has < v then
            return
        end
    end
    for k, v in pairs (active[src].itemList) do
        if not Bridge.Inventory.RemoveItem(src, k, v) then
            return
        end
    end
    Bridge.Framework.AddAccountBalance(src, 'cash', totalPrice)
end)

RegisterNetEvent('md-drugs:server:CleanupWholesale', function()
    local src = source
    if active[src] then
        active[src] = nil
    end
end)

RegisterNetEvent('md-drugs:server:getkilledFuckingNoob', function()
    local src = source
    if not active[src] then
        return
    end
    for k, v in pairs (active[src].itemList) do
        local has = Bridge.Inventory.GetItemCount(src, k) or 0
        if has > 0 then
            Bridge.Inventory.RemoveItem(src, k, has)
        end
    end
    active[src] = nil
end)