local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:givelean', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local chance = math.random(1,100)
	local amount = math.random(1,5)
	if chance <= 50 then 
		if AddItem('mdlean', amount) then
			Notifys(Lang.Lean.lean, "success")
		end
	else
		if AddItem('mdreddextro', amount) then
			Notifys(Lang.Lean.dextro, "success")
		end
	end	
end)
local lean = {'mdlean', 'mdreddextro'}
for k, v in pairs (lean) do 
QBCore.Functions.CreateUseableItem(v, function(source)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if v == 'mdlean' then
		if Player.Functions.GetItemByName('leancup') and Player.Functions.GetItemByName('sprunk') and Player.Functions.GetItemByName('mdlean') then 
			Player.Functions.RemoveItem('mdlean', 1 )
			Player.Functions.RemoveItem('sprunk', 1 )
			Player.Functions.RemoveItem('leancup', 1 )
			Player.Functions.AddItem('cupoflean', 1 )
		end
	else
		if Player.Functions.GetItemByName('leancup') and Player.Functions.GetItemByName('sprunk') and Player.Functions.GetItemByName('mdreddextro') then 
			Player.Functions.RemoveItem('mdreddextro', 1 )
			Player.Functions.RemoveItem('sprunk', 1 )
			Player.Functions.RemoveItem('leancup', 1 )
			Player.Functions.AddItem('cupofdextro', 1 )
		end
	end
end)
end
