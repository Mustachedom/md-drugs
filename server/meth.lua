local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:startcook', function()
  local src = source
	if not GetRecipe(source, 'meth', 'cook', 'heat') then return end
	Notifys(src, "Adding Things To The Mix", "success")
	Log(GetName(source) .. ' Started A Meth Batch', 'Meth')
end)

RegisterServerEvent('md-drugs:server:givemethingridients', function()
  local src = source
	local chance = math.random(1,100)
	local amount = math.random(1,5)
	if chance <= 50 then 
		if AddItem(src,'ephedrine', amount) then
			Log(GetName(src) .. ' Got ' .. amount .. ' Of Ephedrine', 'Meth')
		end
	else
		if AddItem(src, 'acetone', amount) then
			Log(GetName(src) .. ' Got ' .. amount .. ' Of Acetone', 'Meth')
		end
	end	
end)

RegisterServerEvent('md-drugs:server:getmeth', function()
  	local src = source
	if not GetRecipe(src, 'meth', 'bag', 'bags') then return end
	Log(GetName(src) .. ' Bagged 5 Of Meth', 'Meth')
end)

RegisterServerEvent('md-drugs:server:geteph', function(num)
	local src = source
		if CheckDist(src, Config.MethEph[num]['loc']) then return end
		if AddItem(src, 'ephedrine', 1) then
			Notifys(src, 'Got Ephedrine!', "success")
			Log(GetName(src) .. ' Got ' .. 1 .. 'Of Ephedrine', 'Meth')
		end
end)
	
RegisterServerEvent('md-drugs:server:getace', function(num)
	local src = source
		if CheckDist(src, Config.Methace[num]['loc']) then return end
		if AddItem(src, 'acetone', 1) then
			Log(GetName(src) .. ' Got ' .. 1 .. 'Of Acetone', 'Meth')
			Notifys(src, 'Got Acetone!', "success")
		end
end)