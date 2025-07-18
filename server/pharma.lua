local QBCore = exports['qb-core']:GetCoreObject()

local function GetJob(source)
	local src = source
	return ps.getJobType(src) == 'ems'
end

ps.createUseable('prescription_pad', function(source, item)
	local src = source
	local near = {}
	if GetJob(src) then
		local near = ps.getNearbyPlayers(src, 5.0)

		local options = { 
			{label = 'Vicodin',  value = 'vicodin_prescription'},
			{label = 'Adderal',  value = 'adderal_prescription'},
			{label = 'Morphine', value = 'morphine_prescription'},
			{label = 'Xanax',    value = 'xanax_prescription'}
		}
		local data = ps.callback('md-drugs:client:prescriptionpad', src, near, options)
		if not data then return ps.notify(src, ps.lang('Pharma.cancel'), "error") end
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
					ps.removeItem(src, d, 1)
					ps.addItem(src, v, math.random(10,30))
					ps.notify(src,ps.lang('Pharma.unbottle'), "success")
					--Log(GetName(src) .. ' Unbottled 30 Of ' .. v .. '!', 'pharma')
				end
			end
		end
	end)
end

RegisterServerEvent('md-drugs:server:fillprescription', function(num)
	local src = source
	if not ps.checkDistance(src, GlobalState.MDDrugsLocs.FillPrescription[num].loc, 3.5) then
		return ps.notify(src, ps.lang('Pharma.toofar'), "error")
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
	--Log(GetName(src) .. ' Filled A Prescription!', 'pharma')
end)
