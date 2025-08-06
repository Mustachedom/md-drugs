
local Target = {
    Travellingmerchant = { -- where the travelling merchant can spawn
        vector4(-119.66, -977.43, 304.25, 88.21),
        vector4(-1522.93, 1476.01, 111.45, 41.25),
        vector4(-3278.98, 973.38, 5.35, 101.53),
    },
}

local loc = Target.Travellingmerchant[math.random(1, #Target.Travellingmerchant)]

ps.registerCallback('md-drugs:server:GetMerchant', function(source)
	return loc
end)

function getRandW(src)
    local rand = math.random(1, #Target.oxylocations)
    return Target.oxylocations[rand]
end

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

ps.registerCallback('md-drugs:server:menu', function(source, data)
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
				--Log(GetName(src) .. ' Bought ' .. amount .. ' Of ' .. item .. ' For ' .. tonumber(price) * tonumber(amount) .. '!', 'merchant')
			end
		end
	end
end)
