local QBCore = exports['qb-core']:GetCoreObject()

for k, v in pairs (Consumables.Items) do QBCore.Functions.CreateUseableItem(k, function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if v.time == nil then v.time = Consumables.defaulttime end
	if v.effect == nil then v.effect = 0 end
	if v.anim == nil then v.anim = Consumables.defaultanim end
	if v.progressbartext == nil then v.progressbartext = Consumables.defaultprogresstext end
	if v.add == nil then v.add = 'none' end
		 TriggerClientEvent("md-drugs:client:consumedrugs", source, v.time, v.effect, v.anim, v.progressbartext, v.add, k) 
	end)
end

RegisterNetEvent('md-drugs:server:removeconsum', function(item)
	local src = source
		RemoveItem(source,item, 1) 
        Log(GetName(source)  .. ' Got High With ' .. item .. '!', 'consuming')
end)    

RegisterNetEvent('md-drugs:server:updatestatus', function(stat, statval)
    print(stat,statval)
    local Player = QBCore.Functions.GetPlayer(source)
    if stat == "thirst" then
        local value = Player.PlayerData.metadata.thirst + statval
        Player.Functions.SetMetaData('hunger', value)
        TriggerClientEvent('hud:client:UpdateNeeds', source, Player.PlayerData.metadata.hunger, value)
    elseif stat == "hunger" then
        local value = Player.PlayerData.metadata.hunger + statval
        Player.Functions.SetMetaData('thirst', value)
        TriggerClientEvent('hud:client:UpdateNeeds', source, Player.PlayerData.metadata.thirst, value)
    elseif stat == "stress" then 
        local value = Player.PlayerData.metadata.stress + statval
        Player.Functions.SetMetaData('stress', value)
        TriggerClientEvent('hud:client:UpdateStress', source, Player.PlayerData.metadata.stress, value)
    elseif stat == "armor" then
        local value = Player.PlayerData.metadata.armor + statval
        TriggerEvent('hospital:server:SetArmor', value) 
        TriggerClientEvent('hud:client:UpdateStress', source, Player.PlayerData.metadata.armor, value)
    else
    end
end)
