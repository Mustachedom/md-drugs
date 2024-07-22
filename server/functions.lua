local QBCore = exports['qb-core']:GetCoreObject()
local notify = Config.Notify -- qb or ox
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

function Notifys(text, type)
    local src = source
    if notify == 'qb' then
        TriggerClientEvent("QBCore:Notify", src, text, type)
    elseif notify == 'ox' then
        lib.notify(src, { title = text, type = type})
    elseif notify == 'okok' then
        TriggerClientEvent('okokNotify:Alert', src, '', text, 4000, type, false)
    else
        print"dude, it literally tells you what to put in the config"    
    end    
end    

function Itemcheck(Player, item, amount, notify) 
    local itemchecks = Player.Functions.GetItemByName(item)
    local yes

    if notify == nil then notify = false end
    if itemchecks and itemchecks.amount >= amount then
       yes = true  return yes
    else 
        if notify == 'true' then 
            Notifys('You Need ' .. amount .. ' Of ' .. QBCore.Shared.Items[item].label .. ' To Do this', 'error') return else end 
    end        
end
function dist(source, Player, coords)
    local pcoords = GetEntityCoords(Player)
    local dist = #(pcoords - coords)
        return dist
end
function CheckDist(source,Player, coords)
    local pcoords = GetEntityCoords(Player)
    local ok 
    if #(pcoords - coords) < 4.0 then
        return ok
    else    
        DropPlayer(source, 'Too Far') return  end
end
function checkTable(player, table)
	local need = 0
	local have = 0
	for k, v in pairs (table) do 
		need = need + 1
		if Itemcheck(player, k, v, 'true') then have = have + 1  end
	end
	if need == have then
		return true
	else
	end
end
function RemoveItem( item, amount) 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item, amount) then TriggerClientEvent(invname ..":client:ItemBox", src, QBCore.Shared.Items[item], "remove", amount)  return true
     else 
        Notifys('You Need ' .. amount .. ' Of ' .. QBCore.Shared.Items[item].label .. ' To Do This', 'error')
    end
end

function AddItem(item, amount) 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.AddItem(item, amount) then TriggerClientEvent(invname ..":client:ItemBox", src, QBCore.Shared.Items[item], "add", amount) return true
     else 
        print('you sucks')
    end
end

function Notifysu(text, type, source)
    
    if notify == 'qb' then
        TriggerClientEvent("QBCore:Notify", source, text, type)
    elseif notify == 'ox' then
        lib.notify(source, { title = text, type = type})
    elseif notify == 'okok' then
        TriggerClientEvent('okokNotify:Alert', source, '', text, 4000, type, false)
    else
        print"dude, it literally tells you what to put in the config"    
    end    
end  

function RemoveItemu( item, amount, source) 
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveItem(item, amount) then TriggerClientEvent(invname ..":client:ItemBox", source, QBCore.Shared.Items[item], "remove", amount)  return true
     else 
        Notifysu('You Need ' .. amount .. ' Of ' .. QBCore.Shared.Items[item].label .. ' To Do This', 'error', source)
    end
end

function AddItemu(item, amount, source) 
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.AddItem(item, amount) then TriggerClientEvent(invname ..":client:ItemBox", source, QBCore.Shared.Items[item], "add", amount) return true
     else 
        print('you sucks')
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

CreateThread(function()
    if not GetResourceState('ox_lib'):find("start") then 
       print('^1 ox_lib Is A Depndancy, Not An Optional ')
    end
    if Config.minigametype == 'ps' and not GetResourceState('ps-ui'):find("start") then
        print('^1 You Have Config.minigametype as ps but dont have ps-ui started')
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

