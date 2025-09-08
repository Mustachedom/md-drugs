local coke = { "cokebaggy", "cokebaggystagethree", "cokebaggystagetwo"}
local crack = {"baggedcracked", "baggedcrackedstagetwo", "baggedcrackedstagethree"}
local lsd = {'smiley_tabs', 'yinyang_tabs', 'wildcherry_tabs', 'pineapple_tabs', 'bart_tabs', 'gratefuldead_tabs'}
local heroin = {'heroin_ready', 'heroin_readystagetwo', 'heroin_readystagethree'}
local xtc = {"white_playboys",  "white_playboys2",  "white_playboys3",  "white_playboys4", "blue_playboys",  "blue_playboys2",  "blue_playboys3",  "blue_playboys4",  "red_playboys",  "red_playboys2",  "red_playboys3",  "red_playboys4",  "orange_playboys",  "orange_playboy2s",  "orange_playboys3",  "orange_playboys4",  "white_aliens",  "white_aliens2",  "white_aliens3",  "white_aliens4",  "blue_aliens",  "blue_aliens2",  "blue_aliens3",  "blue_aliens4",  "red_aliens",  "red_aliens3",  "red_aliens2",  "red_aliens4",  "orange_aliens",  "orange_aliens2",  "orange_aliens3",  "orange_aliens4",  "white_pl",  "white_pl2",  "white_pl3",  "white_pl4", "blue_pl",  "blue_pl2",  "blue_pl3",  "blue_pl4",  "red_pl",  "red_pl2",  "red_pl3",  "red_pl4",  "orange_pl",  "orange_pl2",  "orange_pl3",  "orange_pl4",  "white_trolls",  "white_trolls2",  "white_trolls3",  "white_trolls4", "blue_trolls",  "blue_trolls2",  "blue_trolls3",  "blue_trolls4",  "red_trolls",  "red_trolls2",  "red_trolls3",  "red_trolls4",  "orange_trolls",  "orange_trolls2",  "orange_trolls3",  "orange_trolls4",  "white_cats2",  "white_cats3",  "white_cats4",  "white_cats", "blue_cats",  "blue_cats3",  "blue_cats2",  "blue_cats4",  "red_cats",  "red_cats2",  "red_cats3",  "red_cats4",  "orange_cats",  "orange_cats2",  "orange_cats3",  "orange_cats4" }
local burners = {cokeburner = coke, crackburner = crack, lsdburner = lsd, heroinburner = heroin, xtcburner = xtc}
local active = {}
local settings = {}
settings.WholesaleQuantityBonus = 0.05 -- 5% bonus per 10 units sold (up to 20%)
settings.WholesaleMaxBonus = 0.20 -- Maximum 20% bonus
settings.WholesaleMinQuantity = 1 -- Minimum quantity required for wholesale
settings.WholesaleAmbushEnabled = true -- Enable or disable ambush on failed deals
settings.WholesaleAmbushBase = 2 -- Base number of attackers on failed deals
settings.WholesaleAmbushScale = true -- Scale number of attackers based on drug quantity
settings.WholesaleAmbushTier1 = 10 -- Drug quantity threshold for 3 attackers
settings.WholesaleAmbushTier2 = 20 -- Drug quantity threshold for 4 attackers
settings.WholesaleAmbushTier3 = 30 -- Drug quantity threshold for 5 attackers
settings.WholesaleWeaponTiers = true -- Scale weapon difficulty based on drug quantity
settings.WholesaleWeaponsTier1 = { -- Basic weapons (default)
    "WEAPON_PISTOL", 
    "WEAPON_BAT", 
    "WEAPON_KNIFE", 
    "WEAPON_MACHETE"
}
settings.WholesaleWeaponsTier2 = { -- Medium weapons (10+ drugs)
    "WEAPON_COMBATPISTOL", 
    "WEAPON_MICROSMG", 
    "WEAPON_SAWNOFFSHOTGUN", 
    "WEAPON_CROWBAR"
}
settings.WholesaleWeaponsTier3 = { -- Advanced weapons (20+ drugs)
    "WEAPON_APPISTOL", 
    "WEAPON_SMG", 
    "WEAPON_PUMPSHOTGUN", 
    "WEAPON_CARBINERIFLE"
}
settings.WholesaleWeaponsTier4 = { -- Elite weapons (30+ drugs)
    "WEAPON_HEAVYPISTOL", 
    "WEAPON_ASSAULTSMG", 
    "WEAPON_ASSAULTSHOTGUN", 
    "WEAPON_SPECIALCARBINE"
}
settings.WholesaleShowEstimates = true -- Show estimated value before deal
settings.WholesaleFailPoliceAlert = 75 -- Chance to alert police on failed deals (0-100)
settings.WholesaleResetOnTimeout = true -- Reset wholesale flag when buyer times out
settings.SuccessfulChance = 90 --- this is the chance of a Success wholesale 1-100
settings.AlertPoliceWholesale = 90 -- 1-100 of how often it will alert police
settings.WholesaleTimeout = 600 -- time in seconds to get to the location
settings.PoliceCount = 2

local Price = {
    coke = {
        min = math.floor(250 * 0.80), -- 250 * 0.80 = 200
        max = math.floor(450 * 0.80)  -- 450 * 0.80 = 360
    },
    crack = {
        min = math.floor(200 * 0.80), -- 200 * 0.80 = 160
        max = math.floor(400 * 0.80)  -- 400 * 0.80 = 320
    },
    lsd = {
        min = math.floor(200 * 0.80), -- 200 * 0.80 = 160
        max = math.floor(350 * 0.80)  -- 350 * 0.80 = 280
    },
    heroin = {
        min = math.floor(200 * 0.80), -- 200 * 0.80 = 160
        max = math.floor(400 * 0.80)  -- 400 * 0.80 = 320
    },
    xtc = {
        min = math.floor(350 * 0.80), -- 350 * 0.80 = 280
        max = math.floor(665 * 0.80)  -- 665 * 0.80 = 532
    },
    meth = {
        min = math.floor(200 * 0.80), -- 200 * 0.80 = 160
        max = math.floor(400 * 0.80)  -- 400 * 0.80 = 320
    }
}
local locs = {
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

ps.registerCallback('md-drugs:server:GetWSsettings', function(source)
    return settings
end)

function getRandW(source)
    local rand = math.random(1, #locs)
    return locs[rand]
end

for k, v in pairs (burners) do
    ps.createUseable(k, function(source, item)
        local Player = ps.getPlayer(source)
        if ps.getJobTypeCount('leo') < Config.PoliceCount then return ps.notify(source, ps.lang('wholesale.notEnoughCops'), 'error') end
        for m, d in pairs (active) do 
            if d.cid == ps.getIdentifier(source) then
                return ps.notify(source, ps.lang('wholesale.alreadyWholesale'), 'error')
            end
        end
        local tab = ''
        if k == 'cokeburner' then tab = 'coke' end
        if k == 'crackburner' then tab = 'crack' end
        if k == 'lsdburner' then tab = 'lsd' end
        if k == 'heroinburner' then tab = 'heroin' end
        if k == 'xtcburner' then tab = 'xtc' end
        if k == 'methburner' then tab = 'meth' end
        if ps.removeItem(source, k, 1) then
            local Player = ps.getPlayer(source)
            local drugCount = 0
            for m, d in pairs (v) do
                local amt = ps.getItemCount(source, d) or 0
                if amt > 0 then
                    drugCount = drugCount + amt
                end
            end
            table.insert(active, {
                src = source,
                item = k,
                location = getRandW(source),
                cid = ps.getIdentifier(source),
                type = v,
                price = Price[tab],
                count = drugCount
            })
            for m, d in pairs (active) do 
                if d.cid == ps.getIdentifier(source) then
                    TriggerClientEvent("md-drugs:client:GetLocation", source, active[m])
                end
            end
        end
    end)
end

RegisterNetEvent('md-drugs:server:SuccessSale', function(data)
    local Player = ps.getPlayer(source)
    for k, v in pairs (active) do 
        if v.cid == ps.getIdentifier(source) then
            local totalQuantity = 0
            local itemCounts = {}
            for m, d in pairs (v.type) do 
                local count = ps.getItemCount(source, d) or 0
                if count >= 1 then
                    totalQuantity = totalQuantity + count
                    itemCounts[d] = count
                end
            end
            if totalQuantity < Config.WholesaleMinQuantity then
                ps.notify(source, string.format(ps.lang('wholesale.min_quantity'), Config.WholesaleMinQuantity), 'error')
                return
            end
            local bonusTiers = math.floor(totalQuantity / 10)
            local quantityBonus = math.min(bonusTiers * Config.WholesaleQuantityBonus, Config.WholesaleMaxBonus)
            local bonusMultiplier = 1 + quantityBonus

            local basePayout = math.random(v.price.min, v.price.max)
            local finalPayout = math.floor(basePayout * bonusMultiplier)
            local totalPayout = 0
            for drug, amount in pairs(itemCounts) do
                ps.removeItem(source, drug, amount)
                totalPayout = totalPayout + (amount * finalPayout)
            end
            ps.addMoney(source, 'cash', totalPayout)
            TriggerClientEvent('md-drugs:client:WholesaleComplete', source, {
                quantity = totalQuantity,
                bonus = math.floor(quantityBonus * 100),
                payout = totalPayout
            })
            table.remove(active, k)
            break
        end
    end
end)

RegisterNetEvent('md-drugs:server:CleanupWholesale', function()
    local Player = ps.getPlayer(source)
    for k, v in pairs(active) do
        if v.cid == ps.getIdentifier(source) then
            table.remove(active, k)
            ps.notify(source, ps.lang('wholesale.deal_failed_cleanup') or 'Deal failed - you can try again', 'error')
            break
        end
    end
end)