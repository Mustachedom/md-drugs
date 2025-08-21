

RegisterNetEvent('TestMethLab', function()
    local src = source
    saveBucket(src, 2)
    TriggerClientEvent('md-methlab:client:EnterMethLab', src)
end)

RegisterNetEvent('RestoreMethLab', function()
    local src = source
    restoreBucket(src)
end)
