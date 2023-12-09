local QBCore = exports['qb-core']:GetCoreObject()

local function loadParticle(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
    end
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
    end
    SetPtfxAssetNextCall(dict)
end

CreateThread(function() 
local Ped = "g_m_y_famdnf_01"
	lib.requestModel(Ped, 500)
	tabdealer = CreatePed(0, Ped,Config.buylsdlabkit.x,Config.buylsdlabkit.y,Config.buylsdlabkit.z-1, 180.0, false, false)
    FreezeEntityPosition(tabdealer, true)
    SetEntityInvincible(tabdealer, true)
	exports['qb-target']:AddTargetEntity(tabdealer, {
       options = {
           {
               type = "client",
               label = "Buy LSD Lab Kit",
               icon = "fas fa-eye",
               event = "md-drugs:client:buylabkit"
           }
       }
	})
end)

RegisterNetEvent("md-drugs:client:getlysergic", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Stealing Lysergic Acid!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        ClearPedTasks(PlayerPedId())
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:getlysergic")
	else
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:getdiethylamide", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Stealing Diethylamide!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
        ClearPedTasks(PlayerPedId())
    if success then
        TriggerServerEvent("md-drugs:server:getdiethylamide")
	else
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:setlsdlabkit", function() 
local PedCoords = GetEntityCoords(PlayerPedId())
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
	QBCore.Functions.Progressbar("drink_something", "Setting Table Down", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	labkit = CreateObject("v_ret_ml_tablea", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
	PlaceObjectOnGroundProperly(labkit)
	ClearPedTasks(PlayerPedId())
	exports['qb-target']:AddTargetEntity(labkit, {
     options = {
        {
			
            event = "md-drugs:client:heatliquid",
            icon = "fas fa-box-circle-check",
            label = "Heat Liquid",
        },
		{
			
            event = "md-drugs:client:refinequalityacid",
            icon = "fas fa-box-circle-check",
            label = "Refine",
        },
		{
			
            event = "md-drugs:client:maketabpaper",
            icon = "fas fa-box-circle-check",
            label = "Dab Sheets",
        },
		{
			
            event = "md-drugs:client:getlabkitback",
            icon = "fas fa-box-circle-check",
            label = "Pick Up",
        },
    }
	})
end)
end)

RegisterNetEvent("md-drugs:client:getlabkitback", function() 
    exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Packing Up", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
		DeleteObject(labkit)
		TriggerServerEvent('md-drugs:server:getlabkitback')
		ClearPedTasks(PlayerPedId())
	end)
end)


RegisterNetEvent("md-drugs:client:heatliquid", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
	local PedCoords = GetEntityCoords(PlayerPedId())
	dict = "scr_ie_svm_technical2"
    QBCore.Functions.Progressbar("drink_something", "Heating Liquids!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
    ClearPedTasks(PlayerPedId())
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:heatliquid")
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failheating")
        ClearPedTasks(PlayerPedId())
		DeleteObject(labkit)
		dirtylabkit = CreateObject("v_ret_ml_tablea", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
		loadParticle(dict)
	    exitPtfx = StartParticleFxLoopedOnEntity("scr_dst_cocaine", dirtylabkit, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, false, false, false)
		PlaceObjectOnGroundProperly(dirtylabkit)
        SetParticleFxLoopedAlpha(exitPtfx, 3.0)
		 ClearPedTasks(PlayerPedId())
		exports['qb-target']:AddTargetEntity(dirtylabkit, {
		options = {
        {
      
            event = "md-drugs:client:cleanlabkit",
            icon = "fas fa-box-circle-check",
            label = "Clean It",
        },
    }
	})
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:cleanlabkit", function() 
    exports["rpemotes"]:EmoteCommandStart("clean", 0)
    QBCore.Functions.Progressbar("drink_something", "Cleaning", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
		TriggerServerEvent("md-drugs:server:removecleaningkit")
		 ClearPedTasks(PlayerPedId())
	end)
end)

RegisterNetEvent("md-drugs:client:resetlsdkit", function() 
DeleteObject(dirtylabkit)
TriggerEvent("md-drugs:client:setlsdlabkit")
end)

RegisterNetEvent("md-drugs:client:refinequalityacid", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Refining The Quality!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
    ClearPedTasks(PlayerPedId())
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:refinequalityacid")
	else
		TriggerServerEvent("md-drugs:server:failrefinequality")
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:maketabpaper", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Dipping LSD Onto Paper", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        ClearPedTasks(PlayerPedId())
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:maketabpaper")
	else
		TriggerServerEvent("md-drugs:server:failtabs")
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)


RegisterNetEvent("md-drugs:client:cutsheet", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Cutting Sheets", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:buytabs", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Buying Tab Paper", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
		TriggerServerEvent("md-drugs:server:gettabpaper")
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:buylabkit", function() 
	exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Buying A Lab Kit", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
		TriggerServerEvent("md-drugs:server:getlabkit")
        ClearPedTasks(PlayerPedId())
    end)
end)


RegisterNetEvent('md-drugs:client:taketabs', function(itemName)
	    QBCore.Functions.Progressbar("use_lsd", "Have Fun!", 1750, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function() -- Done
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
		if itemName == "smiley_tabs" or itemName == "wildcherry_tabs" or itemName == "yinyang_tabs"   then
			AlienEffect()
		elseif itemName == "pineapple_tabs" then
			 EcstasyEffect()
		elseif itemName == "bart_tabs" then
				TrevorEffect()
		else
			TrevorEffect()
			Wait(15000)
			EcstasyEffect()
		end	
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)
