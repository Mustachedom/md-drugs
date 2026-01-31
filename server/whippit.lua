

RegisterServerEvent('md-drugs:server:buyWhippitItem', function(loc, item,amount)
    local src = source

    if timeOut(src, 'md-drugs:server:buyWhippitItem') then return end

    if not checkDistance(src, Config.Whippit.Locations.Whippit[loc].loc, 3.0, 'md-drugs:server:buyWhippitItem') then
        return
    end

    if not Config.Whippit.Recipes.shop[item] then
        Bridge.Prints.Warn(Bridge.Language.Locale('Whippit.invalidItemWarn', Bridge.Framework.GetPlayerIdentifier(src), item))
        return
    end
    local price = Config.Whippit.Recipes.shop[item] * amount
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
    for _, balloon in pairs(Config.Whippit.Recipes.cracker) do
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