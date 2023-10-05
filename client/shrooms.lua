local QBCore = exports['qb-core']:GetCoreObject()
local shrooms = {}


function LoadModel(hash)
    hash = GetHashKey(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(3000)
    end
end 

RegisterNetEvent('shrooms:respawnCane', function(loc)
    local v = GlobalState.shrooms[loc]
    local hash = GetHashKey(v.model)
    --if not HasModelLoaded(hash) then LoadModel(hash) end
    if not shrooms[loc] then
        shrooms[loc] = CreateObject(hash, v.location, false, true, true)
        SetEntityAsMissionEntity(shrooms[loc], true, true)
        FreezeEntityPosition(shrooms[loc], true)
        SetEntityHeading(shrooms[loc], v.heading)
        exports['qb-target']:AddTargetEntity(shrooms[loc], {
            options = { {
                    icon = "fas fa-hand",
                    label = "pick shrooms",
                    action = function()
                        QBCore.Functions.Progressbar("pick_cane", "picking shrooms", 2000, false, true, {
                            disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                            { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                            {}, {}, function()
                            TriggerServerEvent("shrooms:pickupCane", loc)
                            ClearPedTasks(PlayerPedId())
                        end, function() -- Cancel
                            ClearPedTasks(PlayerPedId())
                        end)
                    end
                }
            },
            distance = 3.0
        })
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        LoadModel('prop_stoneshroom1')
        TriggerEvent('shrooms:init')
    end
 end)

RegisterNetEvent('shrooms:removeCane', function(loc)
    if DoesEntityExist(shrooms[loc]) then DeleteEntity(shrooms[loc]) end
    shrooms[loc] = nil
end)

 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('prop_stoneshroom1')
     TriggerEvent('shrooms:init')
 end)
 
 RegisterNetEvent("shrooms:init", function()
    for k, v in pairs (GlobalState.shrooms) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            shrooms[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            SetEntityAsMissionEntity(shrooms[k], true, true)
            FreezeEntityPosition(shrooms[k], true)
            SetEntityHeading(shrooms[k], v.heading)
            exports['qb-target']:AddTargetEntity(shrooms[k], {
                options = { {
                        icon = "fas fa-hand",
                        label = "Pick shrooms",
                        action = function()
                            QBCore.Functions.Progressbar("pick_cane", "Picking Shrooms", 2000, false, true, {
                                disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                                { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                                {}, {}, function()
                                TriggerServerEvent("shrooms:pickupCane", k)
                                ClearPedTasks(PlayerPedId())
                            end, function() -- Cancel
                                ClearPedTasks(PlayerPedId())
                            end)
                        end
                    }
                },
                distance = 3.0
            })
        end
    end
end)

function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
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

RegisterNetEvent('md-drugs:client:takeshrooms', function()
    QBCore.Functions.Progressbar("use_lsd", "Have Fun!", 1750, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        EcstasyEffect()
        -- exports["qb-smallresources"]:DoAcid(240000)
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)
