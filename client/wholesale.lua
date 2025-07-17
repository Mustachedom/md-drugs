local miss = false

RegisterNetEvent("md-drugs:client:GetLocation", function(drug)
    if not GetCops(Config.PoliceCount) then return end
    if miss then
       ps.notify(Lang.Wholesale.al, 'error')
    else   
       local loc = drug.location
       local timer = 0
       miss = true
       SetNewWaypoint(loc.x, loc.y)
       lib.requestModel("g_m_y_famdnf_01", Config.RequestModelTime)
    	local current = "g_m_y_famdnf_01"
       local drugdealer = CreatePed(0, current,loc.x,loc.y,loc.z-1, 90.0, false, false)
       FreezeEntityPosition(drugdealer, true)
       SetEntityInvincible(drugdealer, true)
       AddMultiModel(drugdealer, {{
           label = Lang.targets.Wholesale.talk,
           icon = "fas fa-eye",
           action = function()
                local luck = math.random(1,100)
                if luck <= Config.SuccessfulChance then
                    if not ps.progressbar("Wholesaling Drugs", 4000, 'uncuff') then return end
                    TriggerServerEvent("md-drugs:server:SuccessSale", drug)
                else
                    ps.progressbar("YOU FUCKED NOW", 4000, 'uncuff')
                    SetUpPeds() 
                end
                Wait(3000)
                DeleteEntity(drugdealer)
                miss = false
            end
       }},drugdealer )
    	repeat
           Wait(1000)
           timer = timer + 1
       until #(GetEntityCoords(PlayerPedId()) - vector3(loc.x, loc.y, loc.z) ) < 4.0 or timer == Config.WholesaleTimeout + 1
       PoliceCall(Config.AlertPoliceWholesale)
       if timer <= Config.WholesaleTimeout or #(GetEntityCoords(PlayerPedId()) - vector3(loc.x, loc.y, loc.z) ) < 4.0  then
           timer = 0
       else
           ps.notify('The Buyer Waited To Long', 'error')
           DeleteEntity(drugdealer)
       end
    end
end)


