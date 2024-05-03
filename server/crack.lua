local QBCore = exports['qb-core']:GetCoreObject()


RegisterServerEvent('md-drugs:server:makecrackone', function(num)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.makecrack[num]['loc']) then end
	if not Itemcheck(Player, 'bakingsoda', 1, 'true') then return end
	if Config.TierSystem then
		local locoke = Player.Functions.GetItemByName('loosecoke')
		local locoke2 = Player.Functions.GetItemByName('loosecokestagetwo')
		local locoke3 = Player.Functions.GetItemByName('loosecokestagethree')
		if locoke then
			RemoveItem('loosecoke', 1 ) 
			RemoveItem('bakingsoda', 1) 
			AddItem('crackrock', 1) 
			Notifys(Lang.Crack.makecrack, "success")
		elseif locoke2 then
			RemoveItem('loosecokestagetwo', 1 ) 
			RemoveItem('bakingsoda', 1) 
			AddItem('crackrockstagetwo', 1) 
			Notifys(Lang.Crack.makecrack, "success")
		elseif locoke3 then
			RemoveItem('loosecokestagethree', 1 ) 
			RemoveItem('bakingsoda', 1) 
			AddItem('crackrockstagethree', 1) 
			Notifys(Lang.Crack.makecrack, "success")
		else
			Notifys(Lang.Crack.nocoke, 'error')
		end			
	else
		if RemoveItem('loosecoke', 1 ) then
			RemoveItem('bakingsoda', 1) 
			AddItem('crackrock', 1) 
			Notifys(Lang.Crack.makecrack, "success")
		else
			Notifys(Lang.Crack.nocoke, 'error')
		end
	end
end)

RegisterServerEvent('md-drugs:server:bagcrack', function(num)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
	if CheckDist(source, playerPed, Config.bagcrack[num]['loc']) then  return end
	if not Itemcheck(Player, 'empty_weed_bag', 1, 'true') then return end
	if Config.TierSystem then
		local rock = Player.Functions.GetItemByName('crackrock')
		local rock2 = Player.Functions.GetItemByName('crackrockstagetwo')
		local rock3 = Player.Functions.GetItemByName('crackrockstagethree')
		if rock then
			RemoveItem('crackrock', 1 ) 
			RemoveItem('empty_weed_bag', 1) 	
			AddItem('baggedcracked', 1) 
			Notifys(Lang.Crack.makecrack, "success")
		elseif rock2 then
			 RemoveItem('crackrockstagetwo', 1 ) 
			RemoveItem('empty_weed_bag', 1) 
			AddItem('baggedcrackedstagetwo', 1) 
			Notifys(Lang.Crack.makecrack, "success")
		elseif rock3 then
			RemoveItem('crackrockstagethree', 1 ) 
			RemoveItem('empty_weed_bag', 1) 
			AddItem('baggedcrackedstagethree', 1) 
			Notifys(Lang.Crack.makecrack, "success")
		else
			Notifys(Lang.Crack.nocoke, "error")
		end
	else
		if RemoveItem('crackrock', 1 ) then
			RemoveItem('empty_weed_bag', 1) 
			AddItem('baggedcracked', 1) 
			Notifys(Lang.Crack.makecrack, "success")
		else
			Notifys(Lang.Crack.nocoke, "error")
		end
	end
end)