local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-drugs:client:setpressquad")
AddEventHandler("md-drugs:client:setpressquad", function() 
local PedCoords = GetEntityCoords(PlayerPedId())
	TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
	Wait(4000)
	ClearPedTasks(PlayerPedId())
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

RegisterNetEvent("md-drugs:client:setpresstriple")
AddEventHandler("md-drugs:client:setpresstriple", function() 
local PedCoords = GetEntityCoords(PlayerPedId())
	TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
	Wait(4000)
	ClearPedTasks(PlayerPedId())
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

RegisterNetEvent("md-drugs:client:setpressdual")
AddEventHandler("md-drugs:client:setpressdual", function() 
local PedCoords = GetEntityCoords(PlayerPedId())
	TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
	Wait(4000)
	ClearPedTasks(PlayerPedId())
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

RegisterNetEvent("md-drugs:client:setpresssingle")
AddEventHandler("md-drugs:client:setpresssingle", function() 
local PedCoords = GetEntityCoords(PlayerPedId())
	TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
	Wait(4000)
	ClearPedTasks(PlayerPedId())
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

RegisterNetEvent("md-drugs:client:getsinglepressback")
AddEventHandler("md-drugs:client:getsinglepressback", function() 
DeleteObject(singlepress)
TriggerServerEvent("md-drugs:server:getsinglepressback")
ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("md-drugs:client:getdualpressback")
AddEventHandler("md-drugs:client:getdualpressback", function() 
DeleteObject(dualpress)
TriggerServerEvent("md-drugs:server:getdualpressback")
ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("md-drugs:client:gettriplepressback")
AddEventHandler("md-drugs:client:gettriplepressback", function() 
DeleteObject(triplepress)
TriggerServerEvent("md-drugs:server:gettriplepressback")
ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("md-drugs:client:getquadpressback")
AddEventHandler("md-drugs:client:getquadpressback", function() 
DeleteObject(quadpress)
TriggerServerEvent("md-drugs:server:getquadpressback")
ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent("md-drugs:client:stealisosafrole")
AddEventHandler("md-drugs:client:stealisosafrole", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Stealing Isosafrole", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:stealisosafrole")
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:stealmdp2p")
AddEventHandler("md-drugs:client:stealmdp2p", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Stealing MDP2P", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:stealmdp2p")
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makingrawxtc")
AddEventHandler("md-drugs:client:makingrawxtc", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Raw Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makingrawxtc")
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
---------------------------- unstamped just xtc
RegisterNetEvent("md-drugs:client:makextcsingle")
AddEventHandler("md-drugs:client:makextcsingle", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Single Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makextcsingle")
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        ClearPedTasks(PlayerPedId())
	end
end, 4, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makextcdual")
AddEventHandler("md-drugs:client:makextcdual", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Dual Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makextcdual")
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makextctriple")
AddEventHandler("md-drugs:client:makextctriple", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Triple Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makextctriple")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makextcquad")
AddEventHandler("md-drugs:client:makextcquad", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Quad Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makextcquad")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
------------------------------------------------- 
RegisterNetEvent("md-drugs:client:makeredxtcsingle")
AddEventHandler("md-drugs:client:makeredxtcsingle", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Red Single Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeredxtcsingle")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 4, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeredxtcdual")
AddEventHandler("md-drugs:client:makeredxtcdual", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Red Dual Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeredxtcdual")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeredxtctriple")
AddEventHandler("md-drugs:client:makeredxtctriple", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Red Triple Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeredxtctriple")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeredxtcquad")
AddEventHandler("md-drugs:client:makeredxtcquad", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Red Quad Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeredxtcquad")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
--------------------------------------------------------------- making orange unstamped
RegisterNetEvent("md-drugs:client:makeorangextcsingle")
AddEventHandler("md-drugs:client:makeorangextcsingle", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Single Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeorangextcsingle")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 4, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeorangextcdual")
AddEventHandler("md-drugs:client:makeorangextcdual", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Dual Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeorangextcdual")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeorangextctriple")
AddEventHandler("md-drugs:client:makeorangextctriple", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Triple Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeorangextctriple")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makeorangextcquad")
AddEventHandler("md-drugs:client:makeorangextcquad", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Quad Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makeorangextcquad")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
--------------------------------------- blue unstamped
RegisterNetEvent("md-drugs:client:makebluextcsingle")
AddEventHandler("md-drugs:client:makebluextcsingle", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Orange Single Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makebluextcsingle")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 4, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makebluextcdual")
AddEventHandler("md-drugs:client:makebluextcdual", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Blue Dual Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makebluextcdual")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makebluextctriple")
AddEventHandler("md-drugs:client:makebluextctriple", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Blue Triple Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makebluextctriple")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:makebluextcquad")
AddEventHandler("md-drugs:client:makebluextcquad", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Unstamped Blue Quad Stack Ecstacy", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:makebluextcquad")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)
------------------------------------------------------------------ Stamping
RegisterNetEvent("md-drugs:client:stampwhite")
AddEventHandler("md-drugs:client:stampwhite", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Stamped Pills", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:stampwhite")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:stampred")
AddEventHandler("md-drugs:client:stampred", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Stamped Pills", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:stampred")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:stamporange")
AddEventHandler("md-drugs:client:stamporange", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Stamped Pills", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:stamporange")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:stampblue")
AddEventHandler("md-drugs:client:stampblue", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Making Stamped Pills", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:stampblue")
        
        ClearPedTasks(PlayerPedId())
	else
        QBCore.Functions.Notify("Its a circle. It Aint Hard", "error")    
        
        ClearPedTasks(PlayerPedId())
	end
end, 2, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:getsinglepress")
AddEventHandler("md-drugs:client:getsinglepress", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Buying Press", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   TriggerServerEvent("md-drugs:server:buypress")
        ClearPedTasks(PlayerPedId())

    end)
end)
RegisterNetEvent("md-drugs:client:exchangepresses")
AddEventHandler("md-drugs:client:exchangepresses", function() 
TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
    QBCore.Functions.Progressbar("drink_something", "Buying Press", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	   TriggerServerEvent("md-drugs:server:upgradepress")
        ClearPedTasks(PlayerPedId())

    end)
end)
RegisterNetEvent("md-drugs:client:buypress")
AddEventHandler("md-drugs:client:buypress", function() 
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


