local exploded, drying = false, false
local locations = ps.callback('md-drugs:server:GetWeedLocs')
for k, v in pairs (locations.WeedDry) do
	ps.boxTarget('weed_dry'..k, v.loc, {length = v.l, width = v.w, heading = v.rot}, {
		{
			icon = 'fa-solid fa-cannabis',
			label = ps.lang('weed.targetDry'),
			action = function()
				if not ps.hasItem('wetcannabis', 1) then
					ps.notify(ps.lang('weed.noDry'), "error")
					return
				end
				if drying then return end
				local loc = GetEntityCoords(PlayerPedId())
				local weedplant = CreateObject("bkr_prop_weed_drying_01a", loc.x, loc.y+.2, loc.z, true, false)
				drying = true
				FreezeEntityPosition(weedplant, true)
				ps.notify(ps.lang('weed.wait'), "success")
				Wait(math.random(1000,5000))
				ps.notify(ps.lang('weed.take'), "success")
				ps.entityTarget(weedplant, {
					{
						icon = "fa-solid fa-cannabis",
						label = ps.lang('weed.targetDryed'),
						action = function()
							DeleteEntity(weedplant)
							drying = false
							TriggerServerEvent('md-drugs:server:dryoutweed')
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
end

for k, v in pairs (locations.WeedTele) do
	ps.boxTarget('weed_tele'..k, v.inside, {length = v.l, width = v.w, heading = v.rot}, {
		{
			icon = 'fa-solid fa-door-open',
			label = ps.lang('weed.teleportOut'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.outside)
			end
		}
	})
	ps.boxTarget('weed_teleout'..k, v.outside, {length = v.l, width = v.w, heading = v.rot}, {
		{
			icon = 'fa-solid fa-door-closed',
			label = ps.lang('weed.teleportIn'),
			action = function()
				SetEntityCoords(PlayerPedId(), v.inside)
			end
		}
	})
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
	if not ps.progressbar(ps.lang('weed.dabs'), 4000, 'bong2') then AlienEffect() return end
end)

local function createBluntOptions(contextId, contextTitle, eventLabelPrefix, tableName)
    local options = {}
	local items = ps.callback('md-drugs:server:GetWeedRecipe', tableName)
    for k, v in pairs(items) do
        local label = {}
        local item = ''
        for m, d in pairs(v.take) do table.insert(label, ps.getLabel(m) .. ' X ' .. d) end 
		for m, d in pairs(v.give) do item = m end
        options[#options + 1] = {
            icon = ps.getImage(item),
            description = table.concat(label, ", "),
            title = ps.getLabel(item),
			action = function()
				if not minigame() then return end
				if not ps.progressbar(eventLabelPrefix .. ps.getLabel(item), 4000, 'uncuff') then return end
				TriggerServerEvent('md-drugs:server:MakeWeedItems', {item = item, recipe = 'weed', num = k, table = tableName})
			end
        }
    end
    ps.sorter(options, 'title')
    ps.menu(contextTitle, contextTitle, options)
end

RegisterNetEvent('md-drugs:client:makeBluntWrap', function(data)
	createBluntOptions('mddrugsbluntwraps', "Dipping Syrup", ps.lang('weed.bluntWrap'), 'bluntwrap')
end)

RegisterNetEvent('md-drugs:client:rollBlunt', function(data)
	createBluntOptions('mddrugsblunts', "Roll Blunts", ps.lang('weed.blunts'), 'blunts')
end)

for k, v in pairs (locations.WeedSalesman) do
	ps.requestModel(v.ped)
	local ped = CreatePed(4, v.ped, v.loc.x, v.loc.y, v.loc.z - 1.0, v.loc.w, false, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	ps.entityTarget(ped, {
		{
			icon = "fa-solid fa-cannabis",
			label = ps.lang('weed.targetSales'),
			action = function()
				local itemList = ps.callback('md-drugs:server:getWeedItems')
				local options = {}
				for m, d in pairs (itemList) do
					options[#options + 1] = {
						icon = ps.getImage(m),
						title = ps.getLabel(m),
						description = '$' .. d,
						action = function()
							local input = ps.input('Amount To Buy',{
								{type = 'number', title = 'How Many To Buy', min = 1, max = 1000}
							})
							if not input and input[1] then return end
							if not ps.progressbar(ps.lang('weed.buying', ps.getLabel(m)), 2000, 'uncuff') then return end
							TriggerServerEvent('md-drugs:server:buyWeedItem', k, m, input[1])
						end
					}
				end
				ps.menu('Weed Shop', 'Weed Shop', options)
			end
		}
	})
end

