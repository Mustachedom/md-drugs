local QBCore = exports['qb-core']:GetCoreObject()
local loc = math.random(1, #Config.Travellingmerchant)
RegisterServerEvent("md-drugs:server:travellingmerchantox", function(amount, money, item, price,table,num)
	local src = source local Player = QBCore.Functions.GetPlayer(src)
	if not table[num]['name'] == item then return end
	if Player.Functions.RemoveMoney(tostring(money), tonumber(price) * tonumber(amount)) then
		AddItem(source, item, amount)
		Log(GetName(source) .. ' Bought ' .. amount .. ' Of ' .. item .. ' For ' .. tonumber(price) * tonumber(amount) .. '!', 'merchant')
	end

end)

lib.callback.register('md-drugs:server:GetMerchant', function(source)
return loc
end)