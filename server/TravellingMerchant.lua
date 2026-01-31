
local loc = Config.Merchant.Locations.Travellingmerchant[math.random(1, #Config.Merchant.Locations.Travellingmerchant)]

Bridge.Callback.Register('md-drugs:server:GetMerchant', function(source)
	return {loc = loc, items = Config.Merchant.stores}
end)



RegisterServerEvent("md-drugs:server:purchaseGoods", function(item)
	local src = source
	if not checkDistance(src, loc, 10, 'md-drugs:server:purchaseGoods') then
		return
	end
	if not Config.Merchant.stores[item] then
		Bridge.Prints.Warn(Bridge.Language.Locale('merchant.itemDoesntExist', Bridge.Framework.GetPlayerIdentifier(src), item))
		return
	end
	if Bridge.Framework.RemoveAccountBalance(src, 'cash', Config.Merchant.stores[item]) then
		Bridge.Inventory.AddItem(src, item, 1)
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notEnoughMoney'), "error")
	end
end)