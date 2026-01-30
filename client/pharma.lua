repeat Wait(100) until GlobalState.MDDrugsLocations.Pharma ~= nil
local locations = GlobalState.MDDrugsLocations.Pharma

Bridge.Callback.Register("md-drugs:client:prescriptionpad", function( data, op)
    local job = Bridge.Framework.GetPlayerJob()
    if job ~= 'ambulance' then
       Bridge.Notify.SendNotify(Bridge.Language.Locale('pharma.notPharma'), 'error')
        return
    end
    local input = Bridge.Input.Open(Bridge.Language.Locale('pharma.input.header'), {
        {type = 'select', title = Bridge.Language.Locale('pharma.input.title1'), options = data},
        {type = 'select', title = Bridge.Language.Locale('pharma.input.title2'), options = op}
    })
    if not input[1] then return end
    if not progressbar(Bridge.Language.Locale('pharma.write'), 4000, {
        dict = 'missheistdockssetup1clipboard@base',
        clip = 'base',
        flag = 49,
        prop = {
            model = 'prop_notepad_01',
            bone = 18905,
            pos = {0.1, 0.02, 0.03},
            rot = { -90.0, 0.0, 0.0}
        }
    }) then return end
    return {who = input[1], what = input[2]}
end)

Bridge.Callback.Register("md-drugs:client:unbottle", function() 
    if not progressbar(Bridge.Language.Locale('pharma.opening')) then return end
    return true
end)


for k, v in pairs (locations.FillPrescription) do
    Bridge.Target.AddBoxZone('pharma' ..k , v.loc,v.size, v.loc.w or 180, {
        {
            icon = Bridge.Language.Locale('pharma.fillIcon'),
            label = Bridge.Language.Locale('pharma.targetFill'),
            action = function()
                if not progressbar(Bridge.Language.Locale('pharma.fill')) then return end
	            TriggerServerEvent("md-drugs:server:fillprescription", k)
            end,
        }
    })
end