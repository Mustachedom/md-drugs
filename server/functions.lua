local QBCore = exports['qb-core']:GetCoreObject()
local notify = Config.Notify -- qb or ox

function Notifys(text, type)
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

function CheckDist(source,Player, coords)
    local pcoords = GetEntityCoords(Player)
    local ok 
    if #(pcoords - coords) < 3.0 then
        return ok
    else    
        DropPlayer(source, 'Too Far') return  end
end

function RemoveItem( item, amount) 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveItem(item, amount) then TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "remove", amount)  return true
     else 
        Notifys('You Need ' .. amount .. ' Of ' .. QBCore.Shared.Items[item].label .. ' To Do This', 'error')
    end
end

function AddItem(item, amount) 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.AddItem(item, amount) then TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add", amount) return true
     else 
        print('you sucks')
    end
end

QBCore.Functions.CreateCallback('md-drugs:server:GetCoppers', function(source, cb, args)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
         if v.PlayerData.job.type == 'leo' and v.PlayerData.job.onduty then
          amount = amount + 1
         end
    end
    cb(amount)
end)


CreateThread(function()
    if (GetCurrentResourceName() ~= 'md-drugs') then
        print('^1 >:( I guess it isnt a cool enough name for you')
    end
    if GetResourceState('qb-inventory'):find("start") then
         if Config.imagelink ~= 'qb-inventory/html/images/' then
             print'^1 Line 9 of your config is wrong change it to qb-inventory/html/images/'
         end
    
    elseif GetResourceState('ps-inventory'):find("start") then
        if Config.imagelink ~= 'ps-inventory/html/images/' then
            print'^1 Line 9 of your config is wrong change it to ps-inventory/html/images/'
        end
    elseif GetResourceState('lj-inventory'):find("start") then
        if Config.imagelink ~= 'lj-inventory/html/images/' then
            print' ^1 Line 9 of your config is wrong change it to ps-inventory/html/images/'
        end
    elseif GetResourceState('ox_inventory'):find("start") then
        if Config.imagelink ~= 'ox_inventory/web/images/' then
            print'^1  Line 9 of your config is wrong'
        end
    else
    end
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
