Locations = Locations or {}

Locations.Pharma = {
    FillPrescription = { -- where to fill out your prescription
        {loc = vector3(2855.62, 4446.73, 48.53), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
}
GlobalState.MDDrugsLocations = Locations

local function GetJob(source)
	local src = source
	local jobName = Bridge.Framework.GetPlayerJob(src)
	return jobName == 'ambulance'
end

local function getNearby(src, distance)
	local players = Bridge.Framework.GetPlayers()
	local nearPlayers = {}
	for index, sources in pairs(players) do
		--if sources ~= src then
			local target = GetEntityCoords(GetPlayerPed(sources))
			local you = GetEntityCoords(GetPlayerPed(src))
			local distanceBetween = #(you - target)
			if distanceBetween <= distance then
				table.insert(nearPlayers, {label = Bridge.Framework.GetPlayerName(sources), value = sources})
			end
		--end
	end
	return nearPlayers
end

Bridge.Framework.RegisterUsableItem('prescription_pad', function(source, item)
	local src = source
	local near = {}
	if GetJob(src) then
		near = getNearby(src, 5.0)
		local options = { 
			{label = Bridge.Inventory.GetItemInfo('vicodin_prescription').label,  value = 'vicodin_prescription'},
			{label = Bridge.Inventory.GetItemInfo('adderal_prescription').label,  value = 'adderal_prescription'},
			{label = Bridge.Inventory.GetItemInfo('morphine_prescription').label, value = 'morphine_prescription'},
			{label = Bridge.Inventory.GetItemInfo('xanax_prescription').label,    value = 'xanax_prescription'}
		}
		local data = Bridge.Callback.Trigger('md-drugs:client:prescriptionpad', src, near, options)
		if not data then return Bridge.Notify.SendNotify(src, Bridge.Language.Locale('pharma.canceled'), "error") end
		Bridge.Framework.AddItem(data.who, data.what, 1)
	end
end)

local pharmabottle = {'vicodinbottle', 'adderalbottle','morphinebottle','xanaxbottle'}
for m, d in pairs (pharmabottle) do
	Bridge.Framework.RegisterUsableItem(d, function(source, item)
		local src = source
		local check = Bridge.Callback.Trigger("md-drugs:client:unbottle", src)
		if check then
			local get = {
				['vicodinbottle'] = 'vicodin',
				['adderalbottle'] = 'adderal',
				['morphinebottle'] = 'morphine',
				['xanaxbottle'] = 'xanax'
			}
			for k, v in pairs (get) do 
				if d == k then
					if Bridge.Framework.RemoveItem(src, d, 1) then
						Bridge.Framework.AddItem(src, v, math.random(10,30))
						Bridge.Notify.SendNotify(src,Bridge.Language.Locale('pharma.unbottle'), "success")
					end
				end
			end
		end
	end)
end

RegisterServerEvent('md-drugs:server:fillprescription', function(num)
	local src = source
	
	if timeOut(src, 'md-drugs:server:fillprescription') then return end
	if not checkDistance(src, Locations.Pharma.FillPrescription[num].loc, 3.5) then
		return Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notIn'), "error")
	end
	local pres = {
		vicodin_prescription = 'vicodinbottle',
		adderal_prescription = 'adderalbottle',
		morphine_prescription = 'morphinebottle',
		xanax_prescription = 'xanaxbottle'
	}
	for k, v in pairs (pres) do
		if Bridge.Framework.HasItem(src, k, 1) then
			Bridge.Framework.RemoveItem(src, k, 1)
			Bridge.Framework.AddItem(src, v, 1)
			break
		end
	end
end)
