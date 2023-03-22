local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-drugs:client:getlysergic")
AddEventHandler("md-drugs:client:getlysergic", function() 
	RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Stealing Lysergic Acid!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:getlysergic")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:getdiethylamide")
AddEventHandler("md-drugs:client:getdiethylamide", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Stealing Diethylamide!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:getdiethylamide")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:heatliquid")
AddEventHandler("md-drugs:client:heatliquid", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Heating Liquids!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:heatliquid")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failheating")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:refinequalityacid")
AddEventHandler("md-drugs:client:refinequalityacid", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Refining The Quality!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:refinequalityacid")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failrefinequality")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 1, 8) -- NumberOfCircles, MS
    end)
end)

RegisterNetEvent("md-drugs:client:maketabpaperone")
AddEventHandler("md-drugs:client:maketabpaperone", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Dropping Tabs!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:maketabpaperone")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failtabsone")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)


RegisterNetEvent("md-drugs:client:maketabpapertwo")
AddEventHandler("md-drugs:client:maketabpapertwo", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Dropping Tabs!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:maketabpapertwo")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failtabstwo")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)


RegisterNetEvent("md-drugs:client:maketabpaperthree")
AddEventHandler("md-drugs:client:maketabpaperthree", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Dropping Tabs!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:maketabpaperthree")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failtabsthree")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)

RegisterNetEvent("md-drugs:client:maketabpaperfour")
AddEventHandler("md-drugs:client:maketabpaperfour", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Dropping Tabs!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:maketabpaperfour")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failtabsfour")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)

RegisterNetEvent("md-drugs:client:maketabpaperfive")
AddEventHandler("md-drugs:client:maketabpaperfive", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Dropping Tabs!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:maketabpaperfive")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failtabsfive")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)

RegisterNetEvent("md-drugs:client:maketabpapersix")
AddEventHandler("md-drugs:client:maketabpapersix", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Dropping Tabs!", 1000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	exports['ps-ui']:Circle(function(success)
    if success then
        TriggerServerEvent("md-drugs:server:maketabpapersix")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	else
		TriggerServerEvent("md-drugs:server:failtabsix")
        Citizen.Wait(4000)
        ClearPedTasks(PlayerPedId())
	end
end, 3, 8) -- NumberOfCircles, 
    end)
end)

RegisterNetEvent("md-drugs:client:cutsheet")
AddEventHandler("md-drugs:client:cutsheet", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Cutting Sheets", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
    
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:buytabs")
AddEventHandler("md-drugs:client:buytabs", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Buying Tab Paper", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
		TriggerServerEvent("md-drugs:server:gettabpaper")
    
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:buylabkit")
AddEventHandler("md-drugs:client:buylabkit", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Buying A Lab Kit", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
		TriggerServerEvent("md-drugs:server:getlabkit")
    
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:getdirtykit")
AddEventHandler("md-drugs:client:getdirtykit", function() 
    RequestAnimDict("mp_arresting")
        while (not HasAnimDictLoaded("mp_arresting")) do
        Citizen.Wait(4000)
        end
        TaskPlayAnim(PlayerPedId(), "mp_arresting" ,"a_uncuff" ,8.0, -8.0, -1, 1, 0, false, false, false )
          local PedCoords = GetEntityCoords(PlayerPedId())
    QBCore.Functions.Progressbar("drink_something", "Ruining Your Kit", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
		TriggerServerEvent("md-drugs:server:getdirtykit")
    
        ClearPedTasks(PlayerPedId())
    end)
end)


function MethBagEffect()
    local startStamina = 8
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            TrevorEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

function EcstasyEffect()
    local startStamina = 30
    SetFlash(0, 0, 500, 7000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
end


function CokeBaggyEffect()
    local startStamina = 20
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            AlienEffect()
            Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end


RegisterNetEvent('md-drugs:client:takesmileytabs', function()
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
        AlienEffect()
        
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('md-drugs:client:takewildcherrytabs', function()
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
        AlienEffect()
        
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('md-drugs:client:takeyinyangtabs', function()
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
        AlienEffect()
        
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('md-drugs:client:takepineappletabs', function()
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
        EcstasyEffect()
        
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('md-drugs:client:takebarttabs', function()
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
        TrevorEffect()
		
        
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)

RegisterNetEvent('md-drugs:client:takegratefuldeadtabs', function()
    QBCore.Functions.Progressbar("use_lsd", "Have Fun!", 10000, false, true, {
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
        TrevorEffect()
		Wait(15000)
		EcstasyEffect()
        
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)
---------------------------------------------------------------- LSD EFFECTS
