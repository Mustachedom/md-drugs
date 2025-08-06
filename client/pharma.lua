local locations = ps.callback('md-drugs:server:GetPharmaLocs')
ps.registerCallback("md-drugs:client:prescriptionpad", function(data, op)
    if ps.getJobType() ~= 'ems' then return end
    local input = exports.ps_lib:input('Who To Give A Prescription To?',{
        {type = 'select', title = 'Player Name', options = data},
        {type = 'select', title = 'Prescription', options = op}
    })
    if not input[1] then return end
    if not ps.progressbar(ps.lang('Pharma.write'), 4000, 'notepad') then return end
    return {who = input[1], what = input[2]}
end)

ps.registerCallback("md-drugs:client:unbottle", function() 
    if not ps.progressbar(ps.lang('Pharma.open'), 4000, 'uncuff') then return end
    return true
end)


for k, v in pairs (locations.FillPrescription) do
    ps.boxTarget('pharma' ..k , v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-capsules',
            label = ps.lang('Pharma.fillprescription'),
            action = function()
                if not ps.progressbar(ps.lang('Pharma.fill'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:fillprescription", k)
            end
        }
    })
end