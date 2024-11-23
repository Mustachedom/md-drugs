local QBCore = exports['qb-core']:GetCoreObject()
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
for k, v in pairs (burners) do 
    QBCore.Functions.CreateUseableItem(k, function(source, item)
        local src = source
        local Player = getPlayer(src)
        for m, d in pairs (active) do 
            if d.cid == Player.PlayerData.citizenid then
                return Notifys(src, 'You Already Have A Delivery To Make', 'error' )
            end
        end
        local tab = ''
        if k == 'cokeburner' then tab = 'coke' end
        if k == 'crackburner' then tab = 'crack' end
        if k == 'lsdburner' then tab = 'lsd' end
        if k == 'heroinburner' then tab = 'heroin' end
        if k == 'xtcburner' then tab = 'xtc' end
        if RemoveItem(src, k, 1) then
            table.insert(active, {
                src = src,
                item = k,
                location = getRandW(src),
                cid = Player.PlayerData.citizenid,
                type = v,
                price = Price[tab]
            })
            for m, d in pairs (active) do 
                if d.cid == Player.PlayerData.citizenid then
                    TriggerClientEvent("md-drugs:client:GetLocation", src, active[m])
                end
            end
        end
    end)
end

RegisterNetEvent('md-drugs:server:SuccessSale', function(data)
    local src = source
    local Player = getPlayer(src)
    for k, v in pairs (active) do 
        if v.cid == Player.PlayerData.citizenid then
            local payout = math.random(v.price.min, v.price.max)
            for m, d in pairs (v.type) do 
                local git = Player.Functions.GetItemByName(d)
                if git and git.amount >= 1 then 
                    RemoveItem(src, d, git.amount)
                    Player.Functions.AddMoney('cash', git.amount * payout)
                end
                table.remove(active, k)
            end
        end
    end
end)
