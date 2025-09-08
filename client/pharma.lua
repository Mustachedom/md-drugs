local locations = ps.callback('md-drugs:server:GetPharmaLocs')

ps.registerCallback("md-drugs:client:prescriptionpad", function(data, op)
    if ps.getJobType() ~= 'ems' then return end
    local input = ps.input(ps.lang('pharma.input.header'), {
        {type = 'select', title = ps.lang('pharma.input.title1'), options = data},
        {type = 'select', title = ps.lang('pharma.input.title2'), options = op}
    })
    if not input[1] then return end
    if not ps.progressbar(ps.lang('pharma.write'), 4000, 'notepad') then return end
    return {who = input[1], what = input[2]}
end)

ps.registerCallback("md-drugs:client:unbottle", function() 
    if not ps.progressbar(ps.lang('pharma.opening'), 4000, 'uncuff') then return end
    return true
end)


for k, v in pairs (locations.FillPrescription) do
    ps.boxTarget('pharma' ..k , v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-capsules',
            label = ps.lang('pharma.targetFill'),
            action = function()
                if not ps.progressbar(ps.lang('pharma.fill'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:fillprescription", k)
            end,
        }
    })
end