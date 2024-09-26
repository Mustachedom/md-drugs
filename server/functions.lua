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
------------------------------------ functions
---
---
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
        local Player = QBCore.Functions.GetPlayer(source)
        local itemchecks = Player.Functions.GetItemByName(item)
        if itemchecks and itemchecks.amount >= amount then
            return true
        else 
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item)  .. ' To Do this', 'error')
            return false   
        end
    elseif inventory == 'ox' then
       local has = exports.ox_inventory:GetItem(source, item , nil, true)
        if has >= amount then 
            return true
        else
            Notifys(source, 'You Need ' .. amount .. ' Of ' .. GetLabels(item) .. ' To Do This', 'error')
            return false
        end
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

function checkTable(table)
	local need = 0
	local have = 0
	for k, v in pairs (table) do 
		need = need + 1
		if Itemcheck(source, k, v) then have = have + 1  end
	end
	if need == have then
		return true
	else
	end
end

function RemoveItem(source, item, amount) 
    if inventory == 'qb' then
        local Player = QBCore.Functions.GetPlayer(source)
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
        local Player = QBCore.Functions.GetPlayer(source)
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

function GetName(source) 
    local Player = QBCore.Functions.GetPlayer(source) 
        return Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
    
end

function getRep(source, type) 
    local Player = QBCore.Functions.GetPlayer(source) 
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {Player.PlayerData.citizenid}) 
    if not sql[1] then
        local table = json.encode({
            coke = Player.PlayerData.metadata.coke or 0,
            lsd = Player.PlayerData.metadata.lsd or 0,
            heroin = Player.PlayerData.metadata.heroin or 0,
            dealerrep = Player.PlayerData.metadata.dealerrep or 0,
        })
        MySQL.insert('INSERT INTO drugrep SET cid = ?, drugrep = ?, name = ?', {Player.PlayerData.citizenid, table, GetName(source)})
        return false
    else
        local rep = json.decode(sql[1].drugrep) 
        if type == 'coke' then
            return rep.coke
        elseif type == 'heroin' then
            return rep.heroin
        elseif type == 'lsd' then
            return rep.lsd
        elseif type == 'dealerrep' then
            return rep.dealerrep
        else
            print('^1 Error: No Valid Drug Rep Option Chosen') 
        end
        return false
    end
end

function GetAllRep(source) 
    local Player = QBCore.Functions.GetPlayer(source) 
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {Player.PlayerData.citizenid}) 
    if not sql[1] then
        local table = json.encode({
            coke = Player.PlayerData.metadata.coke or 0,
            lsd = Player.PlayerData.metadata.lsd or 0,
            heroin = Player.PlayerData.metadata.heroin or 0,
            dealerrep = Player.PlayerData.metadata.dealerrep or 0,
        })
        MySQL.insert('INSERT INTO drugrep SET cid = ?, drugrep = ?, name = ?', {Player.PlayerData.citizenid, table, GetName(source)})
        Wait(1000)
        return false
    else
        local rep = json.decode(sql[1].drugrep) 
        return rep
    end
end

function AddRep(source, type) 
    local Player = QBCore.Functions.GetPlayer(source) 
    local sql = MySQL.query.await('SELECT * FROM drugrep WHERE cid = ?', {Player.PlayerData.citizenid}) 
    local rep = json.decode(sql[1].drugrep)
    local update 
    if type == 'coke' then
         update = json.encode({coke = rep.coke + 1, heroin = rep.heroin, lsd = rep.lsd, dealerrep = rep.dealerrep})
    elseif type == 'heroin' then
        update = json.encode({coke = rep.coke, heroin = rep.heroin + 1, lsd = rep.lsd, dealerrep = rep.dealerrep})
    elseif type == 'lsd' then
        update = json.encode({coke = rep.coke, heroin = rep.heroin, lsd = rep.lsd +1 , dealerrep = rep.dealerrep})
    elseif type == 'dealerrep' then
        update = json.encode({coke = rep.coke, heroin = rep.heroin, lsd = rep.lsd, dealerrep = rep.dealerrep + 1})
    end
    if update == '' then return false end
        MySQL.update('UPDATE drugrep SET drugrep = ? WHERE cid = ?', {update, Player.PlayerData.citizenid})
    return true
end
    

function ChecknRemove(source, table) 
    local Player = QBCore.Functions.GetPlayer(source) 
    local hass = 0
    local need = 0
    for k, v in pairs (table) do
        need = need + 1 
        if inventory == 'qb' then
            local itemchecks = Player.Functions.GetItemByName(k)
            if itemchecks and itemchecks.amount >= v then
                hass = hass + 1
            else 
                Notifys(source, 'You Need ' .. v .. ' Of ' .. GetLabels(k)  .. ' To Do this', 'error')
            end
        elseif inventory == 'ox' then
           local has = exports.ox_inventory:GetItem(source, k , nil, true)
            if has.count >= v then 
                hass = hass + 1
            else
                Notifys(source, 'You Need ' .. v .. ' Of ' .. GetLabels(k) .. ' To Do This', 'error')
            end
        end
    end
    if hass == need then 
        for k, v in pairs (table) do 
            RemoveItem(source, k, v) 
        end
        return true
    else
        return false
    end
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