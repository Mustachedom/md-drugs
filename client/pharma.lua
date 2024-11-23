local QBCore = exports['qb-core']:GetCoreObject()

lib.callback.register("md-drugs:client:prescriptionpad", function(data)
    if not QBCore.Functions.GetPlayerData().job.type == 'ems' then return end
    local input = lib.inputDialog('Who To Give A Prescription To?',{
        {type = 'select', label = 'Player Name', options = data},
        {type = 'select', label = 'Prescription', options = {
            {label = 'Vicodin', value = 'vicodin_prescription'},
            {label = 'Adderal', value = 'adderal_prescription'},
            {label = 'Morphine', value = 'morphine_prescription'},
            {label = 'Xanax', value = 'xanax_prescription'}
        }}})
  if not progressbar(Lang.Pharma.write, 4000, 'notepad') then return end
  return {who = input[1], what = input[2]} 
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
