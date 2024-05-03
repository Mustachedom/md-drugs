local QBCore = exports['qb-core']:GetCoreObject()
local miss = false
local deliveryBlip = nil

RegisterNetEvent("md-drugs:client:GetLocation", function(drug, notify)
    if GetCops(Config.PoliceCount) then return end
 if miss then
    Notify('Already Called Someone', 'error')
 else   
    TriggerServerEvent('md-drugs:server:RemoveBurner', drug)
    Notify(notify, 'success')
	local unlucky = math.random(1,100)
    local CurrentLocation = Config.oxylocations[math.random(#Config.oxylocations)]
    local timer = 0
    miss = true
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
	repeat
        Wait(1000)
        timer = timer + 1
    until #(GetEntityCoords(PlayerPedId()) - vector3(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z) ) < 4.0 or timer == Config.WholesaleTimeout + 1
    PoliceCall(Config.AlertPoliceWholesale)
    if timer <= Config.WholesaleTimeout or #(GetEntityCoords(PlayerPedId()) - vector3(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z) ) < 4.0  then
        timer = 0
        RemoveBlip(deliveryBlip)
        lib.requestModel("g_m_y_famdnf_01", Config.RequestModelTime)
	    local current = "g_m_y_famdnf_01"
       local drugdealer = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, 90.0, false, false)
        FreezeEntityPosition(drugdealer, true)
        SetEntityInvincible(drugdealer, true)
	        exports['qb-target']:AddTargetEntity(drugdealer, {
           options = {
               {
                   type = "client",
                   label = "Talk To Buyer",
                   icon = "fas fa-eye",
                   action = function()
	        				local luck = math.random(1,100)
	        				local ped = GetEntityCoords(PlayerPedId())
	        				if luck <= Config.SuccessfulChance then
	        					TriggerEvent("md-drugs:client:SuccessSale", drug)
                                Wait(4000)
                                DeleteEntity(drugdealer)
	        				else
	        					TriggerEvent("md-drugs:client:SetUp")
	        					Wait(3000)
	        					SetUpPeds()
                                Wait(4000)
                                DeleteEntity(drugdealer)
	        				end
                            miss = false
	        			end,	
               },
           },
           distance = 2.0
        })
    else
        Notify('The Buyer Waited To Long')
        RemoveBlip(deliveryBlip)
    end
end
end)


RegisterNetEvent("md-drugs:client:SuccessSale", function(drug) 
        if not progressbar("Wholesaling Drugs", 4000, 'uncuff') then return end
        if drug == 'coke' then
            TriggerServerEvent("md-drugs:server:wholesalecoke")
        elseif drug == 'crack' then
            TriggerServerEvent("md-drugs:server:wholesalecrack")
        elseif drug == 'lsd' then 
            TriggerServerEvent("md-drugs:server:wholesalelsd")
        elseif drug == 'heroin' then
            TriggerServerEvent("md-drugs:server:wholesaleheroin")
        elseif drug == 'xtc' then
            TriggerEvent("md-drugs:client:wholesalextc")    
        end
end)


RegisterNetEvent("md-drugs:client:SetUp", function() 
    progressbar("YOU FUCKED NOW", 4000, 'uncuff') 
    SetUpPeds() 
end)
