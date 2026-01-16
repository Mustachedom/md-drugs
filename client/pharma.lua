local locations = ps.callback('md-drugs:server:GetPharmaLocs')

Bridge.Callback.Register("md-drugs:client:prescriptionpad", function(data, op)
    local job = ps.getPlayerData().job.name
    if job ~= 'ambulance' then
       Bridge.Notify.SendNotify(Bridge.Language.Locale('pharma.notPharma'), 'error')
        return
    end
    local input = ps.input(Bridge.Language.Locale('pharma.input.header'), {
        {type = 'select', title = Bridge.Language.Locale('pharma.input.title1'), options = data},
        {type = 'select', title = Bridge.Language.Locale('pharma.input.title2'), options = op}
    })
    if not input[1] then return end
    if not ps.progressbar(Bridge.Language.Locale('pharma.write'), 4000, 'notepad') then return end
    return {who = input[1], what = input[2]}
end)

ps.registerCallback("md-drugs:client:unbottle", function() 
    if not ps.progressbar(Bridge.Language.Locale('pharma.opening'), 4000, 'uncuff') then return end
    return true
end)


for k, v in pairs (locations.FillPrescription) do
    ps.boxTarget('pharma' ..k , v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-capsules',
            label = Bridge.Language.Locale('pharma.targetFill'),
            action = function()
                if not ps.progressbar(Bridge.Language.Locale('pharma.fill'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:fillprescription", k)
            end,
        }
    })
end