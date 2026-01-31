local exploded, drying = false, false
local locations, recipes = Config.Weed.Locations, Config.Weed.Recipes
for k, v in pairs (locations.WeedDry) do
	Bridge.Target.AddBoxZone('weed_dry'..k, v.loc, v.size, v.loc.w or 180.0, {
		{
			icon = Bridge.Language.Locale('weed.targetDryIcon'),
			label = Bridge.Language.Locale('weed.targetDry'),
			action = function()
				if not itemCheck("wetcannabis") then return end
				if drying then return end
				local loc = GetEntityCoords(PlayerPedId())
				local weedplant = CreateObject("bkr_prop_weed_drying_01a", loc.x, loc.y+.2, loc.z, true, false)
				drying = true
				FreezeEntityPosition(weedplant, true)
				Bridge.Notify.SendNotify(Bridge.Language.Locale('weed.wait'), "success")
				Wait(math.random(1000,5000))
				Bridge.Notify.SendNotify(Bridge.Language.Locale('weed.take'), "success")
				Bridge.Target.AddLocalEntity(weedplant, {
					{
						icon = Bridge.Language.Locale('weed.targetDryIcon'),
						label = Bridge.Language.Locale('weed.targetDryed'),
						action = function()
							DeleteEntity(weedplant)
							drying = false
							TriggerServerEvent('md-drugs:server:dryoutweed', k)
						end,
					}
				})
			end,
			canInteract = function()
				if drying then return false end
				return true
			end
		}
	})
	targets[#targets+1] = 'weed_dry'..k
end

for k, v in pairs (locations.WeedTele) do
	Bridge.Target.AddBoxZone('weed_tele'..k, v.inside, v.size, v.rot or 180.0, {
		{
			icon = Bridge.Language.Locale('weed.teleportOutIcon'),
			label = Bridge.Language.Locale('weed.teleportOut'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.outside)
			end
		}
	})
	targets[#targets+1] = 'weed_tele'..k
	Bridge.Target.AddBoxZone('weed_teleout'..k, v.outside, v.size, v.rot or 180.0, {
		{
			icon = Bridge.Language.Locale('weed.teleportInIcon'),
			label = Bridge.Language.Locale('weed.teleportIn'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.inside)
			end
		}
	})
	targets[#targets+1] = 'weed_teleout'..k
end

CreateThread(function()
    BikerWeedFarm = exports['bob74_ipl']:GetBikerWeedFarmObject()
    BikerWeedFarm.Style.Set(BikerWeedFarm.Style.upgrade)
    BikerWeedFarm.Security.Set(BikerWeedFarm.Security.upgrade)
    BikerWeedFarm.Details.Enable(BikerWeedFarm.Details.chairs, true)
    BikerWeedFarm.Details.Enable({BikerWeedFarm.Details.production, BikerWeedFarm.Details.chairs, BikerWeedFarm.Details.drying}, true)
	BikerWeedFarm.Plant1.Clear(false) BikerWeedFarm.Plant2.Clear(false) BikerWeedFarm.Plant3.Clear(false)
	BikerWeedFarm.Plant4.Clear(false) BikerWeedFarm.Plant5.Clear(false) BikerWeedFarm.Plant6.Clear(false)
	BikerWeedFarm.Plant7.Clear(false) BikerWeedFarm.Plant8.Clear(false) BikerWeedFarm.Plant9.Clear(false)
    RefreshInterior(BikerWeedFarm.interiorId)
end)

local function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

RegisterNetEvent("md-drugs:client:dodabs", function()
	if not progressbar(Bridge.Language.Locale('weed.dabs'), 4000, 'bong2') then AlienEffect() return end
end)

local function createBluntOptions(contextId, contextTitle, eventLabelPrefix, tableName)
    local options = {}
	
    for k, v in pairs(recipes[tableName]) do
        local label = {}
        local item = ''
        for m, d in pairs(v.take) do table.insert(label, Bridge.Inventory.GetItemInfo(m).label .. ' X ' .. d .. ' \n  ') end 
		for m, d in pairs(v.give) do item = m end
		local itemData = Bridge.Inventory.GetItemInfo(item)
        options[#options + 1] = {
            icon = itemData.image,
            description = table.concat(label, " "),
            title = itemData.label,
			onSelect = function()
				if not minigame() then return end
				if not progressbar(eventLabelPrefix .. itemData.label) then return end
				TriggerServerEvent('md-drugs:server:MakeWeedItems', {item = item, recipe = 'weed', num = k, table = tableName})
			end
        }
    end
    Bridge.Menu.Open({
		id = contextId,
		title = contextTitle,
		options = options,
	})
end

RegisterNetEvent('md-drugs:client:makeBluntWrap', function(data)
	createBluntOptions('mddrugsbluntwraps', "Dipping Syrup", Bridge.Language.Locale('weed.bluntWrap'), 'bluntwrap')
end)

RegisterNetEvent('md-drugs:client:rollBlunt', function(data)
	createBluntOptions('mddrugsblunts', "Roll Blunts", Bridge.Language.Locale('weed.blunts'), 'blunts')
end)

for k, v in pairs (locations.WeedSalesman) do
	requestModel(v.ped)
	local ped = CreatePed(4, v.ped, v.loc.x, v.loc.y, v.loc.z - 1.0, v.loc.w, false, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	Bridge.Target.AddLocalEntity(ped, {
		{
			icon = Bridge.Language.Locale('weed.salesIcon'),
			label = Bridge.Language.Locale('weed.targetSales'),
			action = function()
				local options = {}
				for m, d in pairs (recipes.weedStore) do
					local itemInfo = Bridge.Inventory.GetItemInfo(m)
					options[#options + 1] = {
						icon = itemInfo.image,
						title = itemInfo.label,
						description = '$' .. d,
						onSelect = function()
							local input = Bridge.Input.Open(Bridge.Language.Locale('weed.salesHeader'),{
								{type = 'number', title = Bridge.Language.Locale('weed.salesDesc'), min = 1, max = 1000}
							})
							if not input and input[1] then return end
							if not progressbar(Bridge.Language.Locale('weed.buying', Bridge.Inventory.GetItemInfo(m).label)) then return end
							TriggerServerEvent('md-drugs:server:buyWeedItem', k, m, input[1])
						end
					}
				end
				Bridge.Menu.Open({
					id = 'weedDude',
					title = Bridge.Language.Locale('weed.salessHeader'),
					options = options,
				})
			end
		}
	})
	targets[#targets+1] = ped
end

local props = {}

for locationKey, locationData in pairs (locations.MakeButter) do
	if locationData.prop then
		requestModel(locationData.prop)
		props[#props+1] = CreateObject(locationData.prop, locationData.loc.x, locationData.loc.y, locationData.loc.z - 1.0, false, false, false)
		FreezeEntityPosition(props[#props], true)
		SetEntityHeading(props[#props], locationData.loc.w)
		Bridge.Target.AddLocalEntity(props[#props], {
			{
				icon = Bridge.Language.Locale('weed.cannabisIcon'),
				label = Bridge.Language.Locale('weed.targetMakeButter'),
				action = function()
					local options = {}
					for k, v in pairs (recipes.makeButter) do
						local itemInfo = Bridge.Inventory.GetItemInfo(k)
						local label = {}
						for m, d in pairs(v.recipe) do table.insert(label, Bridge.Inventory.GetItemInfo(m).label .. ' X ' .. d .. '  \n  ') end 
						options[#options + 1] = {
							icon = itemInfo.image,
							title = itemInfo.label,
							description = table.concat(label, " "),
							onSelect = function()
								if not progressbar(Bridge.Language.Locale('weed.making', itemInfo.label)) then return end
								TriggerServerEvent('md-drugs:server:MakeWeedItems', 'makeButter', k, locationKey)
							end
						}
					end
					Bridge.Menu.Open({
						id = 'weedMakeButter',
						title = Bridge.Language.Locale('weed.makeButter'),
						options = options,
					})
				end
			}
		})
		targets[#targets+1] = props[#props]
	end
end
for locationKey, locationData in pairs (locations.MakeOil) do
	if locationData.prop then
		requestModel(locationData.prop)
		props[#props+1] = CreateObject(locationData.prop, locationData.loc.x, locationData.loc.y, locationData.loc.z - 1.0, false, false, false)
		FreezeEntityPosition(props[#props], true)
		SetEntityHeading(props[#props], locationData.loc.w)
		Bridge.Target.AddLocalEntity(props[#props], {
			{
				icon = Bridge.Language.Locale('weed.cannabisIcon'),
				label = Bridge.Language.Locale('weed.targetMakeOil'),
				action = function()
					local options = {}
					for k, v in pairs (recipes.makeOil) do
						local itemInfo = Bridge.Inventory.GetItemInfo(k)
						local label = {}
						for m, d in pairs(v.recipe) do table.insert(label, Bridge.Inventory.GetItemInfo(m).label .. ' X ' .. d .. '  \n  ') end 
						options[#options + 1] = {
							icon = itemInfo.image,
							title = itemInfo.label,
							description = table.concat(label, " "),
							onSelect = function()
								if not progressbar(Bridge.Language.Locale('weed.making', itemInfo.label)) then return end
								TriggerServerEvent('md-drugs:server:MakeWeedItems', 'makeOil', k, locationKey)
							end
						}
					end
					Bridge.Menu.Open({
						id = 'weedMakeOil',
						title = Bridge.Language.Locale('weed.makeOil'),
						options = options,
					})
				end
			}
		})
		targets[#targets+1] = props[#props]
	end
end