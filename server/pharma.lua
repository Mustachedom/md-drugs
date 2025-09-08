local pharmaLocations = {
    FillPrescription = { -- where to fill out your prescription
        {loc = vector3(2855.62, 4446.73, 48.53), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
}

ps.registerCallback('md-drugs:server:GetPharmaLocs', function()
	return pharmaLocations
end)

local function GetJob(source)
	local src = source
	return ps.getJobType(src) == 'ems'
end

ps.createUseable('prescription_pad', function(source, item)
	local src = source
	local near = {}
	if GetJob(src) then
		near = ps.getNearbyPlayers(src, 5.0)
		local options = { 
			{label = ps.getItemLabel('vicodin_prescription'),  value = 'vicodin_prescription'},
			{label = ps.getItemLabel('adderal_prescription'),  value = 'adderal_prescription'},
			{label = ps.getItemLabel('morphine_prescription'), value = 'morphine_prescription'},
			{label = ps.getItemLabel('xanax_prescription'),    value = 'xanax_prescription'}
		}
		local data = ps.callback('md-drugs:client:prescriptionpad', src, near, options)
		if not data then return ps.notify(src, ps.lang('pharma.canceled'), "error") end
		ps.addItem(ps.getSource(data.who), data.what, 1)
	end
end)

local pharmabottle = {'vicodinbottle', 'adderalbottle','morphinebottle','xanaxbottle'}
for m, d in pairs (pharmabottle) do
	ps.createUseable(d, function(source, item)
		local src = source
		local check = ps.callback("md-drugs:client:unbottle", src)
		if check then
			local get = {
				['vicodinbottle'] = 'vicodin',
				['adderalbottle'] = 'adderal',
				['morphinebottle'] = 'morphine',
				['xanaxbottle'] = 'xanax'
			}
			for k, v in pairs (get) do 
				if d == k then
					if ps.removeItem(src, d, 1) then
						ps.addItem(src, v, math.random(10,30))
						ps.notify(src,ps.lang('pharma.unbottle'), "success")
					end
				end
			end
		end
	end)
end

RegisterServerEvent('md-drugs:server:fillprescription', function(num)
	local src = source
	if timeOut(src, 'md-drugs:server:fillprescription') then return end
	if not ps.checkDistance(src, pharmaLocations.FillPrescription[num].loc, 3.5) then
		return ps.notify(src, ps.lang('Catches.notIn'), "error")
	end
	local pres = {
		vicodin_prescription = 'vicodinbottle',
		adderal_prescription = 'adderalbottle',
		morphine_prescription = 'morphinebottle',
		xanax_prescription = 'xanaxbottle'
	}
	for k, v in pairs (pres) do
		if ps.hasItem(src, k, 1) then
			ps.removeItem(src, k, 1)
			ps.addItem(src, v, 1)
			break
		end
	end
end)
