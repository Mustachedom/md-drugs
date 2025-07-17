
------------------------------------------ logging stuff
local logs = false 
local logapi = GetConvar("fivemerrLogs", "")
local endpoint = 'https://api.fivemerr.com/v1/logs'
local headers = {
    ['Authorization'] = logapi,
    ['Content-Type'] = 'application/json',
}


local function handleFresh(source)
    local table = json.encode({
        coke = 0,lsd = 0,heroin = 0,dealerrep = 0,
        cornerselling = { price = QBConfig.SellLevel[1].price,rep = 0,label = QBConfig.SellLevel[1].label,level = 1}
    })
    MySQL.insert('INSERT INTO drugrep SET cid = ?, drugrep = ?, name = ?', {ps.getIdentifier(source), table, ps.getPlayerName(source)})
    return json.decode(table)
end

function getRep(source, type)
    local sql = MySQL.query.await('SELECT JSON_UNQUOTE(JSON_EXTRACT(drugrep, ?)) AS rep FROM drugrep WHERE cid = ?', {'$.' .. type, ps.getIdentifier(source)})
    if not sql[1] then
        local new = handleFresh(source)
        return new[type]
    else
        return tonumber(sql[1].rep)
    end
end

function GetAllRep(source)
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {ps.getIdentifier(source)})
    if not sql[1] then
        local new = handleFresh(source)
        return new
    else
        local rep = json.decode(sql[1].drugrep)
        if rep.coke == nil then return rep[1] end
        return rep
    end
end

function AddRep(source, type, amount)
    if not Config.TierSystem then return false end
    if not amount then amount = 1 end
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {ps.getIdentifier(source)}) 
    local reps = json.decode(sql[1].drugrep)
    local update
    local rep = ''
    if reps.coke == nil then rep = reps[1] else rep = reps end
    if type == 'cornerselling' then
        for k, v in pairs (QBConfig.SellLevel) do
            if rep.cornerselling.level == k  then 
                if rep.cornerselling.rep + amount >= v.maxrep then
                    update = json.encode({coke = rep.coke, heroin = rep.heroin, lsd = rep.lsd, dealerrep = rep.dealerrep, cornerselling = {label = v.label, price = v.price, rep = rep.cornerselling.rep + amount, level = k + 1}})
                else
                    update = json.encode({coke = rep.coke, heroin = rep.heroin, lsd = rep.lsd, dealerrep = rep.dealerrep, cornerselling = {label = v.label, price = v.price, rep = rep.cornerselling.rep + amount, level = k}})
                end
            end
        end
        if update == '' then return false end
        MySQL.update('UPDATE drugrep SET drugrep = ? WHERE cid = ?', {update, ps.getIdentifier(source)})
        return true
    else
        rep[type] = rep[type] + amount
        MySQL.update('UPDATE drugrep SET drugrep = ? WHERE cid = ?', {json.encode(rep), ps.getIdentifier(source)})
        return true
    end
end

lib.addCommand('addCornerSellingTOREP', {
    help = 'RUN THIS ONCE AND DELETE',
    restricted = 'group.admin'
}, function(source, args, raw)
    local sql = MySQL.query.await('SELECT * FROM drugrep', {})
    for k, v in pairs (sql) do 
      local new = {}
      local old = json.decode(v.drugrep)
      local get = old[1] or old
      table.insert(new, {
        coke = get.coke,
        lsd = get.lsd,
        heroin = get.heroin,
        dealerrep = get.dealerrep,
        cornerselling = {
            price = QBConfig.SellLevel[1].price,
            rep = 0,
            label = QBConfig.SellLevel[1].label,
            level = 1
        }
      })
      local news = json.encode(new)
      MySQL.query.await('UPDATE drugrep SET drugrep = ? WHERE cid = ?', {news, v.cid})
    end
end)

function sortTab(tbl, type)
    table.sort(tbl, function(a, b)
        return a[type] < b[type]
    end)
end

function handleCornersell(source, item, amount, price)
    if RemoveItem(source, item, amount) then
        if inventory == 'qb' then
            local Player = getPlayer(source)
            if QBConfig.MarkedBills == true then 
                Player.Functions.AddItem('markedbills',1,false, {worth = price})
                return true
            end
            if QBConfig.CustomDirtyMoney == true then
                AddItem(source, QBConfig.CustomDirtyMoneyitem,price)
                return true
            end
            Player.Functions.AddMoney('cash', price)
        elseif inventory == 'ox' then
            AddItem(source, 'black_money', price)
            return true
        end
    else
        return false
    end
end

lib.callback.register('md-drugs:server:GetCoppers', function(source, cb, args)
   return getCops()
end)

ps.registerCallback('md-drugs:server:GetRep', function(source, cb, args)
    local rep = GetAllRep(source) 
    return rep
end)

ps.versionCheck('md-drugs', 'https://raw.githubusercontent.com/Mustachedom/md-drugs/refs/heads/hushhushmotherfucker/version.txt', 'https://github.com/Mustachedom/md-drugs/')