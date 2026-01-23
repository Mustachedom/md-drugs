Locations, Recipes = Locations or {}, Recipes or {}
Recipes.Whippit = {
    cracker = {
        {color = 'blue',    item = 'blue_uninflated_balloon'},
        {color = 'green',   item = 'green_uninflated_balloon'},
        {color = 'orange',  item = 'orange_uninflated_balloon'},
        {color = 'purple',  item = 'purple_uninflated_balloon'},
        {color = 'red',     item = 'red_uninflated_balloon'},
        {color = 'white',   item = 'white_uninflated_balloon'},
        {color = 'yellow',  item = 'yellow_uninflated_balloon'}
    },
    shop = {
        blue_uninflated_balloon =5,
        green_uninflated_balloon =5,
        orange_uninflated_balloon =5,
        purple_uninflated_balloon =5,
        red_uninflated_balloon =5,
        white_uninflated_balloon =5,
        yellow_uninflated_balloon =5,
        cracker =500,
        whipped_cream_cannister =10
    }
}
Locations.Whippit = {
    {loc =vector4(1695.47, 4872.98, 42.16, 288.86), ped = 'ig_priest' },
}

GlobalState.MDDrugsLocations = Locations
GlobalState.MDDrugsRecipes = Recipes


RegisterServerEvent('md-drugs:server:buyWhippitItem', function(loc, item,amount)
    local src = source

    if timeOut(src, 'md-drugs:server:buyWhippitItem') then return end

    if not checkDistance(src, Locations.Whippit[loc].loc, 3.0, 'md-drugs:server:buyWhippitItem') then
        return
    end

    if not Recipes.Whippit.shop[item] then
        Bridge.Prints.Warn(Bridge.Language.Locale('Whippit.invalidItemWarn', Bridge.Framework.GetPlayerIdentifier(src), item))
        return
    end
    local price = Recipes.Whippit.shop[item] * amount
    if not Bridge.Framework.RemoveAccountBalance(src, 'cash', price, 'whippit-shop') then
        return Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Whippit.notEnoughMoney', price), 'error')
    end
    Bridge.Inventory.AddItem(src, item, amount)
end)

Bridge.Framework.RegisterUsableItem('cracker', function(source)
    local src = source
    if not Bridge.Inventory.HasItem(src, 'cracker', 1) then return end
    if not Bridge.Inventory.HasItem(src, 'whipped_cream_cannister', 1) then return end
    local balloonItem, balloonColor = nil, nil
    for _, balloon in pairs(Recipes.Whippit.cracker) do
        if Bridge.Inventory.HasItem(src, balloon.item, 1) then
            balloonItem = balloon.item
            balloonColor = 'ate_balloon_' .. balloon.color
            break
        end
    end
    if not balloonItem then
        return Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Whippit.needBalloon'), 'error')
    end

    if not Bridge.Inventory.RemoveItem(src, 'whipped_cream_cannister', 1) then
        return Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Whippit.needCanister'), 'error')
    end
    if not Bridge.Inventory.RemoveItem(src, balloonItem, 1) then
        return
    end
    Bridge.Callback.Trigger('md-drugs:client:useWhippit', src, balloonColor)
end)