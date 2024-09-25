QBCore = exports['qb-core']:GetCoreObject()


-- Callbacks
lib.callback.register('md-drugs:server:getDealers', function(data)
    local check = MySQL.query.await('SELECT * FROM dealers', {})
    local loc = json.encode({x = 899.98, y = -2603.24, z = 6.11, h = 176.12 })
    if not check[1] then 
        MySQL.insert('INSERT INTO dealers SET name = ?, coords = ?, time = ?, createdby = ?', {'MD', loc, 'any', 'code Newb'})
	Wait(2000)
	local check2 = MySQL.query.await('SELECT * FROM dealers', {})
        return check2
    else
        return check
    end
end)
    

lib.callback.register('md-drugs:server:GetDeliveryItem', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    local item = math.random(1, #QBConfig.DeliveryItems)
    local amount = math.random(1,4)
    local check = MySQL.query.await('SELECT * FROM deliveriesdealer WHERE cid = ?', {Player.PlayerData.citizenid})
    local locnum = math.random(1, #QBConfig.DeliveryLocations)
    local coord = json.encode({
        x =  math.floor(QBConfig.DeliveryLocations[locnum].coords.x * 100) / 100,
        y =  math.floor(QBConfig.DeliveryLocations[locnum].coords.y * 100) / 100,
        z = math.floor(QBConfig.DeliveryLocations[locnum].coords.z * 100) / 100,
    })
    if not check[1] then
        MySQL.insert('INSERT INTO deliveriesdealer SET cid = ?, itemdata = ?, timestart = ?, maxtime = ?, location = ?', 
        {Player.PlayerData.citizenid, json.encode({item = QBConfig.DeliveryItems[item].item, amount = amount}), os.time(), os.time() + (15 * 60), coord })
        AddItem(Player.PlayerData.source, QBConfig.DeliveryItems[item].item, amount)
        return true, QBConfig.DeliveryItems[item].item, amount, coord
    else
        local time = os.time()
        local timeout = math.floor(os.difftime(time, check[1].maxtime) / 60)
        
        if timeout > 15 then MySQL.query.await('DELETE FROM deliveriesdealer WHERE cid = ?', {Player.PlayerData.citizenid}) Notifys(src, 'You Failed To Make It In Time!', 'error' ) return false end
        Notifys(src,'You Already Have A Delivery To Make', 'error' ) return false, QBConfig.DeliveryItems[item].item, amount, coord
    end
end)

RegisterNetEvent('md-drugs:server:giveDeliveryItems', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local check = MySQL.query.await('SELECT * FROM deliveriesdealer WHERE cid = ?', {Player.PlayerData.citizenid})
    if not check[1] then return end
    local time = os.time()
    local timeout = math.floor(os.difftime(time, check[1].maxtime) / 60)
    local itemData = json.decode(check[1].itemdata)
    if timeout >= 15 then MySQL.query.await('DELETE FROM deliveriesdealer WHERE cid = ?', {Player.PlayerData.citizenid}) Notifys(source, 'You Failed To Make It In Time!', 'error' )  return end
    if item ~= itemData.item then return end
    if amount ~= itemData.amount then return end
    if RemoveItem(src, item, amount) then
       for k, v in pairs (QBConfig.DeliveryItems) do 
            if v.item == item then 
                local income = math.random(v.payout.min, v.payout.max) 
                Player.Functions.AddMoney('cash', income) 
                AddRep(src, 'dealerrep') 
            end
        end
        MySQL.query.await('DELETE FROM deliveriesdealer WHERE cid = ?', {Player.PlayerData.citizenid})
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
