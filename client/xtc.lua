local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-drugs:client:setpressquad", function() 
local PedCoords = GetEntityCoords(cache.ped)
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
	Wait(4000)
	ClearPedTasks(cache.ped)
	quadpress = CreateObject("bkr_prop_coke_press_01b", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
	PlaceObjectOnGroundProperly(quadpress)
	exports['qb-target']:AddTargetEntity(quadpress, {
    options = {
        {
			event = "md-drugs:client:makextcquad",
			icon = 'fas fa-eye',
			label = 'Make White quad Stack', 
			
		},
		{
			event = "md-drugs:client:makeredxtcquad",
			icon = 'fas fa-eye',
			label = 'Make Red quad Stack', 
			
		},
		{ 
			event = "md-drugs:client:makeorangextcquad",
			icon = 'fas fa-eye',
			label = 'Make orange quad Stack',
		},
		{ 
			event = "md-drugs:client:makebluextcquad",
			icon = 'fas fa-eye',
			label = 'Make blue quad Stack',
		},
		{
            event = "md-drugs:client:getquadpressback",
            icon = "fas fa-eye",
            label = "Pick Up",
        },
    }
  })
end)

RegisterNetEvent("md-drugs:client:setpresstriple", function() 
local PedCoords = GetEntityCoords(cache.ped)
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
	Wait(4000)
	ClearPedTasks(cache.ped)
	triplepress = CreateObject("bkr_prop_coke_press_01b", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
	PlaceObjectOnGroundProperly(triplepress)
	exports['qb-target']:AddTargetEntity(triplepress, {
    options = {
        {
			event = "md-drugs:client:makextctriple",
			icon = 'fas fa-eye',
			label = 'Make White triple Stack',
		},
		{
			event = "md-drugs:client:makeredxtctriple",
			icon = 'fas fa-eye',
			label = 'Make Red triple Stack',
		},
		{
			event = "md-drugs:client:makeorangextctriple",
			icon = 'fas fa-eye',
			label = 'Make orange triple Stack',
		},
		{ 
			event = "md-drugs:client:makebluextctriple",
			icon = 'fas fa-eye',
			label = 'Make blue triple Stack',
		},
		{
            event = "md-drugs:client:gettriplepressback",
            icon = "fas fa-eye",
            label = "Pick Up",
        },
    }
     })
end)

RegisterNetEvent("md-drugs:client:setpressdual", function() 
local PedCoords = GetEntityCoords(cache.ped)
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
	Wait(4000)
	ClearPedTasks(cache.ped)
	dualpress = CreateObject("bkr_prop_coke_press_01b", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
	PlaceObjectOnGroundProperly(dualpress)
	exports['qb-target']:AddTargetEntity(dualpress, {
    options = {
        {
			event = "md-drugs:client:makextcdual",
			icon = 'fas fa-eye',
			label = 'Make White dual Stack',

		},
		{
			event = "md-drugs:client:makeredxtcdual",
			icon = 'fas fa-eye',
			label = 'Make Red dual Stack',

		},
		{ 
			event = "md-drugs:client:makeorangextcdual",
			icon = 'fas fa-eye',
			label = 'Make orange dual Stack',

		},
		{ 
			event = "md-drugs:client:makebluextcdual",
			icon = 'fas fa-eye',
			label = 'Make blue dual Stack',
		},
		{
            event = "md-drugs:client:getdualpressback",
            icon = "fas fa-eye",
            label = "Pick Up",
        },
    }
	})
end)

RegisterNetEvent("md-drugs:client:setpresssingle", function() 
local PedCoords = GetEntityCoords(cache.ped)
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
	Wait(4000)
	ClearPedTasks(cache.ped)
	singlepress = CreateObject("bkr_prop_coke_press_01aa", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
	PlaceObjectOnGroundProperly(singlepress)
	exports['qb-target']:AddTargetEntity(singlepress, {
    options = {
        {
			event = "md-drugs:client:makextcsingle",
			icon = 'fas fa-eye',
			label = 'Make White Single Stack', 
			
		},
		{
			event = "md-drugs:client:makeredxtcsingle",
			icon = 'fas fa-eye',
			label = 'Make Red Single Stack', 
			
		},
		{ 
			event = "md-drugs:client:makeorangextcsingle",
			icon = 'fas fa-eye',
			label = 'Make orange Single Stack', 
			
		},
		{ 
			event = "md-drugs:client:makebluextcsingle",
			icon = 'fas fa-eye',
			label = 'Make blue Single Stack', 
			
		},
		{
            event = "md-drugs:client:getsinglepressback",
            icon = "fas fa-eye",
            label = "Pick Up",
        },
    }
 })
end)

RegisterNetEvent("md-drugs:client:getsinglepressback", function() 
DeleteObject(singlepress)
TriggerServerEvent("md-drugs:server:getsinglepressback")
ClearPedTasks(cache.ped)
end)

RegisterNetEvent("md-drugs:client:getdualpressback", function() 
DeleteObject(dualpress)
TriggerServerEvent("md-drugs:server:getdualpressback")
ClearPedTasks(cache.ped)
end)

RegisterNetEvent("md-drugs:client:gettriplepressback", function() 
DeleteObject(triplepress)
TriggerServerEvent("md-drugs:server:gettriplepressback")
ClearPedTasks(cache.ped)
end)

RegisterNetEvent("md-drugs:client:getquadpressback", function() 
DeleteObject(quadpress)
TriggerServerEvent("md-drugs:server:getquadpressback")
ClearPedTasks(cache.ped)
end)

RegisterNetEvent("md-drugs:client:stealisosafrole", function()
	ProgressBar('Stealing Isosafrole', 4000, 'md-drugs:server:stealisosafrole', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:stealmdp2p", function() 
	ProgressBar('Stealing MDP2P', 4000, 'md-drugs:server:stealmdp2p', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makingrawxtc", function() 
	ProgressBar('Making Raw Ecstacy', 4000, 'md-drugs:server:makingrawxtc', true, 'Its a circle. It Aint Hard')
end)
---------------------------- unstamped just xtc
RegisterNetEvent("md-drugs:client:makextcsingle", function() 
	ProgressBar('Making Unstamped Single Stack Ecstacy', 4000, 'md-drugs:server:makextcsingle', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makextcdual", function() 
	ProgressBar('Making Unstamped Dual Stack Ecstacy', 4000, 'md-drugs:server:makextcdual', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makextctriple", function() 
	ProgressBar('Making Unstamped Triple Stack Ecstacy', 4000, 'md-drugs:server:makextctriple', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makextcquad", function() 
	ProgressBar('Making Unstamped Quad Stack Ecstacy', 4000, 'md-drugs:server:makextcquad', true, 'Its a circle. It Aint Hard')
end)
------------------------------------------------- 
RegisterNetEvent("md-drugs:client:makeredxtcsingle", function() 
	ProgressBar('Making Unstamped Red Single Stack Ecstacy', 4000, 'md-drugs:server:makeredxtcsingle', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makeredxtcdual", function() 
	ProgressBar('Making Unstamped Red Dual Stack Ecstacy', 4000, 'md-drugs:server:makeredxtcdual', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makeredxtctriple", function() 
	ProgressBar('Making Unstamped Red Triple Stack Ecstacy', 4000, 'md-drugs:server:makeredxtctriple', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makeredxtcquad", function() 
	ProgressBar('Making Unstamped Red Quad Stack Ecstacy', 4000, 'md-drugs:server:makeredxtcquad', true, 'Its a circle. It Aint Hard')
end)
--------------------------------------------------------------- making orange unstamped
RegisterNetEvent("md-drugs:client:makeorangextcsingle", function() 
	ProgressBar('Making Unstamped Orange Single Stack Ecstacy', 4000, 'md-drugs:server:makeorangextcsingle', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makeorangextcdual", function() 
	ProgressBar('Making Unstamped Orange Dual Stack Ecstacy', 4000, 'md-drugs:server:makeorangextcdual', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makeorangextctriple", function() 
	ProgressBar('Making Unstamped Orange Triple Stack Ecstacy', 4000, 'md-drugs:server:makeorangextctriple', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makeorangextcquad", function() 
	ProgressBar('Making Unstamped Orange Quad Stack Ecstacy', 4000, 'md-drugs:server:makeorangextcquad', true, 'Its a circle. It Aint Hard')
end)
--------------------------------------- blue unstamped
RegisterNetEvent("md-drugs:client:makebluextcsingle", function() 
	ProgressBar('Making Unstamped Orange Single Stack Ecstacy', 4000, 'md-drugs:server:makebluextcsingle', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makebluextcdual", function() 
	ProgressBar('Making Unstamped Blue Dual Stack Ecstacy', 4000, 'md-drugs:server:makebluextcdual', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makebluextctriple", function() 
	ProgressBar('Making Unstamped Blue Triple Stack Ecstacy', 4000, 'md-drugs:server:makebluextctriple', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:makebluextcquad", function() 
	ProgressBar('Making Unstamped Blue Quad Stack Ecstacy', 4000, 'md-drugs:server:makebluextcquad', true, 'Its a circle. It Aint Hard')
end)
------------------------------------------------------------------ Stamping
RegisterNetEvent("md-drugs:client:stampwhite", function() 
	ProgressBar('Making Stamped Pills', 4000, 'md-drugs:server:stampwhite', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:stampred", function() 
	ProgressBar('Making Stamped Pills', 4000, 'md-drugs:server:stampred', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:stamporange", function() 
	ProgressBar('Making Stamped Pills', 4000, 'md-drugs:server:stamporange', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:stampblue", function() 
	ProgressBar('Making Stamped Pills', 4000, 'md-drugs:server:stampblue', true, 'Its a circle. It Aint Hard')
end)

RegisterNetEvent("md-drugs:client:getsinglepress", function()
	ProgressBar('Buying Press', 4000, 'md-drugs:server:buypress')
end)
RegisterNetEvent("md-drugs:client:exchangepresses", function()
    ProgressBar('Buying Press', 4000, 'md-drugs:server:upgradepress')
end)
RegisterNetEvent("md-drugs:client:buypress", function() 
     lib.registerContext({
	 id = 'buypresses',
	 title = 'Purchase Presses',
	 options = {
       
        {
            title  = 'Single Press',
            description  = 'Buy a single press for 20k',
            icon = "fa-solid fa-wallet",
            event = 'md-drugs:client:getsinglepress',
        },  
        {
            title  = 'Exchange Single For Dual',
            description  = '20 of each unstamped single stack pill and your single press ',
            icon = "fa-solid fa-wallet",
            event = 'md-drugs:client:exchangepresses',
        },  
	    {
            title  = 'Exchange Dual For Triple',
            description  = '50 of each unstamped dual stack pill and your dual press ',
            icon = "fa-solid fa-wallet",
            event = 'md-drugs:client:exchangepresses',
        },
        {
            title  = 'Exchange Triple For Quad',
            description  = '150 of each unstamped Triple stack pill and your triple press ',
            icon = "fa-solid fa-wallet",
            event = 'md-drugs:client:exchangepresses',
        } 
	}	
    })
  lib.showContext('buypresses')	
end)


