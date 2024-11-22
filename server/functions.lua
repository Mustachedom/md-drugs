local QBCore = exports['qb-core']:GetCoreObject()
local notify = Config.Notify -- qb or ox

------------------------------------------ logging stuff
local logs = false 
local logapi = GetConvar("fivemerrLogs", "")
local endpoint = 'https://api.fivemerr.com/v1/logs'
local headers = {
            ['Authorization'] = logapi,
            ['Content-Type'] = 'application/json',
    }

CreateThread(function()
if logs then 
    print'^2 Logs Enabled for md-drugs'
    if logapi == 'insert string here' then 
        print'^1 homie you gotta set your api on line 4'
    else
        print'^2 API Key Looks Good, Dont Trust Me Though, Im Not Smart'
    end
else
    print'^1 logs disabled for md-drugs'
end
end)

function Log(message, type)
if logs == false then return end	
    local buffer = {
        level = "info",
        message = message,
        resource = GetCurrentResourceName(),
        metadata = {
            drugs = type,
            playerid = source
        }
    }
     SetTimeout(500, function()
         PerformHttpRequest(endpoint, function(status, _, _, response)
             if status ~= 200 then 
                 if type(response) == 'string' then
                     response = json.decode(response) or response
                 end
             end
         end, 'POST', json.encode(buffer), headers)
         buffer = nil
     end)
end
---------------------------------------------------- inventory catcher
local invname = ''
CreateThread(function()
if GetResourceState('ps-inventory') == 'started' then
    invname = 'ps-inventory'
elseif GetResourceState('qb-inventory') == 'started' then
    invname = 'qb-inventory'
else
    invname = 'inventory'		
end
end)

local inventory = ''

CreateThread(function()
if GetResourceState('ox_inventory') == 'started' then
    inventory = 'ox'
else
    inventory = 'qb'
end
end)
------------------------------------ Player Stuff functions
function getPlayer(source) 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    return Player
end

function GetName(source) 
    local Player = getPlayer(source) 
    return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
end

function GetCoords(source) 
    local ped = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(ped)
    return playerCoords
end

function dist(source, coords)
    local playerPed = GetPlayerPed(source)
    local pcoords = GetEntityCoords(playerPed)
    local dist = #(pcoords - coords)
        return dist
end

function CheckDist(source, coords)
    local playerPed = GetPlayerPed(source)
    local pcoords = GetEntityCoords(playerPed)
    local ok 
    if #(pcoords - coords) < 4.0 then
        return ok
    else    
        DropPlayer(source, 'md-drugs: You Were A Total Of ' .. #(pcoords - coords) .. ' Too Far Away To Trigger This Event') 
        return false
    end
end


function Notifys(source, text, type)
    local src = source
    if notify == 'qb' then
        TriggerClientEvent("QBCore:Notify", src, text, type)
    elseif notify == 'ox' then
        lib.notify(src, { title = text, type = type})
    elseif notify == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, '', text, 4000, type, false)
    else
        print"^1 Look At The Config For Proper Alert Options"    
    end    
end

function GetLabels(item) 
    if inventory == 'qb' then
        return QBCore.Shared.Items[item].label
    elseif inventory == 'ox' then
        local items = exports.ox_inventory:Items()
        return items[item].label
    end
end

function Itemcheck(source, item, amount) 
    if inventory == 'qb' then
        local Player = getPlayer(source)
        local itemchecks = Player.Functions.GetItemByName(item)
        if itemchecks and itemchecks.amount >= amount then
            return true
        else 
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item)  .. ' To Do this', 'error')
            return false   
        end
    elseif inventory == 'ox' then
       local items = exports.ox_inventory:GetItem(source, item, nil, false) 
        if items.count >= amount then 
                return true
        else
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item) .. ' To Do This', 'error')
            return false
        end
    end
end

function RemoveItem(source, item, amount) 
    if inventory == 'qb' then
        local Player = getPlayer(source)
        if Player.Functions.RemoveItem(item, amount) then 
            TriggerClientEvent(invname ..":client:ItemBox", source, QBCore.Shared.Items[item], "remove", amount)  
            return true
        else 
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item) .. ' To Do This', 'error')
        end
    elseif inventory == 'ox' then
        if exports.ox_inventory:RemoveItem(source, item, amount) then 
            return true
        else
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item) .. ' To Do This', 'error')
        end
    end
end

function AddItem(source, item, amount) 
    if inventory == 'qb' then
        local Player = getPlayer(source)
        if Player.Functions.AddItem(item, amount) then 
            TriggerClientEvent(invname ..":client:ItemBox", source, QBCore.Shared.Items[item], "add", amount) 
            return true
         else 
            print('Failed To Give Item: ' .. item .. ' Check Your qb-core/shared/items.lua')
            return false
        end
    else
        local carry = exports.ox_inventory:CanCarryItem(source, item, amount)
        if not carry then Notifys(source, 'You Cant Carry that Much Weight!', 'error') return false end
        if exports.ox_inventory:AddItem(source, item, amount) then
            return true
        else
            print('Failed To Give Item: ' .. item .. ' Check Your ox_inventory/data/items.lua')
            return false
        end
    end
end


function getRep(source, type) 
    local Player = getPlayer(source) 
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {Player.PlayerData.citizenid}) 
    if not sql[1] then
        local table = json.encode({
            coke = Player.PlayerData.metadata.coke or 0,
            lsd = Player.PlayerData.metadata.lsd or 0,
            heroin = Player.PlayerData.metadata.heroin or 0,
            dealerrep = Player.PlayerData.metadata.dealerrep or 0,
            cornerselling = {
                price = QBConfig.SellLevel[1].price,
                rep = 0,
                label = QBConfig.SellLevel[1].label,
                level = 1
            }
        })
        MySQL.insert('INSERT INTO drugrep SET cid = ?, drugrep = ?, name = ?', {Player.PlayerData.citizenid, table, GetName(source)})
        Wait(1000)
        return json.decode(table)
    else
        local reps = json.decode(sql[1].drugrep)
        local rep = ''
        if reps.coke == nil then rep = reps[1] else rep = reps end
        if type == 'coke' then
            return rep.coke
        elseif type == 'heroin' then
            return rep.heroin
        elseif type == 'lsd' then
            return rep.lsd
        elseif type == 'dealerrep' then
            return rep.dealerrep
        elseif type == 'cornerselling' then
            return rep.cornerselling
        else
            print('^1 Error: No Valid Drug Rep Option Chosen') 
        end
        return false
    end
end

function GetAllRep(source) 
    local Player = getPlayer(source) 
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {Player.PlayerData.citizenid}) 
    if not sql[1] then
        local table = json.encode({
            coke = Player.PlayerData.metadata.coke or 0,
            lsd = Player.PlayerData.metadata.lsd or 0,
            heroin = Player.PlayerData.metadata.heroin or 0,
            dealerrep = Player.PlayerData.metadata.dealerrep or 0,
            cornerselling = {
                price = QBConfig.SellLevel[1].price,
                rep = 0,
                label = QBConfig.SellLevel[1].label,
                level = 1
            }
        })
        MySQL.insert('INSERT INTO drugrep SET cid = ?, drugrep = ?, name = ?', {Player.PlayerData.citizenid, table, GetName(source)})
        Wait(1000)
        return json.decode(table)
    else
        local rep = json.decode(sql[1].drugrep)
        if rep.coke == nil then return rep[1] end
        return rep
    end
end

function AddRep(source, type, amount) 
    if not amount then amount = 1 end
    local Player = getPlayer(source) 
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {Player.PlayerData.citizenid}) 
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
    elseif type == 'coke' then
         update = json.encode({coke = rep.coke + amount, heroin = rep.heroin, lsd = rep.lsd, dealerrep = rep.dealerrep, cornerselling = rep.cornerselling})
    elseif type == 'heroin' then
        update = json.encode({coke = rep.coke, heroin = rep.heroin + amount, lsd = rep.lsd, dealerrep = rep.dealerrep, cornerselling = rep.cornerselling})
    elseif type == 'lsd' then
        update = json.encode({coke = rep.coke, heroin = rep.heroin, lsd = rep.lsd +amount , dealerrep = rep.dealerrep, cornerselling = rep.cornerselling})
    elseif type == 'dealerrep' then
        update = json.encode({coke = rep.coke, heroin = rep.heroin, lsd = rep.lsd, dealerrep = rep.dealerrep + amount, cornerselling = rep.cornerselling})
    end
    if update == '' then return false end
        MySQL.update('UPDATE drugrep SET drugrep = ? WHERE cid = ?', {update, Player.PlayerData.citizenid})
    return true
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

lib.callback.register('md-drugs:server:GetCoppers', function(source, cb, args)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
         if v.PlayerData.job.type == 'leo' and v.PlayerData.job.onduty then
          amount = amount + 1
         end
    end
   return amount
end)

lib.callback.register('md-drugs:server:GetRep', function(source, cb, args)
    local src = source
    local rep = GetAllRep(source) 
    return rep
end)

CreateThread(function()
    if not GetResourceState('ox_lib'):find("start") then 
       print('^1 ox_lib Is A Depndancy, Not An Optional ')
    end
end)
CreateThread(function()
    local url = "https://raw.githubusercontent.com/Mustachedom/md-drugs/main/version.txt"
    local version = GetResourceMetadata('md-drugs', "version" )
     PerformHttpRequest(url, function(err, text, headers)
         if (text ~= nil) then
                print('^2 Your Version:' .. version .. ' | Current Version:' .. text .. '' )  
         end
     end, "GET", "", "")
end)

RegisterServerEvent('md-drugs:server:AddMas', function(data) 
    local src = source
    if not data then return end
    if not Itemcheck(src, data.xt, 1) then return end
    if not RemoveItem(src, data.item, 1) then return end
        RemoveItem(src, data.xt, 1) 
        AddItem(src, data.recieve, data.amount)
end)
