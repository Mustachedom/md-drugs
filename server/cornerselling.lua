local QBCore = exports['qb-core']:GetCoreObject()
local StolenDrugs = {}

lib.callback.register('md-drugs:server:cornerselling:getAvailableDrugs', function(source, cb)
    local AvailableDrugs = {}
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return nil end
    local type = 0
    for k in pairs(QBConfig.DrugsPrice) do
        local item = Player.Functions.GetItemByName(k)
        if item and type == 0 then
            type = type + 1
            Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Allowed To Sell ' .. item.name .. '!' , 'cornerselling')
            return item.name, item.amount
        end
    end
    if type == 0 then 
        return 'nothing', 0
    end
end)


RegisterNetEvent('md-drugs:server:sellCornerDrugs', function(item, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
  
    if RemoveItem(item, amount) then
        Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Sold ' .. amount .. ' Of ' .. item .. ' For A Price Of ' .. price .. '!' , 'cornerselling')
        if QBConfig.MarkedBills then
            if price  >= QBConfig.DrugsPrice[item]['min'] * amount and price  <= QBConfig.DrugsPrice[item]['max'] * amount then 
                local info = {
                    worth = price
                }
                Player.Functions.AddItem('markedbills', 1, false, info )
            end
        elseif QBConfig.CustomDirtyMoney then 
            Player.Functions.AddItem(QBConfig.CustomDirtyMoneyitem,price)
        else
            Player.Functions.AddMoney('cash', price)
        end
    end 
end)

RegisterNetEvent('md-drugs:server:robCornerDrugs', function(drugType, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local availableDrugs = getAvailableDrugs(src)

    if not availableDrugs or not Player then return end

    local item = availableDrugs[drugType].item

    Player.Functions.RemoveItem(item, amount)
    table.insert(StolenDrugs, {item = item, amount = amount})
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
    TriggerClientEvent('md-drugs:client:refreshAvailableDrugs', src, getAvailableDrugs(src))
end)
lib.addCommand('cornersell', {
    help = 'Sell Things On The Corner',
    params = {
       
    },
}, function(source, args, raw)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Used Command cornersell!' , 'cornerselling')
    TriggerClientEvent('md-drugs:client:cornerselling', src)
end)
