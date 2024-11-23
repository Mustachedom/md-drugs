local QBCore = exports['qb-core']:GetCoreObject()

local function GetJob(source) 
	local src = source
	local Player = getPlayer(src) 
	if Player.PlayerData.job.type == 'ems' then
		return true
	else
		return false
	end
end

QBCore.Functions.CreateUseableItem('prescription_pad', function(source, item)
	local src = source
	local near = {}
	if GetJob(src) then 
		for k, v in pairs (QBCore.Functions.GetQBPlayers()) do
			local targ = QBCore.Functions.GetPlayerByCitizenId(v.PlayerData.citizenid) 
			local tname = GetName(v.PlayerData.source)
			local ped, tped = GetPlayerPed(src), GetPlayerPed(v.PlayerData.source)
			local dist = #(GetEntityCoords(ped) - GetEntityCoords(tped)) 
			if dist < 5.0 then
				table.insert(near, {label = tname, value = targ.PlayerData.citizenid})
			end
		end
		local options = { {label = 'Vicodin', value = 'vicodin_prescription'}, {label = 'Adderal', value = 'adderal_prescription'}, {label = 'Morphine', value = 'morphine_prescription'},{label = 'Xanax', value = 'xanax_prescription'}}
		local data = lib.callback.await('md-drugs:client:prescriptionpad', src, near, options)
		if type(data) == 'table' then
			local give = QBCore.Functions.GetPlayerByCitizenId(data.who)
			for i = 1, #options do
				if data.what == options[i].value then
					AddItem(give.PlayerData.source, data.what, 1)
				end
			end
		end
	end
end)

local pharmabottle = {'vicodinbottle', 'adderalbottle','morphinebottle','xanaxbottle'}
for m, d in pairs (pharmabottle) do
QBCore.Functions.CreateUseableItem(d, function(source, item)
	local src = source
	local Player = getPlayer(src)
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
    local Player = getPlayer(src)
	local pres = {vicodin_prescription = 'vicodinbottle', adderal_prescription = 'adderalbottle', morphine_prescription = 'morphinebottle', xanax_prescription = 'xanaxbottle'}
	for k, v in pairs (pres) do
		if Player.Functions.GetItemByName(k) then
			RemoveItem(src, k, 1 ) 
			AddItem(src,v, 1)
			break
		end
	end
	Log(GetName(src) .. ' Filled A Prescription!', 'pharma')
end)
