local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:givelean', function()
	local chance = math.random(1,100)
	local amount = math.random(1,5)
	if chance <= 50 then 
		if AddItem(source, 'mdlean', amount) then
			Notifys(Lang.Lean.lean, "success")
			Log(GetName(source) .. ' Got ' .. amount .. ' Of Lean' , 'lean')
		end
	else
		if AddItem(source, 'mdreddextro', amount) then
			Notifys(Lang.Lean.dextro, "success")
			Log(GetName(source) .. ' Got ' .. amount .. ' Of Red Dextro' , 'lean')
		end
	end	
end)

QBCore.Functions.CreateUseableItem('leancup', function(source, item)
	if Itemcheck(source, 'leancup', 1) then 
		TriggerClientEvent('md-drugs:client:leancraft', source)
	end
end)

RegisterServerEvent('md-drugs:server:finishcup', function(data)
	if not GetRecipe(source, 'lean','cups', data.item) then return end
end)