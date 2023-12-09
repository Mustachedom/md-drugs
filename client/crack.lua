local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-drugs:client:makecrackone", function()
    ProgressBar('Cooking Crack', 4000, 'md-drugs:server:makecrackone', true, 'Its a circle. It Aint Hard', 'md-drugs:server:failcrackone')
end)


RegisterNetEvent("md-drugs:client:bagcrack", function() 
		ProgressBar('bagging some good good', 4000, 'md-drugs:server:bagcrack')
end)

