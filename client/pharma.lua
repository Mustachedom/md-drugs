
lib.callback.register("md-drugs:client:prescriptionpad", function(data, op)
    if getJobType() ~= 'ems' then return end
    local input = lib.inputDialog('Who To Give A Prescription To?',{
        {type = 'select', label = 'Player Name', options = data},
        {type = 'select', label = 'Prescription', options = op}})
    if not input[1] then return end
  if not progressbar(Lang.Pharma.write, 4000, 'notepad') then return end
  return {who = input[1], what = input[2]} 
end)

RegisterNetEvent("md-drugs:client:fillprescription", function(data) 
    if not progressbar(Lang.Pharma.fill, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:fillprescription", data.data)    
end)

lib.callback.register("md-drugs:client:unbottle", function() 
    if not progressbar(Lang.Pharma.open, 4000, 'uncuff') then return end
    return true
end)
