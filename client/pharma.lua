local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('prescriptionpad', function()
if QBCore.Functions.GetPlayerData().job.name == "ambulance"  then 
    exports['qb-menu']:openMenu({
        {
            header = 'Prescription Pad',
            icon = 'fa-solid fa-prescription',
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = 'Give Vicodin',
            txt = 'Give Vicodin ',
            icon = 'fa-solid fa-file-prescription',
            params = {
                event = 'md-drugs:client:givevicodinprescription',
                args = {
                }
            }
        },  
        {
            header = 'Give Adderal',
            txt = 'Give Adderal ',
            icon = 'fa-solid fa-file-prescription',
            params = {
                event = 'md-drugs:client:giveadderalprescription',
                args = {
                }
            }
        },  
		 {
            header = 'Give Morphine',
            txt = 'Give Morphine ',
            icon = 'fa-solid fa-file-prescription',
            params = {
                event = 'md-drugs:client:givemorphineprescription',
                args = {
                }
            }
        },  
        {
            header = 'Give Xanax',
            txt = 'Give Vicodin ',
            icon = 'fa-solid fa-file-prescription',
            params = {
                event = 'md-drugs:client:givexanaxprescription',
                args = {
                }
            }
        },  
    })
else
QBCore.Functions.Notify("Youre Not A Medical Person", "error")
end
end)


RegisterNetEvent("md-drugs:client:givevicodinprescription")
AddEventHandler("md-drugs:client:givevicodinprescription", function() 
 exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Getting The Prescription Written", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:givevicodinprescription")
        ClearPedTasks(PlayerPedId())
    end)
end)
RegisterNetEvent("md-drugs:client:giveadderalprescription")
AddEventHandler("md-drugs:client:giveadderalprescription", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Getting The Prescription Written", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:giveadderalprescription")
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:givemorphineprescription")
AddEventHandler("md-drugs:client:givemorphineprescription", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Getting The Prescription Written", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:givemorphineprescription")
        ClearPedTasks(PlayerPedId())
    end)
end)
RegisterNetEvent("md-drugs:client:givexanaxprescription")
AddEventHandler("md-drugs:client:givexanaxprescription", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Getting The Prescription Written", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:givexanaxprescription")
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:fillprescription")
AddEventHandler("md-drugs:client:fillprescription", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Picking Up Your Prescription", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
	    TriggerServerEvent("md-drugs:server:fillprescription")
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent("md-drugs:client:openingvicodin")
AddEventHandler("md-drugs:client:openingvicodin", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Opening Bottle", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        ClearPedTasks(PlayerPedId())
    end)
end)


RegisterNetEvent('md-drugs:client:takepharma', function(itemName)
	    QBCore.Functions.Progressbar("use_lsd", "Get Pain Relief!", 1750, false, true, {
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
        
		if itemName == "vicodin" then
			exports['ps-buffs']:AddHealthBuff(10000, 20)
		elseif itemName == "adderal" then
			exports['ps-buffs']:StaminaBuffEffect(5000, 1.3)
		elseif itemName == "xanax" then 
			exports['ps-buffs']:AddStressBuff(10000, 25)
		else 
			exports['ps-buffs']:AddHealthBuff(10000, 40)
		end
    end, function() -- Cancel
        StopAnimTask(PlayerPedId(), "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)
