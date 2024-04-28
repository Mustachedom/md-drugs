local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	local current = "s_m_m_doctor_01"
	lib.requestModel(current, Config.requestModelTime)
	 SyrupLocation = CreatePed(0, current,Config.SyrupVendor.x,Config.SyrupVendor.y,Config.SyrupVendor.z-1, false, false)
    FreezeEntityPosition(SyrupLocation, true)
    SetEntityInvincible(SyrupLocation, true)
	exports['qb-target']:AddTargetEntity(SyrupLocation, {
                options = {
                    {
                        type = "client",
                        label = "Get Task",
                        icon = "fas fa-eye",
                        event = "md-drugs:client:getsyruplocationtobuy"
                    },
                },
                distance = 2.0
            })
end)

RegisterNetEvent("md-drugs:client:getsyruplocationtobuy")
AddEventHandler("md-drugs:client:getsyruplocationtobuy", function() 
SpawnCarPedChase()
QBCore.Functions.Notify("Car Has Been Marked On Your Map", "success")
end)

RegisterNetEvent('md-drugs:client:consumelean', function(itemName)
      QBCore.Functions.Progressbar("use_lsd", "Have Fun!", 1750, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {}, {}, {}, function()
       ClearPedTasks(PlayerPedId())
	TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
			AlienEffect()
			Wait(math.random(1000,5000))
			SetPedToRagdoll(PlayerPedId(), 1000,2000, 2)
			
					
   end)
end)