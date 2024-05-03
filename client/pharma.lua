local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-drugs:client:prescriptionpad", function(args)
if QBCore.Functions.GetPlayerData().job.type == Config.PharmaJob then 
   lib.registerContext({
   id = 'prescriptionpad',
   title = "Prescription Pad",
   options = {
        {title  = 'Give Vics', description  = 'Give Vics ', icon = 'fa-solid fa-file-prescription', event = 'md-drugs:client:writeprescription',  args = {item = 'vicodin_prescription'}},  
        {title  = 'Give Madderal', description  = 'Give Madderal ', icon = 'fa-solid fa-file-prescription', event = 'md-drugs:client:writeprescription',  args = {item = 'adderal_prescription'}},  
		{title  = 'Give Morphin',description  = 'Give Morphin ',icon = 'fa-solid fa-file-prescription', event = 'md-drugs:client:writeprescription', args = {item = 'morphine_prescription'}},  
        {title  = 'Give Zany',   description  = 'Give Zany ', icon = 'fa-solid fa-file-prescription',   event = 'md-drugs:client:writeprescription',      args = {item = 'xanax_prescription'} },
	}
    })
    lib.showContext('prescriptionpad')	
else
    Notify(Lang.Pharma.notems, "error")
end
end)



RegisterNetEvent("md-drugs:client:writeprescription", function(args)
    if not progressbar(Lang.Pharma.write, 4000, 'notepad') then return end
	TriggerServerEvent("md-drugs:server:giveprescription", args.item)
end)


RegisterNetEvent("md-drugs:client:fillprescription", function(data) 
    if not progressbar(Lang.Pharma.fill, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:fillprescription", data.data)    
end)


RegisterNetEvent("md-drugs:client:unbottle", function(item) 
    if not progressbar(Lang.Pharma.open, 4000, 'uncuff') then return end
    if item.name == 'vicodinbottle' then item = 'vicodin' end
    if item.name == 'adderalbottle' then item = 'adderal' end
    if item.name == 'morphinebottle' then item = 'morphine' end
    if item.name == 'xanaxbottle' then item = 'xanax' end
    TriggerServerEvent('md-drugs:server:unbottle', item)
end)


RegisterNetEvent('md-drugs:client:takepharma', function(itemName)
	if not progressbar(Lang.Pharma.consume, 1000, 'eat') then return end
	if itemName == "vicodin" then
		exports['ps-buffs']:AddHealthBuff(10000, 20)
	elseif itemName == "adderal" then
		exports['ps-buffs']:StaminaBuffEffect(5000, 1.3)
	elseif itemName == "xanax" then 
		exports['ps-buffs']:AddStressBuff(10000, 25)
	else 
		exports['ps-buffs']:AddHealthBuff(10000, 40)
	end
end)
