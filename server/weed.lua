if not Config.Drugs['weed'] then return end
RegisterNetEvent('md-drugs:server:buyWeedItem', function(loc, name, amount)
	local src = source
    if not checkDistance(src, Config.Weed.Locations.WeedSalesman[loc].loc, 3.5, 'md-drugs:server:buyWeedItem') then
        return
    end
    if not Config.Weed.Recipes.weedStore[name] then
        Bridge.Prints.Warn(Bridge.Language.Locale('weed.itemDoesntExistWarn', Bridge.Framework.GetPlayerIdentifier(src), name))
        return
    end

	if Bridge.Framework.RemoveAccountBalance(src, 'cash', Config.Weed.Recipes.weedStore[name] * amount) or Bridge.Framework.RemoveAccountBalance(src, 'bank', Config.Weed.Recipes.weedStore[name] * amount) then
		Bridge.Inventory.AddItem(src, name, amount)
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notEnoughMoney'), "error")
	end
end)

RegisterServerEvent('md-drugs:server:dryoutweed', function(loc)
	local src = source
    if timeOut(src, 'md-drugs:server:dryoutweed') then return end
    if not checkDistance(src, Config.Weed.Locations.WeedDry[loc].loc, 5.0, 'md-drugs:server:dryoutweed') then
        return
    end
	if Bridge.Inventory.RemoveItem(src,"wetcannabis", 1) then
    	Bridge.Inventory.AddItem(src,"drycannabis", 1)
    else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.noDry'), "error")
	end
end)

local bluntwrap = {'mdreddextro','mdlean'}
for k, v in pairs (bluntwrap) do
	Bridge.Framework.RegisterUsableItem(v, function(source, item) TriggerClientEvent('md-drugs:client:makeBluntWrap', source) end)
end

local bluntwraps = {'leanbluntwrap', 'dextrobluntwrap', 'bluntwrap'}

for k, v in pairs (bluntwraps) do 
	Bridge.Framework.RegisterUsableItem(v, function(source, item) TriggerClientEvent('md-drugs:client:rollBlunt', source) end)
end


RegisterServerEvent('md-drugs:server:MakeWeedItems', function(tabl, item, loc)
	local src = source
    if timeOut(src, 'md-drugs:server:MakeWeedItems') then return end
    local locs = tabl == 'makeButter' and 'MakeButter' or tabl == 'makeOil' and 'MakeOil' or nil
    if not locs then
        Bridge.Prints.Warn(Bridge.Language.Locale('weed.invalidTableWarn', Bridge.Framework.GetPlayerIdentifier(src), tabl))
        return
    end
    if not checkDistance(src, Config.Weed.Locations[locs][loc].loc, 5.0, 'md-drugs:server:MakeWeedItems') then
        return
    end
    local recipe = Config.Weed.Recipes[tabl][item]
    if not recipe then
        Bridge.Prints.Warn(Bridge.Language.Locale('weed.recipeDoesntExistWarn', Bridge.Framework.GetPlayerIdentifier(src), item))
        return
    end
    for k, v in pairs (recipe.recipe) do
        if not Bridge.Inventory.HasItem(src, k, v) then
            Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.missingItem', Bridge.Inventory.GetItemInfo(k).label), "error")
            return
        end
    end
    for k, v in pairs (recipe.recipe) do
        if not Bridge.Inventory.RemoveItem(src, k, v) then
            Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.missingItem', Bridge.Inventory.GetItemInfo(k).label), "error")
            return
        end
    end
    Bridge.Inventory.AddItem(src, item, recipe.amount)
end)


RegisterNetEvent('md-drugs:server:RollBlunt', function(tabl, item)
    local src = source
    if timeOut(src, 'md-drugs:server:RollBlunt') then return end
    local recipe = Config.Weed.Recipes[tabl][item]
    if not recipe then
        Bridge.Prints.Warn(Bridge.Language.Locale('weed.recipeDoesntExistWarn', Bridge.Framework.GetPlayerIdentifier(src), item))
        return
    end
    if not craft(src, recipe) then return end
end)
Bridge.Framework.RegisterUsableItem("dabrig", function(source, item)
    local src = source
    if Bridge.Inventory.HasItem(src, "butanetorch") then
    	if Bridge.Inventory.RemoveItem(src, "shatter", 1) then
        	TriggerClientEvent("md-drugs:client:dodabs", src)
        end
    else
    	Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.needItem', Bridge.Inventory.GetItemInfo("butanetorch").label), 'error')
    end
end)

Bridge.Framework.RegisterUsableItem("weedgrinder", function(source, item)
    local src = source
    if not Bridge.Inventory.HasItem(src, "drycannabis") then 
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.needItem', Bridge.Inventory.GetItemInfo("drycannabis").label), 'error')
        return
    end
    local check = Bridge.Callback.Trigger('md-drugs:client:uncuff', src, 'Grinding Weed')
    if not check then return end
    if Bridge.Inventory.RemoveItem(src, "drycannabis",1 ) then
    	Bridge.Inventory.AddItem(src, "grindedweed", 1)
    end
end)

Bridge.Framework.RegisterUsableItem("mdwoods", function(source, item)
	local src = source
    local check = Bridge.Callback.Trigger('md-drugs:client:uncuff', src, Bridge.Language.Locale('weed.crackBlunt'))
    if not check then return end
	if Bridge.Inventory.RemoveItem(src, "mdwoods",1 ) then
		Bridge.Inventory.AddItem(src, "bluntwrap", 5)
		Bridge.Inventory.AddItem(src, "tobacco", 5)
	end
end)
