local timeOutPlayers = {}
local playerRep = {}

function checkDistance(src, coords, dist)
    local pcoords = GetEntityCoords(GetPlayerPed(src))
    coords = vector3(coords.x, coords.y, coords.z)
    if #(pcoords - coords) > dist then
        return false
    end
    return true
end
local function timeOutThread(src)
    local id = Bridge.Framework.GetPlayerIdentifier(src)
    CreateThread(function()
        timeOutPlayers[id] = true
        Wait(3000)
        timeOutPlayers[id] = nil
    end)
end

function timeOut(src, event)
    if timeOutPlayers[src] then
        local first, last = Bridge.Framework.GetPlayerName(src)
        Bridge.Prints.Warn(Bridge.Language.Locale('Catches.onCooldownWarn', first .. ' ' .. last, event))
        return true
    end
    timeOutThread(src)
    return false
end

function craft(source, recipe)
    local need, have, oops = 0,0,{}
    for item, amount in pairs (recipe.take) do
        need = need + 1
        local count = Bridge.Inventory.GetItemCount(source, item)
        if count >= amount then
            have = have + 1
        else
            table.insert(oops, 'You Need ' .. amount .. ' X ' .. Bridge.Inventory.GetItemInfo(item).label)
        end
    end
    if have ~= need then
        for index, text in pairs (oops) do
            Bridge.Notify.SendNotify(source, text, 'error')
        end
        return false
    end
    for item, amount in pairs (recipe.take) do
        if not Bridge.Inventory.RemoveItem(source, item, amount) then
            return false
        end
    end
    for item, amount in pairs (recipe.give) do 
        Bridge.Inventory.AddItem(source, item, amount)
    end
    return true
end

local function handleFresh(source)
    local id = Bridge.Framework.GetPlayerIdentifier(source)
    local player = {
        coke = 0,
        lsd = 0,
        heroin = 0,
        dealerrep = 0,
        cornerselling = { 
            price = QBConfig.SellLevel[1].price,
            rep = 0,
            label = QBConfig.SellLevel[1].label,
            level = 1
        }
    }
    playerRep[id] = player
    local first, last = Bridge.Framework.GetPlayerName(source)
    MySQL.insert('INSERT INTO drugrep SET cid = ?, drugrep = ?, name = ?', {id, player, first .. ' ' .. last})
end

local function loadRep(source)
    local id = Bridge.Framework.GetPlayerIdentifier(source)
    local hasRep = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {id})
    if hasRep and not hasRep[1] then
        handleFresh(source)
    end
    if hasRep and hasRep[1] then
        playerRep[id] = json.decode(hasRep[1].drugrep)
    end
end

function getRep(source, type)
    local id = Bridge.Framework.GetPlayerIdentifier(source)
    if not playerRep[id] then
        loadRep(source)
    end
    return playerRep[id][type]
end

function GetAllRep(source)
    local id = Bridge.Framework.GetPlayerIdentifier(source)
    if not playerRep[id] then
        loadRep(source)
    end
    return playerRep[id]
end

function AddRep(source, type, amount)
    if not Config.TierSystem then return false end
    if not amount then amount = 1 end
    local id = Bridge.Framework.GetPlayerIdentifier(source)
    if not playerRep[id] then
        loadRep(source)
    end
    if type == 'cornerselling' then
        local rep = playerRep[id].cornerselling
        local cornerData = QBConfig.SellLevel[rep.level]
        if rep.rep + amount >= cornerData.maxrep then
            rep.level = rep.level + 1
            rep.label = QBConfig.SellLevel[rep.level].label
            rep.price = QBConfig.SellLevel[rep.level].price
        end
        rep.rep = rep.rep + amount
    else
        playerRep[id][type] = playerRep[id][type] + amount
    end
    MySQL.query.await('UPDATE drugrep SET drugrep = ? WHERE cid = ?', {json.encode(playerRep[id]), id})
end
-- TODO: Callbacks
ps.registerCallback('md-drugs:server:GetCoppers', function(source, cb, args)
   return Bridge.Framework.GetPlayersByJob('police')
end)

ps.registerCallback('md-drugs:server:GetRep', function(source, cb, args)
    local rep = GetAllRep(source)
    return rep
end)
--TODO: fix versioncheck
Bridge.Version.VersionChecker('Mustachedom/md-drugs/', false)