local function EcstasyEffect()
    local startStamina = 50
    SetFlash(0, 0, 500, 20000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end
    startStamina = 0
end

ps.registerCallback("md-drugs:client:shrooms", function()
    if not ps.progressbar(ps.lang('shrooms.eat'), 5000, 'eat')  then return end
    CreateThread(function()
        EcstasyEffect()
    end)
    return true
end)