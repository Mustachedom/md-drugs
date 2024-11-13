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
    local Player = getPlayer(src)
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
    local Player = getPlayer(src)
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

lib.addCommand("newdealer", {
    help = "Place a dealer (Admin Only)",
    params = {
        { name = "name", help = "Dealer Name", type = "string" },
        { name = "min", help = "Minimum Time", type = "number" },
        { name = "max", help = "Maximum Time", type = "number" }
    },
    restricted = "admin"
}, function(source, args)
    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local Player = getPlayer(source)
    if not Player then return end

    local dealerName = args.name
    local minTime = args.min
    local maxTime = args.max
    local time = json.encode({min = minTime, max = maxTime})
    local pos = json.encode({x = coords.x, y = coords.y, z = coords.z})
    
    local result = MySQL.scalar.await('SELECT name FROM dealers WHERE name = ?', { dealerName })
    if result then
        return Notifys(source,"Already Exists", "error")
    end

    MySQL.insert('INSERT INTO dealers (name, coords, time, createdby) VALUES (?, ?, ?, ?)', {
        dealerName, pos, time, Player.PlayerData.citizenid
    }, function()
        QBConfig.Dealers[dealerName] = {
            name = dealerName,
            coords = {
                x = coords.x,
                y = coords.y,
                z = coords.z,
                h = GetEntityHeading(ped)
            },
            time = {
                min = minTime,
                max = maxTime
            },
        }
        TriggerClientEvent('md-drugs:client:RefreshDealers', -1, QBConfig.Dealers)
    end)
end)

lib.addCommand("deletedealer", {
    help = "Delete a dealer (Admin Only)",
    params  = {
        { name = "name", help = "Dealer Name", type = "string" }
    },
    restricted = 'group.admin'
}, function(source, args)
    local dealerName = args.name
    local result = MySQL.scalar.await('SELECT * FROM dealers WHERE name = ?', { dealerName })

    if result then
        MySQL.query('DELETE FROM dealers WHERE name = ?', { dealerName })
        QBConfig.Dealers[dealerName] = nil
        TriggerClientEvent('md-drugs:client:RefreshDealers', -1, QBConfig.Dealers)
        TriggerClientEvent('QBCore:Notify', source, "Dealer Deleted", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "Who You Tryna Delete", "error")
    end
end)