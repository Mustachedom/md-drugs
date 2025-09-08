local sell = false
local inZone = false
local buyers = {}

local function walkAway(targ)
    FreezeEntityPosition(targ, false)
    ClearPedTasks(targ)
end

local function sellDrug(item, amount, price, targ)
    PoliceCall(20)
    if ps.vehicleData() then
        ps.notify(ps.lang('Cornerselling.inVeh'), 'error')
        walkAway(targ)
        return
    end

    if not ps.progressbar(string.format(ps.lang('Cornerselling.selling', ps.getLabel(item), price)), 4000, 'uncuff') then walkAway(targ) return end
    buyers[targ] = 'sold'
    TriggerServerEvent('md-drugs:server:sellCornerDrugs', item, amount, price)
    walkAway(targ)
 end

local function deny(targ)
     PoliceCall(20)
    buyers[targ] = 'sold'
    if not ps.progressbar(ps.lang('Cornerselling.deny'), 4000, 'argue5') then return end
    walkAway(targ)
end

local function findPed()
    local targ = nil
    repeat
        Wait(100)
        targ = ps.getNearestPed(GetEntityCoords(PlayerPedId()), 8)

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

    ps.drawText(ps.lang('Cornerselling.wait'))

    repeat
        Wait(1000)
        TaskGoToCoordAnyMeans(targ, GetEntityCoords(PlayerPedId()), 1.0, 0, 0, 0, 0)
    until #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(targ)) < 2.0 or sell == false or inZone
    if not sell then return end
    TaskTurnPedToFaceEntity(targ, PlayerPedId(), -1)
    ps.hideText()
    CreateThread(function()
        Wait(45000)
        walkAway(targ)
        buyers[targ] = 'sold'
    end)
    return targ
end

local function checkItems()
    local count = 0
    for k, v in pairs (GlobalState.DrugNames) do
        if ps.hasItem(v) then
            count = count + 1
            break
        end
    end
    if count == 0 then ps.notify(ps.lang('Cornerselling.nodrugs', 'error')) return false end
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

    ps.drawText(ps.lang('Cornerselling.searching'))

    local targ = findPed()
    local data = ps.callback('md-drugs:server:cornerselling:getAvailableDrugs', targ)
    if data == false then
        sell = false
        return
    end

    if data == 'robbed' then
        TaskGoStraightToCoord(targ, -1858.232910, -1242.395630, 8.60510, 100.0, -1, 0.0, 0.0)
        SetPedMoveRateOverride(targ, 10.0)
        local got = false
        ps.entityTarget(targ, {
            {
                label = ps.lang('Cornerselling.targetTakeBack'),
                icon ="fa-solid fa-money-bill",
                action =   function()
                    got = true
                    TriggerServerEvent('md-drugs:server:getBackRobbed')
                    Cornersell()
                end,
                canInteract = function()
                    if IsEntityDead(targ) and not got then
                        return true
                    end
                end,
        }}, nil)
    else
        ps.requestAnim("rcmme_tracey1")
        TaskStartScenarioInPlace(targ, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)
        FreezeEntityPosition(targ, true)
        ps.entityTarget(targ, {
            {
                label = string.format(ps.lang('Cornerselling.targetSell'), data.amount, ps.getLabel(data.item), data.price),
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
                label = ps.lang('Cornerselling.targetDeny'),
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
        ps.hideText()
        ps.notify(ps.lang('Cornerselling.stopped'), 'error')
    else
        sell = true
        ps.notify(ps.lang('Cornerselling.start'), 'success')
        Cornersell()
    end
end)

CreateThread(function()
    for k, v in pairs (QBConfig.NoSellZones) do
        local box = ps.zones.box({ coords = v.loc, size = vec3(v.width, v.length, v.height), rotation = 180.0, debug = false,
        onEnter = function() inZone = true end, onExit = function() inZone = false end})
    end
end)