local timeOutPlayers = {}

local function timeOutThread(src)
    CreateThread(function()
        timeOutPlayers[ps.getIdentifier(src)] = true
        Wait(3000)
        timeOutPlayers[ps.getIdentifier(src)] = nil
    end)
end

function timeOut(src, event)
    if timeOutPlayers[ps.getIdentifier(src)] then
        ps.warn(ps.lang('Catches.onCooldownWarn', ps.getPlayerName(src), event))
        return true
    end
    timeOutThread(src)
    return false
end

function verifyHas(source, items)
    local need = 0
    local have = 0
    local missingList = {}

    for k, v in pairs(items) do
        need = need + 1
        if ps.hasItem(source, k, v) then
            have = have + 1
        else
            local label = ps.getItemLabel(k) or k
            table.insert(missingList, v .. " " .. label)
        end
    end

    if need == have then
        return true
    end

    local message = ps.lang('Catches.itemMissings') .. table.concat(missingList, "\n")
    ps.notify(source, message, 'error')
    return false
end

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
        return sql[1].rep
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

ps.registerCallback('md-drugs:server:GetCoppers', function(source, cb, args)
   return ps.getJobTypeCount('leo')
end)

ps.registerCallback('md-drugs:server:GetRep', function(source, cb, args)
    local rep = GetAllRep(source)
    return rep
end)
ps.versionCheck('md-drugs', 'https://raw.githubusercontent.com/Mustachedom/md-drugs/refs/heads/main/version.txt', 'https://github.com/Mustachedom/md-drugs/')