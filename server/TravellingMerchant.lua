
local Target = {
    Travellingmerchant = {
        vector4(-119.66, -977.43, 304.25, 88.21),
        vector4(-1522.93, 1476.01, 111.45, 41.25),
        vector4(-3278.98, 973.38, 5.35, 101.53),
    },
}

local loc = Target.Travellingmerchant[math.random(1, #Target.Travellingmerchant)]

local stores = {
	travel = {
		tab_paper 	     	= 50,
		bakingsoda 	     	= 25,
		isosafrole 	     	= 25,
		mdp2p 		     	= 25,
		lysergic_acid    	= 25,
		diethylamide     	= 25,
		lockpick  	     	= 2,
		emptyvial 	     	= 2,
		needle 		   	 	= 2,
		cokeburner 	     	= 25,
		crackburner 	 	= 2,
		lsdburner	   	 	= 2,
		heroinburner     	= 2,
		mdlean 		     	= 50,
		weedgrinder 	 	= 25,
		mdbutter 	     	= 25,
		flour 		     	= 25,
		chocolate  	     	= 25,
		butane 		     	= 25,
		butanetorch 	   	= 2,
		dabrig 		   		= 2,
		mdwoods 		   	= 2,
		leancup 		   	= 25,
		xtcburner 	   		= 25,
	},
}

ps.registerCallback('md-drugs:server:GetMerchant', function(source)
	return {loc = loc, items = stores.travel}
end)



RegisterServerEvent("md-drugs:server:purchaseGoods", function(item)
	local src = source
	if not ps.checkDistance(src, loc, 10) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return
	end
	if not stores.travel[item] then
		ps.notify(src, ps.lang('Catches.invalidItem'), "error")
		return
	end
	if ps.removeMoney(src, 'cash', stores.travel[item]) then
		ps.addItem(src, item, 1)
	else
		ps.notify(src, ps.lang('Catches.notEnoughMoney'), "error")
	end
end)