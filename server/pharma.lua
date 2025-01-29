
local function getAmbo(source) 
	if Config.Framework == 'qbcore' then
		local Player = QBCore.Functions.GetPlayer(source)
		if Player.PlayerData.job.type == 'ems' then
			return true
		end
	elseif Config.Framework == 'esx' then
		local Player = ESX.GetPlayerFromId(source)
		if Player.job.name == 'ambulance' then
			return true
		end
	end
end

local function getSource(player) 
	if Config.Framework == 'qbcore' then
		return player.PlayerData.source
	elseif Config.Framework == 'esx' then
		return player.source
	end
end

CUI('prescription_pad', function(source, item)
	local src = source
	if getAmbo(src) then 
		local near = getNear(src)
		local options = { {label = 'Vicodin', value = 'vicodin_prescription'}, {label = 'Adderal', value = 'adderal_prescription'}, {label = 'Morphine', value = 'morphine_prescription'},{label = 'Xanax', value = 'xanax_prescription'}}
		local data = lib.callback.await('md-drugs:client:prescriptionpad', src, near, options)
		if type(data) == 'table' then
			local give = getPlayerByCid(data.who)
			for i = 1, #options do
				if data.what == options[i].value then
					AddItem(getSource(give), data.what, 1)
				end
			end
		end
	end
end)

local pharmabottle = {'vicodinbottle', 'adderalbottle','morphinebottle','xanaxbottle'}
for m, d in pairs (pharmabottle) do
	CUI(d, function(source, item)
		local src = source
		local check = lib.callback.await("md-drugs:client:unbottle", src)
		if check then
			local get = {
				['vicodinbottle'] = 'vicodin',
				['adderalbottle'] = 'adderal',
				['morphinebottle'] = 'morphine',
				['xanaxbottle'] = 'xanax'
			}
			for k, v in pairs (get) do 
				if d == k then
					RemoveItem(src, d, 1)
					AddItem(src, v, math.random(10,30))
					Notifys(src,Lang.Pharma.unbottle, "success")
					Log(GetName(src) .. ' Unbottled 30 Of ' .. v .. '!', 'pharma')
				end
			end
		end
	end)
end

RegisterServerEvent('md-drugs:server:fillprescription', function()
	local src = source
	local pres = {vicodin_prescription = 'vicodinbottle', adderal_prescription = 'adderalbottle', morphine_prescription = 'morphinebottle', xanax_prescription = 'xanaxbottle'}
	for k, v in pairs (pres) do
		if hasItem(src, k, 1) then
			RemoveItem(src, k, 1 )
			AddItem(src,v, 1)
			break
		end
	end
	Log(GetName(src) .. ' Filled A Prescription!', 'pharma')
end)
