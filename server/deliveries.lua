if not Config.Drugs['deliveries'] then return end

local drugDeliveryItem = {
    {item = 'coke_brick', amount = 1},
    {item = 'weed_brick', amount = 1},
}
local Dealers = {}

CreateThread(function()
    local dealers = MySQL.query.await('SELECT * FROM dealers', {})
    if #dealers > 0 then
        for i = 1, #dealers do
            local coords = json.decode(dealers[i].coords)
            Dealers[#Dealers + 1] = {
                coords = vector4(coords.x, coords.y, coords.z, coords.w or 180.0),
                model = dealers[i].model or 'a_m_m_skater_01',
            }
        end
        GlobalState.MDDrugDealers = Dealers
    else
        MySQL.insert('INSERT INTO dealers (model, coords, createdby) VALUES (?, ?, ?)', {'a_m_m_skater_01', json.encode(vector4(1915.68, 154.22, 155.41, 6.88)), 'default'})
        Dealers[#Dealers + 1] = {
            coords = vector4(1915.68, 154.22, 155.41, 6.88),
            model = 'a_m_m_skater_01',
        }
        GlobalState.MDDrugDealers = Dealers
    end
end)

RegisterCommand('newdealer', function(source, args, rawCommand)
    local src = source
    if not IsPlayerAceAllowed(src, "command") then
        return
    end
    local model = args[1] or 'a_m_m_skater_01'
    local coords, heading = GetEntityCoords(GetPlayerPed(src)), GetEntityHeading(GetPlayerPed(src))
    local vec = vector4(coords.x, coords.y, coords.z, heading)
    MySQL.query.await('INSERT INTO dealers (model, coords, createdby) VALUES (?, ?, ?)', {model, json.encode(vec), Bridge.Framework.GetPlayerIdentifier(src)})
    Dealers[#Dealers + 1] = {
        coords = vec,
        model = model,
    }
    GlobalState.MDDrugDealers = Dealers
    Wait(1000)
    TriggerClientEvent('md-drugs:client:RefreshDealers', -1)
end, false)

TriggerClientEvent('chat:addSuggestion', -1, '/newdealer', 'Spawns a new delivery dealer at your location.', {
    { name="model", help="Ped model to use (optional)." }
})

RegisterNetEvent('md-drugs:server:buyItemDealer', function(item, dealerId)
    local src = source
    if not Dealers[dealerId] then return end
    if not checkDistance(src, Dealers[dealerId].coords, 5.0, 'md-drugs:server:buyItemDealer') then
        return
    end
    local itemExists = Config.Deliveries.Recipes[item]

    if not itemExists then
        Bridge.Prints.Warn(Bridge.Language.Locale('Deliveries.itemDoesntExist', Bridge.Framework.GetPlayerIdentifier(src), item))
        return
    end
    if Bridge.Framework.RemoveAccountBalance(src, 'cash', itemExists.price) then
       Bridge.Inventory.AddItem(src, itemExists.name, 1)
    else
        Bridge.Notify.Error(src, Bridge.Language.Locale('Deliveries.purchase_fail_funds'))
    end
end)

local active = {}
CreateThread(function()
    local deliveries = MySQL.query.await('SELECT * FROM deliveriesdealer', {})
    if deliveries and #deliveries > 0 then
        for i = 1, #deliveries do
            local itemdata = json.decode(deliveries[i].itemdata)
            local location = json.decode(deliveries[i].location)
            active[deliveries[i].cid] = {
                coords = vector4(location.x, location.y, location.z, location.w or 180.0),
                item = itemdata.item,
                amount = itemdata.amount,
                timestop = deliveries[i].maxtime,
            }
        end
    end
end)

RegisterNetEvent('md-drugs:server:requestDelivery', function(dealerId)
    local src = source
    if not Dealers[dealerId] then return end
    if not checkDistance(src, Dealers[dealerId].coords, 5.0, 'md-drugs:server:requestDelivery') then
        return
    end
    local id = Bridge.Framework.GetPlayerIdentifier(src)
    if active[id] then
        local currentTime = os.time()
        if currentTime > active[id].timestop then
            Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Deliveries.slowAf'), 'error')
            active[id] = nil
            return
        end
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Deliveries.alreadyDelivering'), 'error')
        TriggerClientEvent('md-drugs:client:setLocation', src, active[id])
        return
    end
    local deliveryLoc = Config.Deliveries.Locations.dropOff[math.random(1, #Config.Deliveries.Locations.dropOff)]
    local item = drugDeliveryItem[math.random(1, #drugDeliveryItem)]
    active[id] = {
        coords = deliveryLoc.coords,
        item = item.item,
        amount = item.amount,
        timestop = os.time() + (15 * 60),
    }
    MySQL.query.await('INSERT INTO deliveriesdealer (cid, itemdata, maxtime, location) VALUES (?, ?, ?, ?)', {
       id, 
        json.encode({item = item.item, amount = item.amount}),
        active[id].timestop,
        json.encode({x = deliveryLoc.coords.x, y = deliveryLoc.coords.y, z = deliveryLoc.coords.z, w = deliveryLoc.coords.w or 180.0}),
    })
    Bridge.Inventory.AddItem(src, item.item, item.amount)
    TriggerClientEvent('md-drugs:client:setLocation', src, active[id])
end)

RegisterNetEvent('md-drugs:server:giveDeliveryItems', function(pedID)
    local src = source
    local id = Bridge.Framework.GetPlayerIdentifier(src)
    if not active[id] then
        return
    end
    if not checkDistance(src, active[id].coords, 5.0, 'md-drugs:server:giveDeliveryItems') then
        return
    end

    if not Bridge.Inventory.RemoveItem(src, active[id].item, active[id].amount) then
        Bridge.Notify.Error(src, Bridge.Language.Locale('Deliveries.deliveryFailed'))
        return
    end

    Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Deliveries.delivery_success'), 'success') 
    AddRep(src, 'dealerrep', 1)
    active[id] = nil
    MySQL.query.await('DELETE FROM deliveriesdealer WHERE cid = ?', {id})
end)