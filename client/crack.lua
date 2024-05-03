local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent("md-drugs:client:makecrackone", function(data)
	if not ItemCheck('bakingsoda') then return end
	if not minigame(2, 8) then TriggerServerEvent("md-drugs:server:failcrackone", data.data) return end
    if not progressbar(Lang.Crack.cookcrack, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:makecrackone", data.data)       
end)



RegisterNetEvent("md-drugs:client:bagcrack", function(data)
	if not ItemCheck('empty_weed_bag') then return end
	if not progressbar(Lang.Crack.bagcrack, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:bagcrack", data.data)
end)

