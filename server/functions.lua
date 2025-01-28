local QBCore, ESX = {}, {}
local notify = Config.Notify -- qb or ox
local inventory = Config.Inventory -- qb or ox
------------------------------------------ logging stuff
local logs = false 
local logapi = GetConvar("fivemerrLogs", "")
local endpoint = 'https://api.fivemerr.com/v1/logs'
local headers = {
    ['Authorization'] = logapi,
    ['Content-Type'] = 'application/json',
}

if Config.Framework == 'qb' then 
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Framework == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
end

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
------------------------------------ Player Stuff functions
function getPlayer(source)
    local src = source
    if Config.Framework == 'qb' then
        local Player = QBCore.Functions.GetPlayer(src)
        return Player
    elseif Config.Framework == 'esx' then
        local Player = ESX.GetPlayerFromId(src)
        return Player
    end
end

function GetName(source)
    local src = source
    if Config.Framework == 'qb' then
        local Player = getPlayer(src)
        return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    elseif Config.Framework == 'esx' then
        local Player = getPlayer(src)
        return Player.getName()
    end
end

function getCid(source) 
    local src = source
    if Config.Framework == 'qb' then
        local Player = getPlayer(src)
        return Player.PlayerData.citizenid
    elseif Config.Framework == 'esx' then
        local Player = getPlayer(src)
        return Player.getIdentifier()
    end
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

function CUI(item, useFunction)
    if Config.Framework == 'qb' then
        QBCore.Functions.CreateUseableItem(item, useFunction)
    elseif Config.Framework == 'esx' then
        ESX.RegisterUsableItem(item, useFunction)
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

function hasItem(source, item, amount) 
    if inventory == 'qb' then
        local Player = getPlayer(source)
        local itemchecks = Player.Functions.GetItemByName(item)
        if itemchecks and itemchecks.amount >= amount then
            return true
        else
            return false
        end
    elseif inventory == 'ox' then
       local items = exports.ox_inventory:GetItem(source, item, nil, false)
        if items == nil then return false end
        if items.count >= amount then 
            return true
        else
            return false
        end
    end
end

function getItemCount(source, item) 
    if inventory == 'qb' then
        local Player = getPlayer(source)
        local itemchecks = Player.Functions.GetItemByName(item)
        if itemchecks then
            return itemchecks.amount
        else
            return false
        end
    elseif inventory == 'ox' then
       local items = exports.ox_inventory:GetItem(source, item, nil, false)
        if items == nil then 
            print('You are missing ' .. item)
            return 0
        end
        if items.count >= 1 then
            return items.count
        else
            return 0
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
        if exports.ox_inventory:AddItem(source, item, amount) then
            return true
        else
            print('Failed To Give Item: ' .. item .. ' Check Your ox_inventory/data/items.lua')
            return false
        end
    end
end

function addMoney(source, type, amount) 
    if Config.Framework == 'qb' then 
        local Player = getPlayer(source)
        if Player.Functions.AddMoney(type, amount) then
            return true
        else
            return false
        end
    elseif Config.Framework == 'esx' then
        local Player = getPlayer(source)
        if Player.addMoney(amount) then
            return true
        else
            return false
        end
    end
end

function removeMoney(source, type, amount) 
    if Config.Framework == 'qb' then 
        local Player = getPlayer(source)
        if Player.Functions.RemoveMoney(type, amount) then
            return true
        else
            return false
        end
    elseif Config.Framework == 'esx' then
        local Player = getPlayer(source)
         Player.removeMoney(amount)
         print(Player.removeMoney(amount))
            return true
    end
end
local function handleFresh(source)
    local table = json.encode({
        coke = 0,lsd = 0,heroin = 0,dealerrep = 0,
        cornerselling = { price = QBConfig.SellLevel[1].price,rep = 0,label = QBConfig.SellLevel[1].label,level = 1}
    })
    MySQL.insert('INSERT INTO drugrep SET cid = ?, drugrep = ?, name = ?', {getCid(source), table, GetName(source)})
    Wait(1000)
    return json.decode(table)
end

function getRep(source, type)
    local Player = getPlayer(source)
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {getCid(source)}) 
    if not sql[1] then
        local new = handleFresh(source)
        return new[type]
    else
        local reps = json.decode(sql[1].drugrep)
        local rep = ''
        if reps.coke == nil then rep = reps[1] else rep = reps end
        return  rep[type]
    end
end

function GetAllRep(source)
    local Player = getPlayer(source)
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {getCid(source)}) 
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
    if not amount then amount = 1 end
    local Player = getPlayer(source) 
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {getCid(source)}) 
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
        MySQL.update('UPDATE drugrep SET drugrep = ? WHERE cid = ?', {update, getCid(source)})
        return true
    else
        rep[type] = rep[type] + amount
        MySQL.update('UPDATE drugrep SET drugrep = ? WHERE cid = ?', {json.encode(rep), getCid(source)})
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

function getCops()
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
         if v.PlayerData.job.type == 'leo' and v.PlayerData.job.onduty then
          amount = amount + 1
         end
    end
   return amount
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
    end
    return false
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
