local QBCore = exports['qb-core']:GetCoreObject()
local sell = false
local sold = false
local targbusy = false
local inZone = false

local function reset(targ)
    FreezeEntityPosition(targ, false)
    ClearPedTasks(targ)
    Wait(10000)
    DeletePed(targ)
    targbusy = false
    sold = true
end

local function sellDrug(item, amount, price, targ)
    PoliceCall(20)
    targbusy = true
    if IsPedInAnyVehicle(PlayerPedId(), true) then 
        Notify(Lang.Cornerselling.inveh, 'error') 
        reset(targ)
    return end
    if not progressbar(string.format(Lang.Cornerselling.selling, GetLabel(item), price), 4000, 'uncuff') then return end
    TriggerServerEvent('md-drugs:server:sellCornerDrugs', item, amount, price)
    reset(targ)
 end

local function deny(targ)
    PoliceCall(20)
    targbusy = true
    if not progressbar(Lang.Cornerselling.deny, 4000, 'argue5') then return end
    reset(targ)
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
    TaskStartScenarioInPlace(targ, "WORLD_HUMAN_STAND_IMPATIENT_UPRIGHT", 0, false) FreezeEntityPosition(targ, true)
    local item, amount, price = lib.callback.await('md-drugs:server:cornerselling:getAvailableDrugs', false)
        if item == 'nothing' then Notify(Lang.Cornerselling.nodrugs, 'error') sell = false  FreezeEntityPosition(targ, false)  ClearPedTasks(targ) return false end
            local options = { 
                { label = string.format(Lang.targets.CornerSell.sell, amount, GetLabel(item), price), icon ="fa-solid fa-money-bill",
                    action =   function() sellDrug(item, amount, price, targ) end,
                    canInteract = function()
                        if not targbusy then return true end end,
                },
                { label = Lang.targets.CornerSell.deny, icon = "fa-solid fa-person-harassing",
                    action =    function() deny(targ) end,
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
    if inZone then Notify(Lang.Cornerselling.no, 'error') return end
    local item, amount, price = lib.callback.await('md-drugs:server:cornerselling:getAvailableDrugs', false)
    if item ~= 'nothing' then
        if sell then
            Notify(Lang.Cornerselling.stop, 'error')
            sell = false
        else
            sell = true
            Notify(Lang.Cornerselling.start, 'success')
            repeat
                Wait(1000)
                if not Cornersell() then end
            until not sell
        end
    else
        Notify(Lang.Cornerselling.nodrugs, 'error')
    end
end)

CreateThread(function()
for k, v in pairs (QBConfig.NoSellZones) do
    local box = lib.zones.box({ coords = v.loc, size = vec3(v.width, v.length, v.height), rotation = 180.0, debug = false,
    onEnter = function() inZone = true end, onExit = function() inZone = false end})
end
end)