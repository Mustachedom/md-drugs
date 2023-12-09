local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand('prescriptionpad', function()
if QBCore.Functions.GetPlayerData().job.name == Config.PharmaJob then 
   lib.registerContext({
   id = 'prescriptionpad',
   title = "Prescription Pad",
   options = {
        {
            title  = 'Give Vicodin',
            description  = 'Give Vicodin ',
            icon = 'fa-solid fa-file-prescription',
            event = 'md-drugs:client:givevicodinprescription',
        },  
        {
            title  = 'Give Adderal',
            description  = 'Give Adderal ',
            icon = 'fa-solid fa-file-prescription',
            event = 'md-drugs:client:giveadderalprescription',
        },  
		{
            title  = 'Give Morphine',
            description  = 'Give Morphine ',
            icon = 'fa-solid fa-file-prescription',
            event = 'md-drugs:client:givemorphineprescription',
               
        },  
        {
            title  = 'Give Xanax',
            description  = 'Give Vicodin ',
            icon = 'fa-solid fa-file-prescription',
			event = 'md-drugs:client:givexanaxprescription',
        },
	}
    })
lib.showContext('prescriptionpad')	
else
QBCore.Functions.Notify("Youre Not A Medical Person", "error")
end
end)


RegisterNetEvent("md-drugs:client:givevicodinprescription", function() 
 	ProgressBar('Getting The Prescription Written', 4000, 'md-drugs:server:givevicodinprescription')
end)
RegisterNetEvent("md-drugs:client:giveadderalprescription", function() 
	ProgressBar('Getting The Prescription Written', 4000, 'md-drugs:server:giveadderalprescription')
end)

RegisterNetEvent("md-drugs:client:givemorphineprescription", function() 
	ProgressBar('Getting The Prescription Written', 4000, 'md-drugs:server:givemorphineprescription')
end)
RegisterNetEvent("md-drugs:client:givexanaxprescription", function() 
	ProgressBar('Getting The Prescription Written', 4000, 'md-drugs:server:givexanaxprescription')
end)

RegisterNetEvent("md-drugs:client:fillprescription", function() 
	ProgressBar('Picking Up Your Prescription', 4000, 'md-drugs:server:fillprescription')
end)

RegisterNetEvent("md-drugs:client:openingvicodin", function() 
exports["rpemotes"]:EmoteCommandStart("uncuff", 0)
    QBCore.Functions.Progressbar("drink_something", "Opening Bottle", 4000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
        disableInventory = true,
    }, {}, {}, {}, function()-- Done
        ClearPedTasks(cache.ped)
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
        StopAnimTask(cache.ped, "mp_suicide", "pill", 1.0)
        
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
        StopAnimTask(cache.ped, "mp_suicide", "pill", 1.0)
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)
