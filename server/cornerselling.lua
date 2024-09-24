local QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register('md-drugs:server:cornerselling:getAvailableDrugs', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return nil end
    local type = 0
    for k, v in pairs(QBConfig.DrugsPrice) do
        local item = Player.Functions.GetItemByName(k)
        if item and type == 0 then
            type = type + 1
            Log(GetName(source)  .. ' Allowed To Sell ' .. item.name .. '!' , 'cornerselling')
            local amount = math.random(1,item.amount)
            if amount >= 15 then amount = 15 end
            local price = math.random(QBConfig.DrugsPrice[k]['min'], QBConfig.DrugsPrice[k]['max']) * amount
            return item.name, amount, price
        end
    end
    if type == 0 then 
        return 'nothing', 0, 0
    end
end)


RegisterNetEvent('md-drugs:server:sellCornerDrugs', function(item, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if RemoveItem(src, item, amount) then
        Log(GetName(src)  .. ' Sold ' .. amount .. ' Of ' .. item .. ' For A Price Of ' .. price .. '!' , 'cornerselling')
        if QBConfig.MarkedBills then
            if price  >= QBConfig.DrugsPrice[item]['min'] * amount and price  <= QBConfig.DrugsPrice[item]['max'] * amount then 
                local info = {
                    worth = price
                }
                Player.Functions.AddItem('markedbills', 1, false, info )
            end
        elseif QBConfig.CustomDirtyMoney then 
            AddItem(src, QBConfig.CustomDirtyMoneyitem, price)
        else
            Player.Functions.AddMoney('cash', price)
        end
    end 
end)

lib.addCommand('cornersell', {
    help = 'Sell Things On The Corner',
    params = {
       
    },
}, function(source, args, raw)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Log(GetName(source)  .. ' Used Command cornersell!' , 'cornerselling')
    TriggerClientEvent('md-drugs:client:cornerselling', src)
end)
