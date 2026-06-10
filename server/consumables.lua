if not Config.Drugs['consumables'] then return end
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
    if type(statval) ~= 'number' or statval ~= statval then return end
    if statval < 0 or statval > 100 then return end
    local hunger, thirst = Player.PlayerData.metadata.hunger, Player.PlayerData.metadata.thirst
    if stat == "thirst" then
        local value = math.min(thirst + statval, 100)
        Player.Functions.SetMetaData('thirst', value)
        TriggerClientEvent('hud:client:UpdateNeeds', src, hunger, value)
    elseif stat == "hunger" then
        local value = math.min(hunger + statval, 100)
        Player.Functions.SetMetaData('hunger', value)
        TriggerClientEvent('hud:client:UpdateNeeds', src, value, thirst)
    elseif stat == "stress" then
        local value = math.max(Player.PlayerData.metadata.stress - statval, 0)
        Player.Functions.SetMetaData('stress', value)
        TriggerClientEvent('hud:client:UpdateStress', src, Player.PlayerData.metadata.stress, value)
    elseif stat == "armor" then
        local value = math.min(Player.PlayerData.metadata.armor + statval, 100)
        TriggerEvent('hospital:server:SetArmor', value)
        TriggerClientEvent('hud:client:UpdateStress', src, Player.PlayerData.metadata.armor, value)
    end
end)
