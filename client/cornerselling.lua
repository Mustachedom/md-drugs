local QBCore = exports['qb-core']:GetCoreObject()
local sell = false

function Cornersell()
    local targ = lib.GetClosestPed(GetEntityCoords(PlayerPedId()), 8)
    if targ == nil then return end
    if IsPedInAnyVehicle(targ, false) or GetEntityHealth(targ) == 0 then return end
    local sold = false
    TaskGoToCoordAnyMeans(targ, GetEntityCoords(PlayerPedId()), 1.0, 0, 0, 0, 0)
    repeat
        Wait(1000)
        
    until #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(targ)) < 2.0
    lib.requestAnimDict("rcmme_tracey1")
    TaskStartScenarioInPlace(targ, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)
    FreezeEntityPosition(targ, true)
    QBCore.Functions.TriggerCallback('md-drugs:server:cornerselling:getAvailableDrugs', function(item, amount)
        if item == 'nothing' then Notify(' You Aint Got Shit', 'error') sell = false  FreezeEntityPosition(targ, false)  ClearPedTasks(targ) return false end
            local bagAmount = math.random(1, amount)
            if bagAmount > 15 then bagAmount = math.random(1,15) end
            local table = QBConfig.DrugsPrice[item]
            local price = math.random(table['min'], table['max'] ) * bagAmount
            local targbusy = false
            local options = {
                { label = 'Sell ' .. bagAmount .. ' Of ' .. QBCore.Shared.Items[item].label .. ' For $' .. price .. '!', icon = "fas fa-eye", 
                    onSelect = function() 
                        PoliceCall(20)
                        targbusy = true
                        if IsPedInAnyVehicle(PlayerPedId(), true) then 
                            Notify('STRANGER DANGER, I WONT GET IN THE CAR WITH YOU', 'error') 
                            FreezeEntityPosition(targ, false)
                            ClearPedTasks(targ)
                            Wait(10000)
                            DeletePed(targ)
                            targbusy = false
                            sold = true
                            sell = false
                        return end
                        if not progressbar('Selling ' .. QBCore.Shared.Items[item].label .. '!', 4000, 'uncuff') then return end
                        TriggerServerEvent('md-drugs:server:sellCornerDrugs', item, bagAmount, price)
                        FreezeEntityPosition(targ, false)
                        ClearPedTasks(targ)
                        Wait(10000)
                        DeletePed(targ)
                        targbusy = false
                        sold = true
                        
                    end,
                canInteract = function()
                    if not targbusy then return true end end,
                 distance = 2.0
                },
                { label = 'Deny Price', icon = "fas fa-eye", 
                    onSelect = function() 
                        PoliceCall(20)
                        targbusy = true
                        if not progressbar('Telling This Dumbass To Leave!', 4000, 'argue5') then return end
                        FreezeEntityPosition(targ, false)
                        ClearPedTasks(targ)
                        Wait(10000)
                        DeletePed(targ)
                        targbusy = false
                        sold = true
                    end,
                canInteract = function()
                    if not targbusy then return true end end,
                 distance = 2.0
                },
            } 
            local optionsqb = {
                { label = 'Sell ' .. bagAmount .. ' Of ' .. QBCore.Shared.Items[item].label .. ' For $' .. price .. '!', icon = "fas fa-eye", 
                    action = function() 
                        PoliceCall(20)
                        targbusy = true
                        if IsPedInAnyVehicle(PlayerPedId(), true) then 
                            Notify('STRANGER DANGER, I WONT GET IN THE CAR WITH YOU', 'error') 
                            FreezeEntityPosition(targ, false)
                            ClearPedTasks(targ)
                            Wait(10000)
                            DeletePed(targ)
                            targbusy = false
                            sold = true
                            sell = false
                        return end
                        if not progressbar('Selling ' .. QBCore.Shared.Items[item].label .. '!', 4000, 'uncuff') then return end
                        TriggerServerEvent('md-drugs:server:sellCornerDrugs', item, bagAmount, price)
                        FreezeEntityPosition(targ, false)
                        ClearPedTasks(targ)
                        Wait(10000)
                        DeletePed(targ)
                        targbusy = false
                        sold = true
                        
                    end,
                canInteract = function()
                    if not targbusy then return true end end,
                 distance = 2.0
                },
                { label = 'Deny Price', icon = "fas fa-eye", 
                action = function() 
                        PoliceCall(20)
                        targbusy = true
                        if not progressbar('Telling This Dumbass To Leave!', 4000, 'argue5') then return end
                        FreezeEntityPosition(targ, false)
                        ClearPedTasks(targ)
                        Wait(10000)
                        DeletePed(targ)
                        targbusy = false
                        sold = true
                    end,
                canInteract = function()
                    if not targbusy then return true end end,
                 distance = 2.0
                },
            } 
            if Config.oxtarget then
                exports.ox_target:addLocalEntity(targ, options)
            else
	            exports['qb-target']:AddTargetEntity(targ, { options = optionsqb, distance = 2.0})
            end  
    end)
    repeat
        Wait(1000)
    until sold 
    if sold then sold = false return true end
end

RegisterNetEvent('md-drugs:client:cornerselling', function()
    if not GetCops(QBConfig.MinimumDrugSalePolice) then return end
    QBCore.Functions.TriggerCallback('md-drugs:server:cornerselling:getAvailableDrugs', function(item, amount)
    if item ~= 'nothing' then
        if sell then 
            Notify('Lazy Ass Cant Even Sell Drugs', 'error')
            sell = false
        else
            sell = true
            Notify('Go Make That Paper', 'success')
            repeat
                Wait(1000)
               if not Cornersell() then end
            until sell == false
        end
    else
        Notify('You Cant Sell Air', 'error')
    end
    end)
end)