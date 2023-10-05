
CreateThread(function() 
local current = "g_m_y_famdnf_01"
       RequestModel(current)
       while not HasModelLoaded(current) do
          Wait(0)
       end
	local CurrentLocation = Config.Travellingmerchant[math.random(#Config.Travellingmerchant)]
	
	 travellingmerchant = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, CurrentLocation.h, false, false)
             FreezeEntityPosition(travellingmerchant, true)
            SetEntityInvincible(travellingmerchant, true)
	exports['qb-target']:AddTargetEntity(travellingmerchant, {
                options = {
                    {
                        type = "client",
                        label = "Travelling Merchant",
                        icon = "fas fa-eye",
                        event = "md-drugs:client:OpenMerchant"
                    },
                },
                distance = 2.0
            })	
end)

RegisterNetEvent('md-drugs:client:OpenMerchant')
AddEventHandler('md-drugs:client:OpenMerchant', function()
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "travelling merchant", Config.Items)
end)
