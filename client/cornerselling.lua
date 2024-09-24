local QBCore = exports['qb-core']:GetCoreObject()
local sell = false
local sold = false
local targbusy = false

local function sellDrug(item, amount, price, targ)
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
    if not progressbar('Selling ' .. GetLabel(item) .. '!', 4000, 'uncuff') then return end
    TriggerServerEvent('md-drugs:server:sellCornerDrugs', item, amount, price)
    FreezeEntityPosition(targ, false)
    ClearPedTasks(targ)
    Wait(10000)
    DeletePed(targ)
    targbusy = false
    sold = true
 end

local function deny(targ)
    PoliceCall(20)
    targbusy = true
    if not progressbar('Telling This Dumbass To Leave!', 4000, 'argue5') then return end
    FreezeEntityPosition(targ, false)
    ClearPedTasks(targ)
    Wait(10000)
    DeletePed(targ)
    targbusy = false
    sold = true
end       

function Cornersell()
    local targ = lib.GetClosestPed(GetEntityCoords(PlayerPedId()), 8)
    if targ == nil then return end
    if IsPedInAnyVehicle(targ, false) or GetEntityHealth(targ) == 0 or not IsPedHuman(targ) then return end
    TaskGoToCoordAnyMeans(targ, GetEntityCoords(PlayerPedId()), 1.0, 0, 0, 0, 0)
    repeat
        Wait(1000)
    until #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(targ)) < 2.0
    lib.requestAnimDict("rcmme_tracey1")
    TaskStartScenarioInPlace(targ, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false)
    FreezeEntityPosition(targ, true)
    local item, amount, price = lib.callback.await('md-drugs:server:cornerselling:getAvailableDrugs', false)
        if item == 'nothing' then Notify(' You Aint Got Shit', 'error') sell = false  FreezeEntityPosition(targ, false)  ClearPedTasks(targ) return false end
            local options = { 
                { label = 'Sell ' .. amount .. ' Of ' .. GetLabel(item) .. ' For $' .. price .. '!', icon = "fas fa-eye", 
                    action = function() 
                        sellDrug(item, amount, price, targ)
                    end,
                    onSelect = function()
                        sellDrug(item, amount, price, targ)
                    end,
                    canInteract = function()
                        if not targbusy then return true end end,
                },
                { label = 'Deny Price', icon = "fas fa-eye", 
                action = function() 
                    deny(targ)
                    end,
                onSelect = function() 
                    deny(targ)
                    end,    
                canInteract = function()
                    if not targbusy then return true end end,
                },
            }
            AddMultiModel(targ, options, nil)
    repeat
        Wait(1000)
    until sold 
    if sold then sold = false return true end
end

RegisterNetEvent('md-drugs:client:cornerselling', function()
    if not GetCops(QBConfig.MinimumDrugSalePolice) then return end
    local item, amount, price = lib.callback.await('md-drugs:server:cornerselling:getAvailableDrugs', false)
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

