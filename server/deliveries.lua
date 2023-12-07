QBCore = exports['qb-core']:GetCoreObject()

-- Functions
exports('GetDealers', function()
    return QBConfig.Dealers
end)

-- Callbacks
QBCore.Functions.CreateCallback('md-drugs:server:RequestConfig', function(_, cb)
    cb(QBConfig.Dealers)
end)

-- Events
RegisterNetEvent('md-drugs:server:updateDealerItems', function(itemData, amount, dealer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not Player then return end

    if QBConfig.Dealers[dealer]["products"][itemData.slot].amount - 1 >= 0 then
        QBConfig.Dealers[dealer]["products"][itemData.slot].amount = QBConfig.Dealers[dealer]["products"][itemData.slot].amount - amount
        TriggerClientEvent('md-drugs:client:setDealerItems', -1, itemData, amount, dealer)
    else
        Player.Functions.RemoveItem(itemData.name, amount)
        Player.Functions.AddMoney('cash', amount * QBConfig.Dealers[dealer]["products"][itemData.slot].price)
        TriggerClientEvent("QBCore:Notify", src, "none Left", "error")
    end
end)

RegisterNetEvent('md-drugs:server:giveDeliveryItems', function(deliveryData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = QBConfig.DeliveryItems[deliveryData.item].item

   if  Player.Functions.AddItem(item, deliveryData.amount) then
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add")
	end
end)

RegisterNetEvent('md-drugs:server:successDelivery', function(deliveryData, inTime)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = QBConfig.DeliveryItems[deliveryData.item].item
    local itemAmount = deliveryData.amount
    local payout = deliveryData.itemData.payout * itemAmount
    local copsOnline = QBCore.Functions.GetDutyCount('police')
    local curRep = Player.PlayerData.metadata["dealerrep"]
    local invItem = Player.Functions.GetItemByName(item)
	
	
    if inTime then
        if invItem and invItem.amount >= itemAmount then -- on time correct amount
            Player.Functions.RemoveItem(item, itemAmount)
            if copsOnline > 0 then
                local copModifier = copsOnline * QBConfig.PoliceDeliveryModifier
                if QBConfig.UseMarkedBills then
                    local info = {worth = math.floor(payout * copModifier)}
                    Player.Functions.AddItem('markedbills', 1, false, info)
                else
                    Player.Functions.AddMoney('cash', math.floor(payout * copModifier), 'drug-delivery')
                end
            else
                if QBConfig.UseMarkedBills then
                    local info = {worth = payout}
                    Player.Functions.AddItem('markedbills', 1, false, info)
                else
                    Player.Functions.AddMoney('cash', payout, 'drug-delivery')
                end
            end
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
            TriggerClientEvent('QBCore:Notify', src, "You Got There In Time!", 'success')
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('md-drugs:client:sendDeliveryMail', src, 'perfect', deliveryData)
                Player.Functions.SetMetaData('dealerrep', (curRep + QBConfig.DeliveryRepGain))
            end)
        else
            TriggerClientEvent('QBCore:Notify', src, "Wheres The Rest Of It", 'error')-- on time incorrect amount
            if invItem then
                local newItemAmount = invItem.amount
                local modifiedPayout = deliveryData.itemData.payout * newItemAmount
                Player.Functions.RemoveItem(item, newItemAmount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
                Player.Functions.AddMoney('cash', math.floor(modifiedPayout / QBConfig.WrongAmountFee))
            end
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('md-drugs:client:sendDeliveryMail', src, 'bad', deliveryData)
                if curRep - 1 > 0 then
                    Player.Functions.SetMetaData('dealerrep', (curRep - QBConfig.DeliveryRepLoss))
                else
                    Player.Functions.SetMetaData('dealerrep', 0)
                end
            end)
        end
    else
        if invItem and invItem.amount >= itemAmount then -- late correct amount
            TriggerClientEvent('QBCore:Notify', src, "Where Were You Slow Ass", 'error')
            Player.Functions.RemoveItem(item, itemAmount)
            Player.Functions.AddMoney('cash', math.floor(payout / QBConfig.OverdueDeliveryFee), "delivery-drugs-too-late")
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
            SetTimeout(math.random(5000, 10000), function()
                TriggerClientEvent('md-drugs:client:sendDeliveryMail', src, 'late', deliveryData)
                if curRep - 1 > 0 then
                    Player.Functions.SetMetaData('dealerrep', (curRep - QBConfig.DeliveryRepLoss))
                else
                    Player.Functions.SetMetaData('dealerrep', 0)
                end
            end)
        else
            if invItem then -- late incorrect amount
                local newItemAmount = invItem.amount
                local modifiedPayout = deliveryData.itemData.payout * newItemAmount
                TriggerClientEvent('QBCore:Notify', src, "Late And Missing Product GZ You Suck", 'error')
                Player.Functions.RemoveItem(item, itemAmount)
                Player.Functions.AddMoney('cash', math.floor(modifiedPayout / QBConfig.OverdueDeliveryFee), "delivery-drugs-too-late")
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove")
                SetTimeout(math.random(5000, 10000), function()
                    TriggerClientEvent('md-drugs:client:sendDeliveryMail', src, 'late', deliveryData)
                    if curRep - 1 > 0 then
                        Player.Functions.SetMetaData('dealerrep', (curRep - QBConfig.DeliveryRepLoss))
                    else
                        Player.Functions.SetMetaData('dealerrep', 0)
                    end
                end)
            end
        end
    end
end)

-- Commands
QBCore.Commands.Add("newdealer", "Place a dealer (Admin Only)", {{ name = "name", help = "Dealer name"},  { name = "min", help = "Minimum Time"}, {name = "max", help = "Maximum Time"}}, true, function(source, args)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    local dealerName = args[1]
    local minTime = tonumber(args[2])
    local maxTime = tonumber(args[3])
    local time = json.encode({min = minTime, max = maxTime})
    local pos = json.encode({x = coords.x, y = coords.y, z = coords.z})
    local result = MySQL.scalar.await('SELECT name FROM dealers WHERE name = ?', {dealerName})
    if result then return TriggerClientEvent('QBCore:Notify', source, "Already Exists", "error") end
    MySQL.insert('INSERT INTO dealers (name, coords, time, createdby) VALUES (?, ?, ?, ?)', {dealerName, pos, time, Player.PlayerData.citizenid}, function()
        QBConfig.Dealers[dealerName] = {
            ["name"] = dealerName,
            ["coords"] = {
                ["x"] = coords.x,
                ["y"] = coords.y,
                ["z"] = coords.z,
            },
            ["time"] = {
                ["min"] = minTime,
                ["max"] = maxTime
            },
            ["products"] = QBConfig.Products
        }
        TriggerClientEvent('md-drugs:client:RefreshDealers', -1, QBConfig.Dealers)
    end)
end, "admin")

QBCore.Commands.Add("deletedealer", "Delete a dealer (Admin Only)", {{
    name = "name",
    help = "Dealer Name"
}}, true, function(source, args)
    local dealerName = args[1]
    local result = MySQL.scalar.await('SELECT * FROM dealers WHERE name = ?', {dealerName})
    if result then
        MySQL.query('DELETE FROM dealers WHERE name = ?', {dealerName})
        QBConfig.Dealers[dealerName] = nil
        TriggerClientEvent('md-drugs:client:RefreshDealers', -1, QBConfig.Dealers)
        TriggerClientEvent('QBCore:Notify', source, "Dealer Deleted" , "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "Who You Tryna Delete", "error")
    end
end, "admin")

QBCore.Commands.Add("dealers", "View all dealers (Admin Only)", {}, false, function(source, _)
    local DealersText = ""
    if QBConfig.Dealers ~= nil and next(QBConfig.Dealers) ~= nil then
        for _, v in pairs(QBConfig.Dealers) do
            DealersText = DealersText .. "Name: " .. v["name"] .. "<br>"
        end
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div class="chat-message advert"><div class="chat-message-body"><strong>' .."List Of Dealers " .. '</strong><br><br> ' .. DealersText .. '</div></div>',
            args = {}
        })
    else
        TriggerClientEvent('QBCore:Notify', source, "No Dealers", 'error')
    end
end, "admin")

QBCore.Commands.Add("dealergoto", "Teleport to a dealer (Admin Only)", {{
    name = "name",
    help = "Dealer name"
}}, true, function(source, args)
    local DealerName = tostring(args[1])
    if QBConfig.Dealers[DealerName] then
        local ped = GetPlayerPed(source)
        SetEntityCoords(ped, QBConfig.Dealers[DealerName]['coords']['x'], QBConfig.Dealers[DealerName]['coords']['y'], QBConfig.Dealers[DealerName]['coords']['z'])
        TriggerClientEvent('QBCore:Notify', source, "TelePorted", {dealerName = DealerName}, 'success')
    else
        TriggerClientEvent('QBCore:Notify', source, "Doesnt Exist", 'error')
    end
end, "admin")

CreateThread(function()
    Wait(500)
    local dealers = MySQL.query.await('SELECT * FROM dealers', {})
    if dealers[1] then
        for _, v in pairs(dealers) do
            local coords = json.decode(v.coords)
            local time = json.decode(v.time)

            QBConfig.Dealers[v.name] = {
                ["name"] = v.name,
                ["coords"] = {
                    ["x"] = coords.x,
                    ["y"] = coords.y,
                    ["z"] = coords.z
                },
                ["time"] = {
                    ["min"] = time.min,
                    ["max"] = time.max
                },
                ["products"] = QBConfig.Products
            }
        end
    end
    TriggerClientEvent('md-drugs:client:RefreshDealers', -1, QBConfig.Dealers)
	
end)
RegisterServerEvent("md-drugs:server:Dealershop", function(amount, value, item,  info)
	local src = source local Player = QBCore.Functions.GetPlayer(src)
	local balance = Player.Functions.GetMoney(tostring(value)) 
	if Player.Functions.RemoveMoney(tostring(value), tonumber(info) * tonumber(amount)) then
		TriggerClientEvent('inventory:client:ItemBox', src, item.name, "add", amount)
		Player.Functions.AddItem(item, amount)
	else
		TriggerClientEvent('QBCore:Notify', source,  "Can't give item!", "error")
	end

end)