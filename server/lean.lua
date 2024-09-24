local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:givelean', function()
	local src = source
	local chance = math.random(1,100)
	local amount = math.random(1,5)
	if chance <= 50 then 
		if AddItem(src, 'mdlean', amount) then
			Notifys(Lang.Lean.lean, "success")
			Log(GetName(src) .. ' Got ' .. amount .. ' Of Lean' , 'lean')
		end
	else
		if AddItem(src, 'mdreddextro', amount) then
			Notifys(Lang.Lean.dextro, "success")
			Log(GetName(src) .. ' Got ' .. amount .. ' Of Red Dextro' , 'lean')
		end
	end	
end)

QBCore.Functions.CreateUseableItem('leancup', function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Itemcheck(src, 'leancup', 1) then 
		TriggerClientEvent('md-drugs:client:leancraft', src)
	end
end)

RegisterServerEvent('md-drugs:server:finishcup', function(data)
	local src = source
	if not GetRecipe(source, 'lean','cups', data.item) then return end
end)