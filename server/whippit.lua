
local itemCraft = {
    cracker = {
        {color = 'blue',    item = 'blue_uninflated_balloon'},
        {color = 'green',   item = 'green_uninflated_balloon'},
        {color = 'orange',  item = 'orange_uninflated_balloon'},
        {color = 'purple',  item = 'purple_uninflated_balloon'},
        {color = 'red',     item = 'red_uninflated_balloon'},
        {color = 'white',   item = 'white_uninflated_balloon'},
        {color = 'yellow',  item = 'yellow_uninflated_balloon'}
    }
}
local store = {
    {loc =vector4(1695.47, 4872.98, 42.16, 288.86), ped = 'ig_priest' },
}
ps.registerCallback('md-drugs:server:getWhippitLocations', function(source)
    return store
end)
local itemShop = {
    blue_uninflated_balloon = 5,
    green_uninflated_balloon = 5,
    orange_uninflated_balloon = 5,
    purple_uninflated_balloon = 5,
    red_uninflated_balloon = 5,
    white_uninflated_balloon = 5,
    yellow_uninflated_balloon = 5,
    cracker = 500,
    whipped_cream_cannister = 10
}

ps.registerCallback('md-drugs:server:getwhippitShop', function(source)
    return itemShop
end)

RegisterServerEvent('md-drugs:server:buyWhippitItem', function(loc, item,amount)
    local src = source
    if not ps.checkDistance(src, store[loc].loc, 3.0) then return end
    if not itemShop[item] then return end
    local price = itemShop[item] * amount
    if not ps.removeMoney(src, 'cash', price, 'whippit-shop') then
        return ps.notify(src, ps.lang('Whippit.notEnoughMoney', price), 'error')
    end
    ps.addItem(src, item, amount)
end)

ps.createUseable('cracker', function(source)
    local src = source
    if not ps.hasItem(src, 'cracker', 1) then return end
    if not ps.hasItem(src, 'whipped_cream_cannister', 1) then return end
    local balloonItem, balloonColor = nil, nil
    for _, balloon in pairs(itemCraft['cracker']) do
        if ps.hasItem(src, balloon.item, 1) then
            balloonItem = balloon.item
            balloonColor = 'ate_balloon_' .. balloon.color
            break
        end
    end
    if not balloonItem then
        return ps.notify(src, ps.lang('Whippit.needBalloon'), 'error')
    end

    if not ps.removeItem(src, 'whipped_cream_cannister', 1) then
        return ps.notify(src, ps.lang('Whippit.needCanister'), 'error')
    end
    if not ps.removeItem(src, balloonItem, 1) then
        return ps.warn(src, 'Failed to remove balloon', 'error')
    end
    ps.callback('md-drugs:client:useWhippit', src, balloonColor)
end)