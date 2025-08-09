
local coke = { "cokebaggy", "cokebaggystagethree", "cokebaggystagetwo"}
local crack = {"baggedcracked", "baggedcrackedstagetwo", "baggedcrackedstagethree"}
local lsd = {'smiley_tabs', 'yinyang_tabs', 'wildcherry_tabs', 'pineapple_tabs', 'bart_tabs', 'gratefuldead_tabs'}
local heroin = {'heroin_ready', 'heroin_readystagetwo', 'heroin_readystagethree'}
local xtc = {"white_playboys",  "white_playboys2",  "white_playboys3",  "white_playboys4", "blue_playboys",  "blue_playboys2",  "blue_playboys3",  "blue_playboys4",  "red_playboys",  "red_playboys2",  "red_playboys3",  "red_playboys4",  "orange_playboys",  "orange_playboy2s",  "orange_playboys3",  "orange_playboys4",  "white_aliens",  "white_aliens2",  "white_aliens3",  "white_aliens4",  "blue_aliens",  "blue_aliens2",  "blue_aliens3",  "blue_aliens4",  "red_aliens",  "red_aliens3",  "red_aliens2",  "red_aliens4",  "orange_aliens",  "orange_aliens2",  "orange_aliens3",  "orange_aliens4",  "white_pl",  "white_pl2",  "white_pl3",  "white_pl4", "blue_pl",  "blue_pl2",  "blue_pl3",  "blue_pl4",  "red_pl",  "red_pl2",  "red_pl3",  "red_pl4",  "orange_pl",  "orange_pl2",  "orange_pl3",  "orange_pl4",  "white_trolls",  "white_trolls2",  "white_trolls3",  "white_trolls4", "blue_trolls",  "blue_trolls2",  "blue_trolls3",  "blue_trolls4",  "red_trolls",  "red_trolls2",  "red_trolls3",  "red_trolls4",  "orange_trolls",  "orange_trolls2",  "orange_trolls3",  "orange_trolls4",  "white_cats2",  "white_cats3",  "white_cats4",  "white_cats", "blue_cats",  "blue_cats3",  "blue_cats2",  "blue_cats4",  "red_cats",  "red_cats2",  "red_cats3",  "red_cats4",  "orange_cats",  "orange_cats2",  "orange_cats3",  "orange_cats4" }
local burners = {cokeburner = coke, crackburner = crack, lsdburner = lsd, heroinburner = heroin, xtcburner = xtc}
local active = {}

local Price = {
    coke =   {min = 20, max = 60},
    crack =  {min = 20, max = 60},
    lsd =    {min = 20, max = 60},
    heroin = {min = 20, max = 60},
    xtc =    {min = 20, max = 60},
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
function getRandW(src)
    local rand = math.random(1, #locs)
    return locs[rand]
end

for k, v in pairs (burners) do 
    ps.createUseable(k, function(source, item)
        local src = source
        local Player = getPlayer(src)
        if getCops() < Config.PoliceCount then return ps.notify(src, ps.lang('wholesale.notEnoughCops'), 'error') end
        for m, d in pairs (active) do 
            if d.cid == Player.PlayerData.citizenid then
                return ps.notify(src, ps.lang('wholesale.alreadyWholesale'), 'error' )
            end
        end
        local tab = ''
        if k == 'cokeburner' then tab = 'coke' end
        if k == 'crackburner' then tab = 'crack' end
        if k == 'lsdburner' then tab = 'lsd' end
        if k == 'heroinburner' then tab = 'heroin' end
        if k == 'xtcburner' then tab = 'xtc' end
        if ps.removeItem(src, k, 1) then
            table.insert(active, {
                src = src,
                item = k,
                location = getRandW(src),
                cid = ps.getIdentifier(src),
                type = v,
                price = Price[tab]
            })
            for m, d in pairs (active) do 
                if d.cid == ps.getIdentifier(src) then
                    TriggerClientEvent("md-drugs:client:GetLocation", src, active[m])
                end
            end
        end
    end)
end

RegisterNetEvent('md-drugs:server:SuccessSale', function(data)
    local src = source
    for k, v in pairs (active) do
        if v.cid == ps.getIdentifier(src) then
            if not ps.checkDistance(src, v.location, 4.0) then 
                return ps.notify(src, ps.lang('Catches.notIn'), "error")
            end
            local payout = math.random(v.price.min, v.price.max)
            for m, d in pairs (v.type) do
                local git = ps.getItemCount(src, d)
                if git >= 1 then 
                    if ps.removeItem(src, d, git) then
                        ps.addMoney('cash', git * payout)
                    end
                end
                table.remove(active, k)
            end
        end
    end
end)
