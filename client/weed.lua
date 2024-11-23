local QBCore = exports['qb-core']:GetCoreObject()
local WeedPlant = {}
local exploded, drying = false, false

local function hasJob()
	if Config.Joblock then
		if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
		return true else return false end
	else
	return true end
 end

RegisterNetEvent('weed:respawnCane', function(loc)
    local v = GlobalState.WeedPlant[loc]
    local hash = GetHashKey(v.model)
    if not HasModelLoaded(hash) then LoadModel(hash) end
    if not WeedPlant[loc] then
        WeedPlant[loc] = CreateObject(hash, v.location.x, v.location.y, v.location.z-3.5, false, true, true)
		Freeze(WeedPlant[loc],true,  v.heading)
        AddSingleModel(WeedPlant[loc],  
			    {icon = "fas fa-hand",label = Lang.targets.weed.pick, 
				action = function()if not progressbar(Lang.Weed.pick, 4000, 'uncuff') then return end	TriggerServerEvent("weed:pickupCane", loc) end},
			loc)
    end
end)

RegisterNetEvent('weed:removeCane', function(loc)
    if DoesEntityExist(WeedPlant[loc]) then DeleteEntity(WeedPlant[loc]) end
    WeedPlant[loc] = nil
end)

RegisterNetEvent("weed:init", function()
    for k, v in pairs (GlobalState.WeedPlant) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            WeedPlant[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z-3.5, false, true, true)
			Freeze(WeedPlant[k],true,  v.heading)
			AddSingleModel(WeedPlant[k],  
			    {icon = "fas fa-hand",label = Lang.targets.weed.pick, 
				action = function()if not progressbar(Lang.Weed.pick, 4000, 'uncuff') then return end	TriggerServerEvent("weed:pickupCane", k) end},
			k)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('bkr_prop_weed_lrg_01b'))
        for k, v in pairs(WeedPlant) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)

CreateThread(function()
	local config = lib.callback.await('md-drugs:server:getLocs', false)
	AddBoxZoneMulti('weeddry', config.WeedDry, {
		name = 'dryweed',
		icon = "fas fa-sign-in-alt",
		label = Lang.targets.weed.dry,
		distance = 1,
		action = function()
			if not ItemCheck('wetcannabis') then return end
			if drying then
				Notify(Lang.Weed.busy, "error")
			else
				local loc = GetEntityCoords(PlayerPedId())
				local weedplant = CreateObject("bkr_prop_weed_drying_01a", loc.x, loc.y+.2, loc.z, true, false)
				drying = true
				FreezeEntityPosition(weedplant, true)
				Notify(Lang.Weed.wait, "success")
				Wait(math.random(1000,5000))
				Notify(Lang.Weed.take, "success")
				AddSingleModel(weedplant, {
					icon = "fas fa-sign-in-alt",
					label = Lang.targets.weed.dpick,
					action = function()
						DeleteEntity(weedplant)
						drying = false
						TriggerServerEvent('md-drugs:server:dryoutweed')
					end,
					canInteract = function()
						if hasJob() then return true end end									
				}, nil)
			end
		end,
		canInteract = function()
			if hasJob() then return true end end	
	})

AddBoxZoneSingle('teleinweedout', config.singleSpot.weedTeleout, { name = 'teleout', icon = "fas fa-sign-in-alt", label = Lang.targets.coke.exit, distance = 2.0, action = function() SetEntityCoords(PlayerPedId(),config.singleSpot.weedTelein) end,
	canInteract = function() if hasJob() then return true end end	
}) 
AddBoxZoneSingle('teleinweedin', config.singleSpot.weedTelein, { name = 'teleout', icon = "fas fa-sign-in-alt", label = Lang.targets.coke.enter, distance = 2.0, action = function() SetEntityCoords(PlayerPedId(),config.singleSpot.weedTeleout) end,
	canInteract = function() if hasJob() then return true end end	
}) 
AddBoxZoneSingle('MakeButterCrafting', config.singleSpot.MakeButter, {label = Lang.targets.weed.butt, action = function() lib.showContext('ButterCraft') end, icon = "fas fa-sign-in-alt", 
canInteract = function() if hasJob() then return true end end	
}) 

AddBoxZoneSingle('makeoil',config.singleSpot.MakeOil, {
	name = 'Oil',
	icon = "fas fa-sign-in-alt",
	label = Lang.targets.weed.oil,
	action = function()
		if not ItemCheckMulti({'butane', 'grindedweed'}) then return end
		if not minigame() then 
			local explosion = math.random(1,100)
			local loc = GetEntityCoords(PlayerPedId())
			if explosion <= 99 then
				AddExplosion(loc.x, loc.y, loc.z, 49, 10, true, false, true, true)
				exploded = true
				Notify(Lang.Weed.stovehot, "error")
				Wait(1000 * 30)
				exploded = false
			end	
		return end
		if not progressbar(Lang.Weed.shat, 4000, 'uncuff') then return end
		TriggerServerEvent("md-drugs:server:makeoil")       			
	end,
	canInteract = function()
	if hasJob() and exploded == false then return true end
	end,
} )
	local stove = CreateObject("prop_cooker_03",config.singleSpot.MakeButter.x, config.singleSpot.MakeButter.y, config.singleSpot.MakeButter.z-1, true, false)
	SetEntityHeading(stove, 270.00)
	FreezeEntityPosition(stove, true)
	local stove2 = CreateObject("prop_cooker_03",config.singleSpot.MakeOil.x,config.singleSpot.MakeOil.y, config.singleSpot.MakeOil.z-1, true, false)
	SetEntityHeading(stove2, 90.00)
	FreezeEntityPosition(stove2, true)
end)

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


RegisterNetEvent("md-drugs:client:rollanim", function()
if not progressbar(Lang.Weed.roll, 4000, 'uncuff') then return end
end)

RegisterNetEvent("md-drugs:client:grind", function()
	if not progressbar("grinding", 4000, 'uncuff') then return end
end)

RegisterNetEvent("md-drugs:client:dodabs", function()
if not progressbar('Doing Dabs', 4000, 'bong2') then AlienEffect() return end
AlienEffect()
end)

local function createBluntOptions(contextId, contextTitle, eventLabelPrefix, tableName)
    local options = {}
	local items = lib.callback.await('md-drugs:server:GetRecipe', false,'weed',tableName)
    for k, v in pairs(items) do
        local label = {}
        local item = ''
        for m, d in pairs(v.take) do table.insert(label, GetLabel(m) .. ' X ' .. d) end 
		for m, d in pairs(v.give) do item = m end
        options[#options + 1] = {
            icon = GetImage(item),
            description = table.concat(label, ", "),
            title = GetLabel(item),
            event = "md-drugs:client:MakeWeedItems",
            args = {
                item = item, 
                recipe = 'weed',
                num = k,
                label = eventLabelPrefix .. GetLabel(item),
                table = tableName
            }
        }
    end
    sorter(options, 'title')
    lib.registerContext({
        id = contextId,
        title = contextTitle,
        options = options
    })
end

CreateThread(function()
createBluntOptions('ButterCraft', "Edible Cooking", 'Cooking A ', 'edibles')
createBluntOptions('mddrugsblunts', "Roll Blunts", 'Rolling A ', 'blunts')
createBluntOptions('mddrugsbluntwraps', "Dipping Syrup", 'Dipping Syrup To Make ', 'bluntwrap')
end)

RegisterNetEvent("md-drugs:client:MakeWeedItems", function(data)
	if not minigame() then return end
	if not progressbar('Making ' .. data.item, 4000, 'uncuff') then return end
	TriggerServerEvent('md-drugs:server:MakeWeedItems', data)
end)

RegisterNetEvent('md-drugs:client:makeBluntWrap', function(data)
	lib.showContext('mddrugsbluntwraps')
end)

RegisterNetEvent('md-drugs:client:rollBlunt', function(data)
	lib.showContext('mddrugsblunts')
end)