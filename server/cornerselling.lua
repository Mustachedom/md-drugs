local QBCore = exports['qb-core']:GetCoreObject()
local StolenDrugs = {}

local function getAvailableDrugs(source)
    local AvailableDrugs = {}
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player then return nil end

    for k in pairs(QBConfig.DrugsPrice) do
        local item = Player.Functions.GetItemByName(k)

        if item then
            AvailableDrugs[#AvailableDrugs + 1] = {
                item = item.name,
                amount = item.amount,
                label = QBCore.Shared.Items[item.name]["label"]
            }
        end
    end
    return table.type(AvailableDrugs) ~= "empty" and AvailableDrugs or nil
end

QBCore.Functions.CreateCallback('md-drugs:server:cornerselling:getAvailableDrugs', function(source, cb)
    cb(getAvailableDrugs(source))
end)

RegisterNetEvent('md-drugs:server:giveStealItems', function(drugType, amount)
    local Player = QBCore.Functions.GetPlayer(source)

    if not Player or StolenDrugs == {} then return end

    for k,v in pairs(StolenDrugs) do
        if drugType == v.item and amount == v.amount then
            Player.Functions.AddItem(drugType, amount)
            table.remove(StolenDrugs, k)
        end
    end 
end)

RegisterNetEvent('md-drugs:server:sellCornerDrugs', function(drugType, amount, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local availableDrugs = getAvailableDrugs(src)

    if not availableDrugs or not Player then return end

    local item = availableDrugs[drugType].item

    local hasItem = Player.Functions.GetItemByName(item)
    if hasItem.amount >= amount then
        TriggerClientEvent('QBCore:Notify',"sold", 'success')
        Player.Functions.RemoveItem(item, amount)
        Player.Functions.AddMoney('cash', price, "sold-cornerdrugs")
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
        TriggerClientEvent('md-drugs:client:refreshAvailableDrugs', src, getAvailableDrugs(src))
    else
        TriggerClientEvent('md-drugs:client:cornerselling', src)
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
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
    TriggerClientEvent('md-drugs:client:refreshAvailableDrugs', src, getAvailableDrugs(src))
end)
