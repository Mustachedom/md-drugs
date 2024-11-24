local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("md-drugs:client:getsyruplocationtobuy", function()
	Notify(Lang.Lean.marked, "success")
	SpawnCarPedChase()
end)

RegisterNetEvent('md-drugs:client:leancraft', function()
local store = {} 
local label = {}
local items = lib.callback.await('md-drugs:server:GetRecipe', false,'lean', 'cups')
for k, v in pairs (items) do
	label = {}
	local item = ''
	 for m, d in pairs (items[k].take) do  table.insert(label, GetLabel(m) .. ' X ' .. d) end
	 for m,d in pairs (items[k].give) do item = m end
	 store[#store + 1] = {
		icon =  GetImage(item),
		description = table.concat(label, ", "),
		title = GetLabel(item),
		event = 'md-drugs:client:stirlean',
		args = {
			item = item, 
			recipe = 'lean',
			num = k,
			label = 'Cooking Up ' .. GetLabel(item),
			table = 'cups'
		}
	}
	sorter(store, 'title')
	lib.registerContext({id = 'leanCraft',title = "Make Lean", options = store})
end
lib.showContext('leanCraft')
end)

local busy = false
RegisterNetEvent('md-drugs:client:stirlean', function(data) 
	if busy then return end
	 busy = true
	if not progressbar(data.label, 4000, 'uncuff') then busy = false return end
	TriggerServerEvent('md-drugs:server:finishcup', data)
	busy = false
end)