local QBCore = exports['qb-core']:GetCoreObject()
local cornerselling = false
local hasTarget = false
local lastPed = {}
local stealingPed = nil
local stealData = {}
local availableDrugs = {}
local currentOfferDrug = nil
local CurrentCops = 0
local textDrawn = false
local zoneMade = false

-- Functions
local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function TooFarAway()
    QBCore.Functions.Notify("too far from your corner homie", 'error')
    LocalPlayer.state:set("inv_busy", false, true)
    cornerselling = false
    hasTarget = false
    availableDrugs = {}
end

local function PoliceCallCornerselling()
   print"tell your devs to read the readme. it isnt hard for most people but they are dumb"
end

local function RobberyPed()
    if Config.UseTarget then
        exports['qb-target']:AddTargetEntity(stealingPed, {
            options = {
                {
                    icon = 'fas fa-magnifying-glass',
                    label = "take back",
                    action = function()
                        local player = PlayerPedId()
                        TriggerEvent('animations:client:EmoteCommandStart', {'pickup'}) 
                        Wait(2000)
                        ClearPedTasks(player)
                        TriggerServerEvent('md-drugs:server:giveStealItems', stealData.item, stealData.amount)
                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items[stealData.item], "add")
                        stealingPed = nil
                        stealData = {}
                        ClearPedTasks(PlayerPedId())
                        exports['qb-target']:RemoveZone('stealingPed')
                    end,
                    canInteract = function(entity)
                        if IsEntityDead(entity) then
                            return true
                        end
                    end
                }
            },
            distance = 1.5,
        })
        CreateThread(function()
            while stealingPed do
                local playerPed = PlayerPedId()
                local pos = GetEntityCoords(playerPed)
                local pedpos = GetEntityCoords(stealingPed)
                local dist = #(pos - pedpos)
                if dist > 100 then
                    stealingPed = nil
                    stealData = {}
                    exports['qb-target']:RemoveZone('stealingPed')
                    break
                end
                Wait(0)
            end
        end)
    end
end

local function SellToPed(ped)
    hasTarget = true

    for i = 1, #lastPed, 1 do
        if lastPed[i] == ped then
            hasTarget = false
            return
        end
    end

    local successChance = math.random(1, 100)
    local scamChance = math.random(1, 100)
    local getRobbed = math.random(1, 100)
    if successChance <= QBConfig.SuccessChance then hasTarget = false return end

    local drugType = math.random(1, #availableDrugs)
    local bagAmount = math.random(1, availableDrugs[drugType].amount)
    if bagAmount > 15 then bagAmount = math.random(9, 15) end

    currentOfferDrug = availableDrugs[drugType]

    local ddata = QBConfig.DrugsPrice[currentOfferDrug.item]
    local randomPrice = math.random(ddata.min, ddata.max) * bagAmount
    if scamChance <= QBConfig.ScamChance then randomPrice = math.random(3, 10) * bagAmount end

    SetEntityAsNoLongerNeeded(ped)
    ClearPedTasks(ped)

    local coords = GetEntityCoords(PlayerPedId(), true)
    local pedCoords = GetEntityCoords(ped)
    local pedDist = #(coords - pedCoords)
    if getRobbed <= QBConfig.RobberyChance then
        TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
    else
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
    end

    while pedDist > 1.5 do
        coords = GetEntityCoords(PlayerPedId(), true)
        pedCoords = GetEntityCoords(ped)
        if getRobbed <= QBConfig.RobberyChance then
            TaskGoStraightToCoord(ped, coords, 15.0, -1, 0.0, 0.0)
        else
            TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        end
        TaskGoStraightToCoord(ped, coords, 1.2, -1, 0.0, 0.0)
        pedDist = #(coords - pedCoords)
        Wait(100)
    end

    TaskLookAtEntity(ped, PlayerPedId(), 5500.0, 2048, 3)
    TaskTurnPedToFaceEntity(ped, PlayerPedId(), 5500)
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)

    if hasTarget then
        while pedDist < 3.0 and not IsPedDeadOrDying(ped) do
            local coords2 = GetEntityCoords(PlayerPedId(), true)
            local pedCoords2 = GetEntityCoords(ped)
            local pedDist2 = #(coords2 - pedCoords2)
            if getRobbed <= QBConfig.RobberyChance then
                TriggerServerEvent('md-drugs:server:robCornerDrugs', drugType, bagAmount)
                QBCore.Functions.Notify("You Got Robbed " .. bagAmount .. " Bags of " .. currentOfferDrug.item.. "!")
                stealingPed = ped
                stealData = {
                    item = availableDrugs[drugType].item,
                    drugType = drugType,
                    amount = bagAmount,
                }
                hasTarget = false
                local moveto = GetEntityCoords(PlayerPedId())
                local movetoCoords = {x = moveto.x + math.random(100, 500), y = moveto.y + math.random(100, 500), z = moveto.z, }
                ClearPedTasksImmediately(ped)
                TaskGoStraightToCoord(ped, movetoCoords.x, movetoCoords.y, movetoCoords.z, 15.0, -1, 0.0, 0.0)
                lastPed[#lastPed + 1] = ped
                RobberyPed()
                break
            else
                if pedDist2 < 1.5 and cornerselling then
                    if Config.UseTarget and not zoneMade then
                        zoneMade = true
                        exports['qb-target']:AddTargetEntity(ped, {
                            options = {
                                {
                                    icon = 'fas fa-hand-holding-dollar',
                                    label = "Sell " ..bagAmount.. " of " .. currentOfferDrug.item.. " for " .. randomPrice .. " Dollars! ",
                                    action = function(entity)
									 local playerPed = PlayerPedId()
                                        if IsPedInAnyVehicle(PlayerPedId(), false) then
                                            QBCore.Functions.Notify("youre in a car", 'error')
                                            hasTarget = false
                                            SetPedKeepTask(entity, false)
                                            SetEntityAsNoLongerNeeded(entity)
                                            ClearPedTasksImmediately(entity)
                                            lastPed[#lastPed + 1] = entity

                                            return
                                        else
                                            QBCore.Functions.Progressbar("cornerSelling", "selling Drugs", '5000', false, false, {
                                                disableMovement = true,
                                                disableCarMovement = true,
                                                disableMouse = false,
                                                disableCombat = false,
                                            }, {}, {}, {}, function()
                                                TriggerServerEvent('md-drugs:server:sellCornerDrugs', drugType, bagAmount, randomPrice)
                                                hasTarget = false
                                                TriggerEvent('animations:client:EmoteCommandStart', {'point'}) 
                                                Wait(650)
                                                ClearPedTasks(PlayerPedId())
                                                SetPedKeepTask(entity, false)
                                                SetEntityAsNoLongerNeeded(entity)
                                                ClearPedTasksImmediately(entity)
                                                lastPed[#lastPed + 1] = entity
                                                exports['qb-target']:RemoveZone('sellingPed')
                                                PoliceCallCornerselling()
                                            end)
                                        end
                                    end,
				canInteract = function()
				if IsEntityDead(ped) == false then return true end
				end
                                },
                                {
                                    icon = 'fas fa-x',
                                    label = 'Decline offer',
                                    action = function(entity)
                                        QBCore.Functions.Notify("Fuck that Offer", 'error')
                                        hasTarget = false
                                        SetPedKeepTask(entity, false)
                                        SetEntityAsNoLongerNeeded(entity)
                                        ClearPedTasksImmediately(entity)
                                        lastPed[#lastPed + 1] = entity
                                        exports['qb-target']:RemoveZone('sellingPed')
                                    end,
                                },
                            },
                            distance = 1.5,
                        })
                    end
                else
                    if Config.UseTarget then
                        zoneMade = false
                        exports['qb-target']:RemoveZone('sellingPed')
                    
                    end
                    hasTarget = false
                    SetPedKeepTask(ped, false)
                    SetEntityAsNoLongerNeeded(ped)
                    ClearPedTasksImmediately(ped)
                    lastPed[#lastPed + 1] = ped
                    break
                end
            end
            Wait(0)
        end
        Wait(math.random(4000, 7000))
    end
end

local function ToggleSelling()
    if not cornerselling then
        cornerselling = true
        LocalPlayer.state:set("inv_busy", true, true)
        QBCore.Functions.Notify("get that paper")
        local startLocation = GetEntityCoords(PlayerPedId())
        CreateThread(function()
            while cornerselling do
                local player = PlayerPedId()
                local coords = GetEntityCoords(player)
                if not hasTarget then
                    local PlayerPeds = {}
                    if next(PlayerPeds) == nil then
                        for _, activePlayer in ipairs(GetActivePlayers()) do
                            local ped = GetPlayerPed(activePlayer)
                            PlayerPeds[#PlayerPeds + 1] = ped
                        end
                    end
                    local closestPed, closestDistance = QBCore.Functions.GetClosestPed(coords, PlayerPeds)
                    if closestDistance < 15.0 and closestPed ~= 0 and not IsPedInAnyVehicle(closestPed) and GetPedType(closestPed) ~= 28 then
                        SellToPed(closestPed)
                    end
                end
                local startDist = #(startLocation - coords)
                if startDist > 30 then
                    TooFarAway()
                end
                Wait(0)
            end
        end)
    else
        stealingPed = nil
        stealData = {}
        cornerselling = false
        LocalPlayer.state:set("inv_busy", false, true)
        QBCore.Functions.Notify("lazy ass cant even sell drugs")
    end
end

-- Events
RegisterNetEvent('md-drugs:client:cornerselling', function()
    QBCore.Functions.TriggerCallback('md-drugs:server:cornerselling:getAvailableDrugs', function(result)
        if CurrentCops >= QBConfig.MinimumDrugSalePolice then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                QBCore.Functions.Notify("youre in a car", 'error')
            else
                if result then
                    availableDrugs = result
                    ToggleSelling()
                else
                    QBCore.Functions.Notify("what you gonna sell fuckin air or something?", 'error')
                    LocalPlayer.state:set("inv_busy", false, true)
                end
            end
        else
            QBCore.Functions.Notify("not enough pork", "error")
        end
    end)
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

RegisterNetEvent('md-drugs:client:refreshAvailableDrugs', function(items)
    availableDrugs = items
    if availableDrugs == nil or #availableDrugs <= 0 then
        QBCore.Functions.Notify("no Drugs", 'error')
        cornerselling = false
        LocalPlayer.state:set("inv_busy", false, true)
    end
end)
