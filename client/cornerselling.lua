local sell = false
local inZone = false
local buyers = {}

local function walkAway(targ)
    FreezeEntityPosition(targ, false)
    ClearPedTasks(targ)
end

local function sellDrug(item, amount, price, targ)
    PoliceCall(20)
    if IsPedInAnyVehicle(PlayerPedId(), true) then
        Bridge.Notify.SendNotify(Bridge.Language.Locale('Cornerselling.inVeh'), 'error')
        walkAway(targ)
        return
    end

    if not progressbar(Bridge.Language.Locale('Cornerselling.selling', Bridge.Inventory.GetItemInfo(item).label, price), 4000, 'uncuff') then
        walkAway(targ)
        return
    end
    buyers[targ] = 'sold'
    TriggerServerEvent('md-drugs:server:sellCornerDrugs', item, amount, price, NetworkGetNetworkIdFromEntity(targ))
    walkAway(targ)
 end

local function deny(targ)
    PoliceCall(20)
    buyers[targ] = 'sold'
    if not progressbar(Bridge.Language.Locale('Cornerselling.deny'), 4000, 'argue5') then return end
    walkAway(targ)
end

local function getClosestPed()
        local coords = GetEntityCoords(PlayerPedId())
        local distance = 10.0
        local pedList = GetGamePool('CPed')
        local closestDistance = 1000.0
        local PED = nil
        for i = 1, #pedList do
            local ped = pedList[i]
            if ped ~= PlayerPedId() then
                local pedCoords = GetEntityCoords(ped)
                local dist = #(coords - pedCoords)
                if dist < closestDistance then
                    PED = ped
                    closestDistance = dist
                end
            end
        end
        if PED and closestDistance < distance then
            return PED, closestDistance
        else
            return nil
        end
end
local function findPed()
    local targ = nil
    repeat
        Wait(100)
        targ = getClosestPed()
        if IsPedInAnyVehicle(targ, false) or GetEntityHealth(targ) == 0 or not IsPedHuman(targ) then
            targ = nil
        end
        if buyers[targ] then
            targ = nil
        end
        if inZone then
            targ = nil
        end
    until targ ~= nil or sell == false
    if not sell then return end
    buyers[targ] = true

    Bridge.HelpText.ShowHelpText(Bridge.Language.Locale('Cornerselling.wait'))

    repeat
        Wait(1000)
        TaskGoToCoordAnyMeans(targ, GetEntityCoords(PlayerPedId()), 1.0, 0, 0, 0, 0)
    until #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(targ)) < 2.0 or sell == false or inZone

    if not sell then return end

    TaskTurnPedToFaceEntity(targ, PlayerPedId(), -1)
    Bridge.HelpText.HideHelpText()
    CreateThread(function()
        Wait(45000)
        walkAway(targ)
        buyers[targ] = 'sold'
    end)
    return targ
end

local function checkItems()
    local has = false
    for k, v in pairs (GlobalState.DrugNames) do
        if Bridge.Inventory.HasItem(v) then
            has = true
            break
        end
    end
    if not has then
        Bridge.Notify.SendNotify(Bridge.Language.Locale('Cornerselling.nodrugs', 'error'))
        return false
    end
    return true
end

local function Cornersell()
    if inZone then sell = false return end

    if not sell then
        return
    end

    local hasDrugs = checkItems()
    if not hasDrugs then
        sell = false
        return
    end

    Bridge.HelpText.ShowHelpText(Bridge.Language.Locale('Cornerselling.searching'))

    local targ = findPed()
    local data = Bridge.Callback.Trigger('md-drugs:server:cornerselling:getAvailableDrugs', NetworkGetNetworkIdFromEntity(targ))
    if data == false then
        sell = false
        return
    end

    if data == 'robbed' then
        TaskGoStraightToCoord(targ, -1858.232910, -1242.395630, 8.60510, 100.0, -1, 0.0, 0.0)
        SetPedMoveRateOverride(targ, 10.0)
        local got = false
        Bridge.Target.AddLocalEntity(targ, {
            {
                label = Bridge.Language.Locale('Cornerselling.targetTakeBack'),
                icon ="fa-solid fa-money-bill",
                action =   function()
                    got = true
                    TriggerServerEvent('md-drugs:server:getBackRobbed',  NetworkGetNetworkIdFromEntity(targ))
                    Cornersell()
                end,
                canInteract = function()
                    if IsEntityDead(targ) and not got then
                        return true
                    end
                end,
            }
        })
    else
        Bridge.Anim.RequestDict("rcmme_tracey1")
        TaskStartScenarioInPlace(targ, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)
        FreezeEntityPosition(targ, true)
        Bridge.Target.AddLocalEntity(targ, {
            {
                label = Bridge.Language.Locale('Cornerselling.targetSell', data.amount, Bridge.Inventory.GetItemInfo(data.item).label, data.price),
                icon ="fa-solid fa-money-bill",
                action =   function()
                    sellDrug(data.item, data.amount, data.price, targ)
                    Cornersell()
                end,
                canInteract = function()
                    if buyers[targ] ~= 'sold' and sell then
                        return true
                    end
                end,
            },
            {
                label = Bridge.Language.Locale('Cornerselling.targetDeny'),
                icon = "fa-solid fa-person-harassing",
                action = function()
                    deny(targ)
                    walkAway(targ)
                    Cornersell()
                end,
                canInteract = function()
                    if buyers[targ] == true and sell then
                        return true
                    end
                end
            }
        })
    end
end

RegisterNetEvent('md-drugs:client:cornerselling', function()
    if sell then
        sell = false
        Bridge.HelpText.HideHelpText()
        Bridge.Notify.SendNotify(Bridge.Language.Locale('Cornerselling.stopped'), 'error')
    else
        sell = true
        Bridge.Notify.SendNotify(Bridge.Language.Locale('Cornerselling.start'), 'success')
        Cornersell()
    end
end)

CreateThread(function()
    for k, v in pairs (QBConfig.NoSellZones) do
        local box = ps.zones.box({ coords = v.loc, size = vec3(v.width, v.length, v.height), rotation = 180.0, debug = false,
        onEnter = function() inZone = true end, onExit = function() inZone = false end})
    end
end)
