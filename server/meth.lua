local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:startcook', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
	if not Itemcheck(Player, 'ephedrine', 1, 'true') and Itemcheck(Player, 'acetone', 1, 'true') then return end
	Notifys("Adding Things To The Mix", "success")
	RemoveItem('ephedrine', 1)
	RemoveItem('acetone', 1)
end)

RegisterServerEvent('md-drugs:server:givemethingridients', function()
  local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,100)
	local amount = math.random(1,5)
	if chance <= 50 then 
		if AddItem('ephedrine', amount) then
			Notifys(Lang.meth.eph, "success")
			
		end
	else
		if AddItem('acetone', amount) then
			Notifys(Lang.meth.ace, "success")
		end
	end	
end)

RegisterServerEvent('md-drugs:server:getmeth', function()
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local amount = math.random(1,5)
 
  if RemoveItem("empty_weed_bag", amount) then
		AddItem("methbags", amount)
		Notifys("You Made " .. amount .. " Bags Of Meth!", "success")
	else
		Notifys(Lang.meth.nobag, "error")
	end
end)

RegisterServerEvent('md-drugs:server:geteph', function(num)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
		if CheckDist(source, playerPed, Config.MethEph[num]['loc']) then return end
		if AddItem('ephedrine', 1) then
			Notifys('Got Ephedrine!', "success")
		end
end)
	
RegisterServerEvent('md-drugs:server:getace', function(num)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local playerPed = GetPlayerPed(source)
		if CheckDist(source, playerPed, Config.Methace[num]['loc']) then return end
		if AddItem('acetone', 1) then
			Notifys('Got Acetone!', "success")
		end
end)