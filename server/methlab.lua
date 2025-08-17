
local Bags = {}
local function setBucket(src, bucket)
    if src and bucket then
        Player(src).state:set('instance', bucket, true)
        SetPlayerRoutingBucket(src, bucket)
        return true
    else
        return false
    end
end
local function saveBags(src)
    ps.debug('Current', GetEntityRoutingBucket(GetPlayerPed(src)))
    Bags[ps.getIdentifier(src)] = {original = GetEntityRoutingBucket(GetPlayerPed(src)), new = GetEntityRoutingBucket(GetPlayerPed(src)) + 1}
    setBucket(src, Bags[ps.getIdentifier(src)].new)
    ps.debug('New', Bags[ps.getIdentifier(src)].new)
end

local function restoreBags(src)
    local id = ps.getIdentifier(src)
    if Bags[id] then
        setBucket(src, Bags[id].original)
        Bags[id] = nil
    end
end

RegisterNetEvent('TestMethLab', function()
    local src = source
    saveBags(src)
    TriggerClientEvent('md-methlab:client:EnterMethLab', src)
end)

RegisterNetEvent('RestoreMethLab', function()
    local src = source
    restoreBags(src)
end)
