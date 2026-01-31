
for k, v in pairs(Config.Consumables.Consume) do
    Bridge.Framework.RegisterUsableItem(k, function(source, item)
        if not Bridge.Inventory.HasItem(source, k, 1) then return end
        local time = v.time or Config.Consumables.Defaults.time
        local effect = v.effect or 0
        local anim = v.anim or Config.Consumables.Defaults.defaultAnim
        local progressbartext = v.progressbartext or Config.Consumables.Defaults.defaultText
        local add = v.add or {hunger = 0}
        local done = Bridge.Callback.Trigger('md-drugs:client:consumedrugs', source, time, effect, anim, progressbartext, add, k)
        if done then
            Bridge.Inventory.RemoveItem(source, k, 1)
        end
    end)
end

RegisterNetEvent('md-drugs:server:updatestatus', function(stat, statval)
    local src = source
    local Player = Bridge.Framework.GetPlayer(src)
    if GetResourceState('es_extended') == 'started' then return end
    local hunger, thirst = Player.PlayerData.metadata.hunger, Player.PlayerData.metadata.thirst
    if stat == "thirst" then
        local value = thirst + statval
        Player.Functions.SetMetaData('thirst', value)
        TriggerClientEvent('hud:client:UpdateNeeds', src, hunger, value)
    elseif stat == "hunger" then
        local value = hunger + statval
        Player.Functions.SetMetaData('hunger', value)
        TriggerClientEvent('hud:client:UpdateNeeds', src, value, thirst)
    elseif stat == "stress" then
        local value = Player.PlayerData.metadata.stress + statval
        Player.Functions.SetMetaData('stress', value)
        TriggerClientEvent('hud:client:UpdateStress', src, Player.PlayerData.metadata.stress, value)
    elseif stat == "armor" then
        local value = Player.PlayerData.metadata.armor + statval
        TriggerEvent('hospital:server:SetArmor', value)
        TriggerClientEvent('hud:client:UpdateStress', src, Player.PlayerData.metadata.armor, value)
    end
end)
