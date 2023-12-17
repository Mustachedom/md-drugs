local QBCore = exports['qb-core']:GetCoreObject()

local deliveryBlip = nil

function PoliceCallWholesale()
    print " tell your devs they didnt do something"
end

RegisterNetEvent("md-drugs:client:getloccoke", function()
    local unlucky = math.random(1, 100)
    local CurrentLocation = Config.oxylocations[math.random(#Config.oxylocations)]
    local unluck = math.random(1, 100)

    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end

    if unlucky <= Config.AlertPoliceWholesale then
        PoliceCallWholesale()
    end

    deliveryBlip = AddBlipForCoord(CurrentLocation)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("drug Meet")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)

    druglocation = CircleZone:Create(CurrentLocation, 5, { name = "cokesell", debugPoly = false })
    druglocation:onPlayerInOut(function(isPointInside) if isPointInside then RemoveBlip(deliveryBlip) end end)

    local current = "g_m_y_famdnf_01"
    lib.requestModel(current, 500)
    drugdealer = CreatePed(0, current, CurrentLocation.x, CurrentLocation.y, CurrentLocation.z - 1, 90.0, false, false)
    FreezeEntityPosition(drugdealer, true)
    SetEntityInvincible(drugdealer, true)

    exports['qb-target']:AddTargetEntity(drugdealer, {
        options = {
            {
                type = "client",
                label = "Talk To Buyer",
                icon = "fas fa-eye",
                action = function()
                    local luck = math.random(1, 100)
                    local ped = GetEntityCoords(PlayerPedId())

                    if luck <= Config.SuccessfulChance then
                        TriggerEvent("md-drugs:client:successsalecoke")
                    else
                        TriggerEvent("md-drugs:client:setupcoke")
                        Wait(3000)
                        SetUpPeds()
                    end
                end,
            },
        },
        distance = 2.0
    })
end)


RegisterNetEvent("md-drugs:client:successsalecoke", function() 
    PlayEmote('uncuff')
    QBCore.Functions.Progressbar("drink_something", "Wholesaling Drugs", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
       TriggerServerEvent("md-drugs:server:wholesalecoke")
	   Citizen.Wait(4000)
		
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:setupcoke", function() 
    PlayEmote('uncuff')
    QBCore.Functions.Progressbar("drink_something", "YOU FUCKED NOW", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

----------heroin
RegisterNetEvent("md-drugs:client:getloccrack", function()
    local unlucky = math.random(1, 100)
    local CurrentLocation = Config.oxylocations[math.random(#Config.oxylocations)]
    local unluck = math.random(1, 100)

    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end

    if unlucky <= Config.AlertPoliceWholesale then
        PoliceCallWholesale()
    end

    deliveryBlip = AddBlipForCoord(CurrentLocation)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("drug Meet")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)

    druglocation = CircleZone:Create(CurrentLocation, 5, { name = "cracksell", debugPoly = false })
    druglocation:onPlayerInOut(function(isPointInside) if isPointInside then RemoveBlip(deliveryBlip) end end)

    local current = "g_m_y_famdnf_01"
    lib.requestModel(current, 500)
    drugdealer = CreatePed(0, current, CurrentLocation.x, CurrentLocation.y, CurrentLocation.z - 1, 90.0, false, false)
    FreezeEntityPosition(drugdealer, true)
    SetEntityInvincible(drugdealer, true)

    exports['qb-target']:AddTargetEntity(drugdealer, {
        options = {
            {
                type = "client",
                label = "Talk To Buyer",
                icon = "fas fa-eye",
                action = function()
                    local luck = math.random(1, 100)
                    local ped = GetEntityCoords(PlayerPedId())

                    if luck <= Config.SuccessfulChance then
                        TriggerEvent("md-drugs:client:successsalecrack")
                    else
                        TriggerEvent("md-drugs:client:setupcrack")
                        Wait(3000)
                        SetUpPeds()
                    end
                end,
            },
        },
        distance = 2.0
    })
end)


RegisterNetEvent("md-drugs:client:successsalecrack", function() 
PlayEmote('uncuff')
QBCore.Functions.Progressbar("drink_something", "Wholesaling Drugs", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
       TriggerServerEvent("md-drugs:server:wholesalecrack")
	   Citizen.Wait(4000)
		
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:setupcrack", function() 
    PlayEmote('uncuff')
    QBCore.Functions.Progressbar("drink_something", "YOU FUCKED NOW", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

----------------------------- heroin
RegisterNetEvent("md-drugs:client:getlocheroin", function()
    local unlucky = math.random(1, 100)
    local CurrentLocation = Config.oxylocations[math.random(#Config.oxylocations)]
    local unluck = math.random(1, 100)

    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end

    if unlucky <= Config.AlertPoliceWholesale then
        PoliceCallWholesale()
    end

    deliveryBlip = AddBlipForCoord(CurrentLocation)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("drug Meet")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)

    druglocation = CircleZone:Create(CurrentLocation, 5, { name = "heroinsell", debugPoly = false })
    druglocation:onPlayerInOut(function(isPointInside) if isPointInside then RemoveBlip(deliveryBlip) end end)

    local current = "g_m_y_famdnf_01"
    lib.requestModel(current, 500)
    drugdealer = CreatePed(0, current, CurrentLocation.x, CurrentLocation.y, CurrentLocation.z - 1, 90.0, false, false)
    FreezeEntityPosition(drugdealer, true)
    SetEntityInvincible(drugdealer, true)

    exports['qb-target']:AddTargetEntity(drugdealer, {
        options = {
            {
                type = "client",
                label = "Talk To Buyer",
                icon = "fas fa-eye",
                action = function()
                    local luck = math.random(1, 100)
                    local ped = GetEntityCoords(PlayerPedId())
                    
                    if luck <= Config.SuccessfulChance then
                        TriggerEvent("md-drugs:client:successsaleheroin")
                    else
                        TriggerEvent("md-drugs:client:setupheroin")
                        Wait(3000)
                        SetUpPeds()
                    end
                end,
            },
        },
        distance = 2.0
    })
end)

RegisterNetEvent("md-drugs:client:successsaleheroin", function() 
    PlayEmote('uncuff')
    QBCore.Functions.Progressbar("drink_something", "Wholesaling Drugs", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
       TriggerServerEvent("md-drugs:server:wholesaleheroin")
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:setupheroin", function() 
    PlayEmote('uncuff')
    QBCore.Functions.Progressbar("drink_something", "YOU FUCKED NOW", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)
---------------------------  lsd
RegisterNetEvent("md-drugs:client:getloclsd", function()
    local unlucky = math.random(1, 100)
    local CurrentLocation = Config.oxylocations[math.random(#Config.oxylocations)]
    local unluck = math.random(1, 100)

    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end

    if unlucky <= Config.AlertPoliceWholesale then
        PoliceCallWholesale()
    end

    deliveryBlip = AddBlipForCoord(CurrentLocation)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("drug Meet")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)

    druglocation = CircleZone:Create(CurrentLocation, 5, { name = "lsdsell", debugPoly = false })
    druglocation:onPlayerInOut(function(isPointInside) if isPointInside then RemoveBlip(deliveryBlip) end end)
    local current = "g_m_y_famdnf_01"
    lib.requestModel(current, 500)
    
    drugdealer = CreatePed(0, current, CurrentLocation.x, CurrentLocation.y, CurrentLocation.z - 1, 90.0, false, false)
    FreezeEntityPosition(drugdealer, true)
    SetEntityInvincible(drugdealer, true)

    exports['qb-target']:AddTargetEntity(drugdealer, {
        options = {
            {
                type = "client",
                label = "Talk To Buyer",
                icon = "fas fa-eye",
                action = function()
                    local luck = math.random(1, 100)
                    local ped = GetEntityCoords(PlayerPedId())

                    if luck <= Config.SuccessfulChance then
                        TriggerEvent("md-drugs:client:successsalelsd")
                    else
                        TriggerEvent("md-drugs:client:setuplsd")
                        Wait(3000)
                        SetUpPeds()
                    end
                end,
            },
        },
        distance = 2.0
    })
end)



RegisterNetEvent("md-drugs:client:successsalelsd", function() 
    PlayEmote('uncuff')
    QBCore.Functions.Progressbar("drink_something", "Wholesaling Drugs", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
       TriggerServerEvent("md-drugs:server:wholesalelsd")
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:setuplsd", function() 
    PlayEmote('uncuff')
    QBCore.Functions.Progressbar("drink_something", "YOU FUCKED NOW", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
		
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)
------------------------- xtc
RegisterNetEvent("md-drugs:client:getlocxtc", function()
    local unlucky = math.random(1, 100)
    local CurrentLocation = Config.oxylocations[math.random(#Config.oxylocations)]
    local unluck = math.random(1, 100)

    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end

    if unlucky <= Config.AlertPoliceWholesale then
        PoliceCallWholesale()
    end

    deliveryBlip = AddBlipForCoord(CurrentLocation)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("drug Meet")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)

    druglocation = CircleZone:Create(CurrentLocation, 5, { name = "xtcsell", debugPoly = false })
    druglocation:onPlayerInOut(function(isPointInside) if isPointInside then RemoveBlip(deliveryBlip) end end)

    local current = "g_m_y_famdnf_01"
    lib.requestModel(current, 500)
    drugdealer = CreatePed(0, current, CurrentLocation.x, CurrentLocation.y, CurrentLocation.z - 1, 90.0, false, false)
    FreezeEntityPosition(drugdealer, true)
    SetEntityInvincible(drugdealer, true)

    exports['qb-target']:AddTargetEntity(drugdealer, {
        options = {
            {
                type = "client",
                label = "Talk To Buyer",
                icon = "fas fa-eye",
                action = function()
                    local luck = math.random(1, 100)
                    local ped = GetEntityCoords(PlayerPedId())

                    if luck <= Config.SuccessfulChance then
                        TriggerEvent("md-drugs:client:successsalextc")
                    else
                        TriggerEvent("md-drugs:client:setupxtc")
                        Wait(3000)
                        SetUpPeds()
                    end
                end,
            },
        },
        distance = 2.0
    })
end)



RegisterNetEvent("md-drugs:client:successsalextc", function() 
    PlayEmote('uncuff')
    QBCore.Functions.Progressbar("drink_something", "Wholesaling Drugs", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
		ClearPedTasks(PlayerPedId())
       TriggerServerEvent("md-drugs:server:wholesalextc")
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:setupxtc", function() 
    PlayEmote('uncuff')
    QBCore.Functions.Progressbar("drink_something", "YOU FUCKED NOW", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
		ClearPedTasks(PlayerPedId())
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)
