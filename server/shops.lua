local QBCore = exports['qb-core']:GetCoreObject()
local config = lib.callback.await('md-drugs:server:getLocs', false)
local loc = config.Travellingmerchant[math.random(1, #config.Travellingmerchant)]
local stores = {
	travel = {
		{name = "tab_paper", 	   price = 50, 	amount = 50,	},
		{name = "bakingsoda", 	   price = 25, 	amount = 50, 	},
		{name = "isosafrole", 	   price = 25, 	amount = 50, 	},
		{name = "mdp2p", 		   price = 25, 	amount = 50, 	},
		{name = "lysergic_acid",   price = 25, 	amount = 50, 	},
		{name = "diethylamide",    price = 25, 	amount = 50, 	},
		{name = "lockpick",  	   price = 2, 	amount = 1000, 	},
		{name = "emptyvial", 	   price = 2, 	amount = 1000, 	},
		{name = "needle", 		   price = 2, 	amount = 1000,	},
		{name = "cokeburner", 	   price = 25, 	amount = 50, 	},
		{name = "crackburner", 	   price = 2, 	amount = 50, 	},
		{name = "lsdburner",	   price = 2, 	amount = 50, 	},
		{name = "heroinburner",    price = 2, 	amount = 50, 	},
		{name = "mdlean", 		   price = 50, 	amount = 50, 	},
		{name = "weedgrinder", 	   price = 25, 	amount = 50, 	},
		{name = "mdbutter", 	   price = 25, 	amount = 50, 	},
		{name = "flour", 		   price = 25, 	amount = 50, 	},
		{name = "chocolate",  	   price = 25, 	amount = 50, 	},
		{name = "butane", 		   price = 25, 	amount = 50, 	},
		{name = "butanetorch", 	   price = 2, 	amount = 1000, 	},
		{name = "dabrig", 		   price = 2, 	amount = 1000, 	},
		{name = "mdwoods", 		   price = 2, 	amount = 1000, 	},
		{name = "leancup", 		   price = 25, 	amount = 50, 	},
		{name = "xtcburner", 	   price = 25, 	amount = 50, 	},
	},
	Weed = {
		{name = "weedgrinder", 	price = 25, 	amount = 50, },
		{name = "mdbutter", 	price = 25, 	amount = 50, },
		{name = "flour", 		price = 25, 	amount = 50, },
		{name = "chocolate",  	price = 25, 	amount = 50, },
		{name = "butane", 		price = 25, 	amount = 50, },
		{name = "butanetorch", 	price = 2, 		amount = 1000,},
		{name = "dabrig", 		price = 2, 		amount = 1000,},
		{name = "mdwoods", 		price = 2, 		amount = 1000},
	},
	Products = {
		{name = "weed_white-widow_seed",    price = 15, amount = 150,  minrep = 0},
		{name = "weed_skunk_seed", 		    price = 15, amount = 150,  minrep = 0},
		{name = "weed_purple-haze_seed",	price = 15, amount = 150,  minrep = 0},
		{name = "weed_og-kush_seed", 	    price = 15, amount = 150,  minrep = 0},
		{name = "weed_amnesia_seed", 		price = 15, amount = 150,  minrep = 0},
	},
	ProductsStupidNameRewrite = {
		{name = "weed_whitewidow_seed",   	price = 15, amount = 150, minrep = 0},
		{name = "weed_skunk_seed", 			price = 15, amount = 150, minrep = 0},
		{name = "weed_purplehaze_seed",		price = 15, amount = 150, minrep = 0},
		{name = "weed_ogkush_seed", 	    price = 15, amount = 150, minrep = 0},
		{name = "weed_amnesia_seed", 		price = 15, amount = 150, minrep = 0},
	}
}

lib.callback.register('md-drugs:server:menu', function(source, data)
    local src = source
    if data == 'travellingMerchant' then 
        return {table = stores.travel, des = '$',  id = 'travellingMerchant', title = 'travelling Merchant'}
    elseif data == 'dealermenu' then
        local table 
        if Config.StupidassNewQbItemName then  table = stores.ProductsStupidNameRewrite else table = stores.Products end
            return {table = table,  id = 'dealermenu', title = "Dealer Menu"}
    elseif data == 'WeedShop' then
        return {table = stores.Weed, id = 'WeedShop', title = "Weed Shop"}
    end
end)

RegisterServerEvent("md-drugs:server:purchaseGoods", function(amount, money, item, price,table,num)
	local src = source local Player = getPlayer(src)
	for i = 1, #table do 
		if table[i].name == item then
		if not table[i].price == price then return end
			if Player.Functions.RemoveMoney(tostring(money), tonumber(table[i].price) * tonumber(amount)) then
				AddItem(src, item, amount)
				Log(GetName(src) .. ' Bought ' .. amount .. ' Of ' .. item .. ' For ' .. tonumber(price) * tonumber(amount) .. '!', 'merchant')
			end
		end
	end
end)

lib.callback.register('md-drugs:server:GetMerchant', function(source)
	return loc
end)