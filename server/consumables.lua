local QBCore = exports['qb-core']:GetCoreObject()

for k, v in pairs(Consumables.Items) do
    QBCore.Functions.CreateUseableItem(k, function(source, item)
        if not Itemcheck(source, k, 1) then return end
        local time = v.time or Consumables.defaulttime
        local effect = v.effect or 0
        local anim = v.anim or Consumables.defaultanim
        local progressbartext = v.progressbartext or Consumables.defaultprogresstext
        local add = v.add or {hunger = 0}
        TriggerClientEvent("md-drugs:client:consumedrugs", source, time, effect, anim, progressbartext, add, k)
    end)
end

RegisterNetEvent('md-drugs:server:removeconsum', function(item)
	RemoveItem(source,item, 1) 
    Log(GetName(source)  .. ' Got High With ' .. item .. '!', 'consuming')
end)

RegisterNetEvent('md-drugs:server:updatestatus', function(stat, statval)
    local Player = getPlayer(source)
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
