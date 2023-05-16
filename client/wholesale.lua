local QBCore = exports['qb-core']:GetCoreObject()

local deliveryBlip = nil
local PZone = nil
local listen = false
RegisterNetEvent("md-drugs:client:getloccoke")
AddEventHandler("md-drugs:client:getloccoke", function() 
	local unlucky = math.random(1,100)
    local CurrentLocation = vector3(642.18, 641.48, 129.11)
	local unluck =  math.random(1,100)
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
	if unlucky <= 90 then 
        if  Config.cd then
            TriggerServerEvent('cd_dispatch:AddNotification', { 
            job_table = {'police'}, 
            coords = CurrentLocation,
            title = 'anonymous tip',
            message = 'this id from cd', 
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
                blip = {
                    sprite = 825, 
                    scale = 1.2, 
                    colour = 1,
                    flashes = false, 
                    text = 'Anon Tip',
                    time = (5*60*1000),
                    sound = 1,
                }
            }) 
        elseif Config.ps then
            local currentPos = CurrentLocation
                TriggerServerEvent("dispatch:server:notify", {
                dispatchcodename = "susactivity", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
                dispatchCode = "10-66",
                origin = {
                    x = currentPos.x,
                    y = currentPos.y,
                    z = currentPos.z
                },
                dispatchMessage = "Suspicious Activity",
                job = {"LEO", "police"} -- has to match the recipientList in sv_dispatchcodes.lua
            })
        end
    end
    deliveryBlip = AddBlipForCoord(CurrentLocation)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("drug Meet")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)
	druglocation = CircleZone:Create(CurrentLocation, 5,{ name = "cokesell", debugPoly = false })
	druglocation:onPlayerInOut(function(isPointInside) if isPointInside then  RemoveBlip(deliveryBlip) end end)
	  if Config.Gks then
	 TriggerServerEvent('gksphone:NewMail', {
				sender = 'Anon',
				image = '/html/static/img/icons/mail.png',
				subject = "Meet Me At The Marked location",
			message = 'Bring me 100 bags of crack. If You Bring Police. You are dead.'
			})
	else
		TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Anonymous',
            subject = 'Meet Me At The Marked Location',
            message = 'Bring me 100 bags of crack. If You Bring Police. You are dead',
        })
	end
	local current = "g_m_y_famdnf_01"
            RequestModel(current)
            while not HasModelLoaded(current) do
                Wait(0)
            end
            
            drugdealer = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, 90.0, false, false)
             FreezeEntityPosition(drugdealer, true)
            SetEntityInvincible(drugdealer, true)
	exports['qb-target']:AddTargetEntity(drugdealer, {
                options = {
                    {
                        type = "client",
                        label = "Talk To Buyer",
                        icon = "fas fa-eye",
                        event = "md-drugs:client:wholesaledrugscoke"
                    },
                },
                distance = 2.0
            })
	 
	
end)

RegisterNetEvent("md-drugs:client:wholesaledrugscoke")
AddEventHandler("md-drugs:client:wholesaledrugscoke", function() 
local luck = math.random(1,1000)

	if luck <= 900 then
		TriggerEvent("md-drugs:client:successsalecoke")
	else
		
		TriggerEvent("md-drugs:client:setupcoke")
		Wait(3000)
		 for i = 1, #Config.Cokepeds do
		CokePed = CreatePed(4, "g_m_y_famdnf_01", Config.Cokepeds[i].x, Config.Cokepeds[i].y, Config.Cokepeds[i].z, 90.0, true, true)
         SetPedArmour(CokePed, 200)
         SetPedCanSwitchWeapon(CokePed, true)
         GiveWeaponToPed(CokePed, "weapon_pistol", 1, false, true)
         TaskCombatPed(CokePed, PlayerPedId(), 0, 16)
         SetPedCombatAttributes(CokePed, 46, true)
		
		end
	end
end)


RegisterNetEvent("md-drugs:client:successsalecoke")
AddEventHandler("md-drugs:client:successsalecoke", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
QBCore.Functions.Progressbar("drink_something", "Wholesaling Drugs", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
       TriggerServerEvent("md-drugs:server:wholesalecoke")
	   Citizen.Wait(4000)
		
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:setupcoke")
AddEventHandler("md-drugs:client:setupcoke", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
QBCore.Functions.Progressbar("drink_something", "YOU FUCKED NOW", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)
----------crack
RegisterNetEvent("md-drugs:client:getloccrack")
AddEventHandler("md-drugs:client:getloccrack", function() 
	local unlucky = math.random(1,100)
    local CurrentLocation = vector3(1872.35, 283.52, 164.27)
	local unluck =  math.random(1,100)
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
	if unlucky <= 90 then 
        if  Config.cd then
            TriggerServerEvent('cd_dispatch:AddNotification', { 
            job_table = {'police'}, 
            coords = CurrentLocation,
            title = 'anonymous tip',
            message = 'this id from cd', 
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
                blip = {
                    sprite = 825, 
                    scale = 1.2, 
                    colour = 1,
                    flashes = false, 
                    text = 'Anon Tip',
                    time = (5*60*1000),
                    sound = 1,
                }
            }) 
        elseif Config.ps then
            local currentPos = CurrentLocation
                TriggerServerEvent("dispatch:server:notify", {
                dispatchcodename = "susactivity", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
                dispatchCode = "10-66",
                origin = {
                    x = currentPos.x,
                    y = currentPos.y,
                    z = currentPos.z
                },
                dispatchMessage = "Suspicious Activity",
                job = {"LEO", "police"} -- has to match the recipientList in sv_dispatchcodes.lua
            })
        end
    end
    deliveryBlip = AddBlipForCoord(CurrentLocation)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("drug Meet")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)
	druglocation = CircleZone:Create(CurrentLocation, 5,{ name = "cracksell", debugPoly = false })
	druglocation:onPlayerInOut(function(isPointInside) if isPointInside then  RemoveBlip(deliveryBlip) end end)
	 if Config.Gks then
	 TriggerServerEvent('gksphone:NewMail', {
				sender = 'Anon',
				image = '/html/static/img/icons/mail.png',
				subject = "Meet Me At The Marked location",
			message = 'Bring me 100 bags of crack. If You Bring Police. You are dead.'
			})
	else
		TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = 'Anonymous',
            subject = 'Meet Me At The Marked Location',
            message = 'Bring me 100 bags of crack. If You Bring Police. You are dead',
        })
	end
	local current = "g_m_y_famca_01"
            RequestModel(current)
            while not HasModelLoaded(current) do
                Wait(0)
            end
            
            drugdealer = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, 90.0, false, false)
             FreezeEntityPosition(drugdealer, true)
            SetEntityInvincible(drugdealer, true)
	exports['qb-target']:AddTargetEntity(drugdealer, {
                options = {
                    {
                        type = "client",
                        label = "Talk To Buyer",
                        icon = "fas fa-eye",
                        event = "md-drugs:client:wholesaledrugscrack"
                    },
                },
                distance = 2.0
            })
	 
	
end)

RegisterNetEvent("md-drugs:client:wholesaledrugscrack")
AddEventHandler("md-drugs:client:wholesaledrugscrack", function() 
local luck = math.random(1,1000)

	if luck <= 900 then
		TriggerEvent("md-drugs:client:successsalecrack")
	else
		
		TriggerEvent("md-drugs:client:setupcrack")
		 for i = 1, #Config.CrackPeds do
		CrackPed = CreatePed(4, "g_m_y_famdnf_01", Config.CrackPeds[i].x, Config.CrackPeds[i].y, Config.CrackPeds[i].z, 90.0, true, true)
         SetPedArmour(CrackPed, 200)
         SetPedCanSwitchWeapon(CrackPed, true)
         GiveWeaponToPed(CrackPed, "weapon_pistol", 1, false, true)
         TaskCombatPed(CrackPed, PlayerPedId(), 0, 16)
         SetPedCombatAttributes(CrackPed, 46, true)
		
		end
	end
end)


RegisterNetEvent("md-drugs:client:successsalecrack")
AddEventHandler("md-drugs:client:successsalecrack", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
QBCore.Functions.Progressbar("drink_something", "Wholesaling Drugs", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
       TriggerServerEvent("md-drugs:server:wholesalecrack")
	   Citizen.Wait(4000)
		
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:setupcrack")
AddEventHandler("md-drugs:client:setupcrack", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
QBCore.Functions.Progressbar("drink_something", "YOU FUCKED NOW", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)
----------------------------- heroin
RegisterNetEvent("md-drugs:client:getlocheroin")
AddEventHandler("md-drugs:client:getlocheroin", function() 
	local unlucky = math.random(1,100)
    local CurrentLocation = vector3(2729.87, 1372.7, 24.52)
	local unluck =  math.random(1,100)
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
	if unlucky <= 90 then 
        if  Config.cd then
            TriggerServerEvent('cd_dispatch:AddNotification', { 
            job_table = {'police'}, 
            coords = CurrentLocation,
            title = 'anonymous tip',
            message = 'this id from cd', 
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
                blip = {
                    sprite = 825, 
                    scale = 1.2, 
                    colour = 1,
                    flashes = false, 
                    text = 'Anon Tip',
                    time = (5*60*1000),
                    sound = 1,
                }
            }) 
        elseif Config.ps then
            local currentPos = CurrentLocation
                TriggerServerEvent("dispatch:server:notify", {
                dispatchcodename = "susactivity", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
                dispatchCode = "10-66",
                origin = {
                    x = currentPos.x,
                    y = currentPos.y,
                    z = currentPos.z
                },
                dispatchMessage = "Suspicious Activity",
                job = {"LEO", "police"} -- has to match the recipientList in sv_dispatchcodes.lua
            })
        end
    end
    deliveryBlip = AddBlipForCoord(CurrentLocation)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("drug Meet")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)
	druglocation = CircleZone:Create(CurrentLocation, 5,{ name = "heroinsell", debugPoly = false })
	druglocation:onPlayerInOut(function(isPointInside) if isPointInside then  RemoveBlip(deliveryBlip) end end)
	 TriggerServerEvent('gksphone:NewMail', {
				sender = 'Anon',
				image = '/html/static/img/icons/mail.png',
				subject = "Meet Me At The Marked location",
			message = 'Bring me 100 syringes of heroin. If You Bring Police. You are dead.'
			})
	local current = "g_m_y_famdnf_01"
            RequestModel(current)
            while not HasModelLoaded(current) do
                Wait(0)
            end
            
            drugdealer = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, 90.0, false, false)
             FreezeEntityPosition(drugdealer, true)
            SetEntityInvincible(drugdealer, true)
	exports['qb-target']:AddTargetEntity(drugdealer, {
                options = {
                    {
                        type = "client",
                        label = "Talk To Buyer",
                        icon = "fas fa-eye",
                        event = "md-drugs:client:wholesaledrugsheroin"
                    },
                },
                distance = 2.0
            })
	 
	
end)

RegisterNetEvent("md-drugs:client:wholesaledrugsheroin")
AddEventHandler("md-drugs:client:wholesaledrugsheroin", function() 
local luck = math.random(1,1000)

	if luck <= 900 then
		TriggerEvent("md-drugs:client:successsaleheroin")
	else
		
		TriggerEvent("md-drugs:client:setupheroin")
		Wait(3000)
		 for i = 1, #Config.heroinPeds do
		heroinPed = CreatePed(4, "g_m_y_famdnf_01", Config.heroinPeds[i].x, Config.heroinPeds[i].y, Config.heroinPeds[i].z, 90.0, true, true)
         SetPedArmour(heroinPed, 200)
         SetPedCanSwitchWeapon(heroinPed, true)
         GiveWeaponToPed(heroinPed, "weapon_pistol", 1, false, true)
         TaskCombatPed(heroinPed, PlayerPedId(), 0, 16)
         SetPedCombatAttributes(heroinPed, 46, true)
		
		end
	end
end)


RegisterNetEvent("md-drugs:client:successsaleheroin")
AddEventHandler("md-drugs:client:successsaleheroin", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
QBCore.Functions.Progressbar("drink_something", "Wholesaling Drugs", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
       TriggerServerEvent("md-drugs:server:wholesaleheroin")
	   Citizen.Wait(4000)
		
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:setupheroin")
AddEventHandler("md-drugs:client:setupheroin", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
QBCore.Functions.Progressbar("drink_something", "YOU FUCKED NOW", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)
---------------------------  lsd
RegisterNetEvent("md-drugs:client:getloclsd")
AddEventHandler("md-drugs:client:getloclsd", function() 
	local unlucky = math.random(1,100)
    local CurrentLocation = vector3(-1533.66, 837.38, 181.59)
	local unlucky =  math.random(1,100)
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
	if unlucky <= 90 then 
        if  Config.cd then
            TriggerServerEvent('cd_dispatch:AddNotification', { 
            job_table = {'police'}, 
            coords = CurrentLocation,
            title = 'anonymous tip',
            message = 'this id from cd', 
            flash = 0,
            unique_id = tostring(math.random(0000000,9999999)),
                blip = {
                    sprite = 825, 
                    scale = 1.2, 
                    colour = 1,
                    flashes = false, 
                    text = 'Anon Tip',
                    time = (5*60*1000),
                    sound = 1,
                }
            }) 
        elseif Config.ps then
            local currentPos = CurrentLocation
                TriggerServerEvent("dispatch:server:notify", {
                dispatchcodename = "susactivity", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
                dispatchCode = "10-66",
                origin = {
                    x = currentPos.x,
                    y = currentPos.y,
                    z = currentPos.z
                },
                dispatchMessage = "Suspicious Activity",
                job = {"LEO", "police"} -- has to match the recipientList in sv_dispatchcodes.lua
            })
        end
    end
    deliveryBlip = AddBlipForCoord(CurrentLocation)
    SetBlipSprite(deliveryBlip, 1)
    SetBlipDisplay(deliveryBlip, 2)
    SetBlipScale(deliveryBlip, 1.0)
    SetBlipAsShortRange(deliveryBlip, false)
    SetBlipColour(deliveryBlip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("drug Meet")
    EndTextCommandSetBlipName(deliveryBlip)
    SetBlipRoute(deliveryBlip, true)
	druglocation = CircleZone:Create(CurrentLocation, 5,{ name = "lsdsell", debugPoly = false })
	druglocation:onPlayerInOut(function(isPointInside) if isPointInside then  RemoveBlip(deliveryBlip) end end)
	 TriggerServerEvent('gksphone:NewMail', {
				sender = 'Anon',
				image = '/html/static/img/icons/mail.png',
				subject = "Meet Me At The Marked location",
			message = 'Bring me 500 tabs of lsd. If You Bring Police. You are dead.'
			})
	local current = "g_m_y_famdnf_01"
            RequestModel(current)
            while not HasModelLoaded(current) do
                Wait(0)
            end
            
            drugdealer = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, 90.0, false, false)
             FreezeEntityPosition(drugdealer, true)
            SetEntityInvincible(drugdealer, true)
	exports['qb-target']:AddTargetEntity(drugdealer, {
                options = {
                    {
                        type = "client",
                        label = "Talk To Buyer",
                        icon = "fas fa-eye",
                        event = "md-drugs:client:wholesaledrugslsd"
                    },
                },
                distance = 2.0
            })
	 
	
end)

RegisterNetEvent("md-drugs:client:wholesaledrugslsd")
AddEventHandler("md-drugs:client:wholesaledrugslsd", function() 
local luck = math.random(1,1000)

	if luck <= 900 then
		TriggerEvent("md-drugs:client:successsalelsd")
	else
		
		TriggerEvent("md-drugs:client:setuplsd")
		 for i = 1, #Config.lsdPeds do
		 Wait(3000)
		lsdPed = CreatePed(4, "g_m_y_famdnf_01", Config.lsdPeds[i].x, Config.lsdPeds[i].y, Config.lsdPeds[i].z, 90.0, true, true)
         SetPedArmour(lsdPed, 200)
         SetPedCanSwitchWeapon(lsdPed, true)
         GiveWeaponToPed(lsdPed, "weapon_pistol", 1, false, true)
         TaskCombatPed(lsdPed, PlayerPedId(), 0, 16)
         SetPedCombatAttributes(lsdPed, 46, true)
		
		end
	end
end)


RegisterNetEvent("md-drugs:client:successsalelsd")
AddEventHandler("md-drugs:client:successsalelsd", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
QBCore.Functions.Progressbar("drink_something", "Wholesaling Drugs", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
       TriggerServerEvent("md-drugs:server:wholesalelsd")
	   Citizen.Wait(4000)
		
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:setuplsd")
AddEventHandler("md-drugs:client:setuplsd", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
QBCore.Functions.Progressbar("drink_something", "YOU FUCKED NOW", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        Citizen.Wait(4000)
        DeleteEntity(drugdealer)
        ClearPedTasks(PlayerPedId())
    end)
end)
