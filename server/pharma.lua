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
	local Player = getPlayer(src)
	local name = GetName(src)
	local near = {}

	if GetJob(src) then 
		for k, v in pairs (QBCore.Functions.GetQBPlayers()) do
			local targ = QBCore.Functions.GetPlayerByCitizenId(v.PlayerData.citizenid) 
			local tname = GetName(v.PlayerData.source)
			table.insert(near, {label = tname, value = targ.PlayerData.citizenid})
		end
		local data = lib.callback.await('md-drugs:client:prescriptionpad', src, near)
		if type(data) == 'table' then
			local give = QBCore.Functions.GetPlayerByCitizenId(data.who)
			AddItem(give.PlayerData.source, data.what, 1)
		end
	end	
end)

RegisterServerEvent('md-drugs:server:unbottle', function(item)
	local src = source
	local amount = math.random(10,30)
	AddItem(src, item, amount)
	Log(GetName(src) .. ' Unbottled '.. amount .. ' Of ' .. item .. '!', 'pharma')
end)

local pharmabottle = {'vicodinbottle', 'adderalbottle','morphinebottle','xanaxbottle'}
for m, d in pairs (pharmabottle) do
QBCore.Functions.CreateUseableItem(d, function(source, item)
	local src = source
	if RemoveItem(src, d, 1) then
		TriggerClientEvent("md-drugs:client:unbottle", src, item)
	end	
end)
end


RegisterServerEvent('md-drugs:server:fillprescription', function()
	local src = source
    local Player = getPlayer(src)
	local vic = Player.Functions.GetItemByName('vicodin_prescription')
	local add = Player.Functions.GetItemByName('adderal_prescription')
	local mor = Player.Functions.GetItemByName('morphine_prescription')
	local xan = Player.Functions.GetItemByName('xanax_prescription')	
	if vic then
		RemoveItem(src,'vicodin_prescription', 1 ) 
		AddItem(src,'vicodinbottle', 1) 
		Notifys(src,Lang.Pharma.pills, "success")
	elseif add then
		RemoveItem(src,'adderal_prescription', 1 ) 
		AddItem(src,'adderalbottle', 1) 
		Notifys(src,Lang.Pharma.pills, "success")
	elseif mor then
		RemoveItem(src,'morphine_prescription', 1 ) 
		AddItem(src,'morphinebottle', 1) 
		Notifys(src,Lang.Pharma.pills, "success")	
	elseif xan then
		RemoveItem(src,'xanax_prescription', 1 ) 
		AddItem(src,'xanaxbottle', 1) 
		Notifys(src,Lang.Pharma.pills, "success")	
	else
		Notifys(src,Lang.Pharma.no, "error")
	end
	Log(GetName(src) .. ' Filled A Prescription!', 'pharma')
end)
