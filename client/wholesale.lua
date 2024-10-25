local QBCore = exports['qb-core']:GetCoreObject()
local miss = false


RegisterNetEvent("md-drugs:client:GetLocation", function(drug, notify)
    if not GetCops(Config.PoliceCount) then return end
 if miss then
    Notify(Lang.Wholesale.al, 'error')
 else   
    TriggerServerEvent('md-drugs:server:RemoveBurner', drug)
    Notify(notify, 'success')
    local CurrentLocation = Config.oxylocations[math.random(#Config.oxylocations)]
    local timer = 0
    miss = true
    SetNewWaypoint(CurrentLocation.x, CurrentLocation.y)
    lib.requestModel("g_m_y_famdnf_01", Config.RequestModelTime)
	    local current = "g_m_y_famdnf_01"
       local drugdealer = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, 90.0, false, false)
       FreezeEntityPosition(drugdealer, true)
       SetEntityInvincible(drugdealer, true)
       AddSingleModel(drugdealer, {
           type = "client",
           label = Lang.Wholesale.talk,
           icon = "fas fa-eye",
           action = function()
                local luck = math.random(1,100)
                if luck >=101 then
                    TriggerEvent("md-drugs:client:SuccessSale", drug)
                    Wait(4000)
                    DeleteEntity(drugdealer)
                else
                    TriggerEvent("md-drugs:client:SetUp")
                    Wait(3000)
                    DeleteEntity(drugdealer)
                end
                miss = false
            end,	
       },nil )
	repeat
        Wait(1000)
        timer = timer + 1
    until #(GetEntityCoords(PlayerPedId()) - vector3(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z) ) < 4.0 or timer == Config.WholesaleTimeout + 1
    PoliceCall(Config.AlertPoliceWholesale)
    if timer <= Config.WholesaleTimeout or #(GetEntityCoords(PlayerPedId()) - vector3(CurrentLocation.x, CurrentLocation.y, CurrentLocation.z) ) < 4.0  then
        timer = 0
    else
        Notify('The Buyer Waited To Long')
        DeleteEntity(drugdealer)
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
