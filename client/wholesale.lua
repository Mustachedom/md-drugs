local QBCore = exports['qb-core']:GetCoreObject()
local miss = false


RegisterNetEvent("md-drugs:client:GetLocation", function(drug)
    if not GetCops(Config.PoliceCount) then return end
 if miss then
    Notify(Lang.Wholesale.al, 'error')
 else   
    local CurrentLocation = drug.location
    local timer = 0
    miss = true
    SetNewWaypoint(CurrentLocation.x, CurrentLocation.y)
    lib.requestModel("g_m_y_famdnf_01", Config.RequestModelTime)
	   local current = "g_m_y_famdnf_01"
       local drugdealer = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, 90.0, false, false)
       FreezeEntityPosition(drugdealer, true)
       SetEntityInvincible(drugdealer, true)
       AddMultiModel(drugdealer, {{
           label = Lang.targets.Wholesale.talk,
           icon = "fas fa-eye",
           action = function()
                local luck = math.random(1,100)
                if luck <= Config.SuccessfulChance then
                    TriggerEvent("md-drugs:client:SuccessSale", drug)
                else
                    TriggerEvent("md-drugs:client:SetUp", drug)
                end
                Wait(3000)
                DeleteEntity(drugdealer)
                miss = false
            end
       }},drugdealer )
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
    TriggerServerEvent("md-drugs:server:SuccessSale", drug)
end)

RegisterNetEvent("md-drugs:client:SetUp", function(drug) 
    progressbar("YOU FUCKED NOW", 4000, 'uncuff')
    TriggerServerEvent("md-drugs:server:SetUp", drug)
    SetUpPeds() 
end)
