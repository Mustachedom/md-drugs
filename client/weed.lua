local QBCore = exports['qb-core']:GetCoreObject()
local WeedPlant = {}
local exploded = nil
function LoadModel(hash)
    hash = GetHashKey(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(3000)
    end
end 

RegisterNetEvent('weed:respawnCane', function(loc)
    local v = GlobalState.WeedPlant[loc]
    local hash = GetHashKey(v.model)
    if not HasModelLoaded(hash) then LoadModel(hash) end
    if not WeedPlant[loc] then
        WeedPlant[loc] = CreateObject(hash, v.location.x, v.location.y, v.location.z-3.5, false, true, true)
        SetEntityAsMissionEntity(WeedPlant[loc], true, true)
        FreezeEntityPosition(WeedPlant[loc], true)
        SetEntityHeading(WeedPlant[loc], v.heading)
         exports['qb-target']:AddTargetEntity(WeedPlant[loc], {
            options = { 
				{
                    icon = "fas fa-hand",
                    label = "Pick Weed",
                    action = function()
                        QBCore.Functions.Progressbar("pick_cane", "picking Weed Leaves", 2000, false, true, {
                            disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                            { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                            {}, {}, function()
                            TriggerServerEvent("weed:pickupCane", loc)
                            ClearPedTasks(PlayerPedId())
                        end, function() -- Cancel
                            ClearPedTasks(PlayerPedId())
                        end)
                    end,
					canInteract = function()
						if Config.Joblock then
							if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
								return true end
						else
						return true end end,
                }
            }
           })
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
            SetEntityAsMissionEntity(WeedPlant[k], true, true)
            FreezeEntityPosition(WeedPlant[k], true)
            SetEntityHeading(WeedPlant[k], v.heading)
            exports['qb-target']:AddTargetEntity(WeedPlant[k], {
                options = { 
					{
                        icon = "fas fa-hand",
                        label = "Pick Weed",
                        action = function()
                            QBCore.Functions.Progressbar("pick_cane", "picking Weed Leaves", 2000, false, true, {
                                disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                                { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                                {}, {}, function()
                                TriggerServerEvent("weed:pickupCane", k)
                                ClearPedTasks(PlayerPedId())
                            end, function() -- Cancel
                                ClearPedTasks(PlayerPedId())
                            end)
                        end,
						canInteract = function()
						if Config.Joblock then
							if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
								return true end
						else
						return true end end,
                    }
                }
               })
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        LoadModel('bkr_prop_weed_lrg_01b')
        TriggerEvent('weed:init')
    end
 end)
 RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('bkr_prop_weed_lrg_01b')
     TriggerEvent('weed:init')
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


for k, v in pairs (Config.WeedDry) do

exports['qb-target']:AddBoxZone("weeddry"..k,v,1.5, 1.75, { -- 963.37, .z-2122.95, 31.47
		name = "weeddry"..k,
		heading = 11.0,
		debugPoly = false,
		minZ = v.z-2,
		maxZ = v.z+2,
	}, {
options = {
		{
			name = 'dryweed',
			icon = "fas fa-sign-in-alt",
			label = "Dry Weed",
			distance = 1,
			items = "wetcannabis",
			action = function()
				if drying then
					QBCore.Functions.Notify("Already Drying One Out", "error")
				else
					local loc = GetEntityCoords(PlayerPedId())
					local weedplant = CreateObject("bkr_prop_weed_drying_01a", loc.x, loc.y+.2, loc.z, true, false)
					drying = true
					FreezeEntityPosition(weedplant, true)
					QBCore.Functions.Notify("Wait A little Bit To Dry", "success")
					Wait(math.random(1000,5000))
					QBCore.Functions.Notify("Take Down The Weed", "success")
					exports['qb-target']:AddTargetEntity(weedplant, {
							options = {
								{
									icon = "fas fa-sign-in-alt",
									label = "Pick Up Weed",
									action = function()
										DeleteEntity(weedplant)
										drying = false
										TriggerServerEvent('md-drugs:server:dryoutweed')
									end,
									canInteract = function()
										if Config.Joblock then
											if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
												return true end
										else
										return true end end,										
								}
							}
						})
				end
			end,
			canInteract = function()
			if Config.Joblock then
				if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
					return true end
			else
			return true end end,
		},
	},
})
end
exports['qb-target']:AddBoxZone("teleinweed",Config.Telein,1.5, 1.75, { -- 963.37, .z-2122.95, 31.47
		name = "teleinweed",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.Telein.z-2,
		maxZ = Config.Telein.z+2,
	}, {
options = {
		{
			name = 'teleout',
			icon = "fas fa-sign-in-alt",
			label = "Enter Building",
			distance = 5,
			action = function()
				SetEntityCoords(PlayerPedId(),Config.Teleout)
				
			end,
			canInteract = function()
			if Config.Joblock then
				if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
					return true end
			else
			return true end end,
			
		},
	},	
})
exports['qb-target']:AddBoxZone("teleinweedout",Config.Teleout,1.5, 1.75, { -- 963.37, .z-2122.95, 31.47
		name = "teleinweedout",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.Teleout.z-2,
		maxZ = Config.Teleout.z+2,
	}, {
options = {
		{
			name = 'teleout',
			icon = "fas fa-sign-in-alt",
			label = "Exit Building",
			distance = 5,
			action = function()
				SetEntityCoords(PlayerPedId(),Config.Telein)
				
			end,
			canInteract = function()
			if Config.Joblock then
				if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
					return true end
			else
			return true end end,
			
		},
	},	
})
exports['qb-target']:AddBoxZone("MakeButter",Config.MakeButter,1.5, 1.75, { -- 963.37, .z-2122.95, 31.47
		name = "MakeButter",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.MakeButter.z-2,
		maxZ = Config.MakeButter.z+2,
	}, {
options = {
		{
			name = 'butter',
			icon = "fas fa-sign-in-alt",
			label = "Make Butter",
			action = function()
						TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
						QBCore.Functions.Progressbar("drink_something", "Making Canna Butter", 4000, false, true, {
							disableMovement = false,
							disableCarMovement = false,
							disableMouse = false,
							disableCombat = true,
							disableInventory = true,
						}, {}, {}, {}, function()-- Done
							exports['ps-ui']:Circle(function(success)
						if success then
							TriggerServerEvent("md-drugs:server:makebutter")       
							ClearPedTasks(PlayerPedId())
							else
							ClearPedTasks(PlayerPedId())
							end
						end, 3, 8) -- NumberOfCircles, 
						end)
			end,
			canInteract = function()
			if Config.Joblock then
				if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
					return true end
			else
			return true end end,
		},
		{
			name = 'makebrownies',
			icon = "fas fa-sign-in-alt",
			label = "Make Brownies",
			item = "cannabutter",
			action = function()
					TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
						QBCore.Functions.Progressbar("drink_something", "Making Special Brownies", 4000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
						disableInventory = true,
					}, {}, {}, {}, function()-- Done
					exports['ps-ui']:Circle(function(success)
					if success then
						TriggerServerEvent("md-drugs:server:makebrownies")       
						ClearPedTasks(PlayerPedId())
					else
						ClearPedTasks(PlayerPedId())
					end
					end, 3, 8) -- NumberOfCircles, 
						end)
			end,
			canInteract = function()
			if Config.Joblock then
				if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
					return true end
			else
			return true end end,
		},
		{
			name = 'makecookies',
			icon = "fas fa-sign-in-alt",
			label = "Make Cookies",
			item = "cannabutter",
			action = function()
					TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
						QBCore.Functions.Progressbar("drink_something", "Making Special Cookies", 4000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
						disableInventory = true,
					}, {}, {}, {}, function()-- Done
					exports['ps-ui']:Circle(function(success)
					if success then
						TriggerServerEvent("md-drugs:server:makecookies")       
						ClearPedTasks(PlayerPedId())
					else
						ClearPedTasks(PlayerPedId())
					end
					end, 3, 8) -- NumberOfCircles, 
						end)
			end,
			canInteract = function()
			if Config.Joblock then
				if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
					return true end
			else
			return true end end,
		},
		{
			name = 'makechocolate',
			icon = "fas fa-sign-in-alt",
			label = "Make Chocolate",
			item = "cannabutter",
			action = function()
					TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
						QBCore.Functions.Progressbar("drink_something", "Making Special Chocolate", 4000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
						disableInventory = true,
					}, {}, {}, {}, function()-- Done
					exports['ps-ui']:Circle(function(success)
					if success then
						TriggerServerEvent("md-drugs:server:makechocolate")       
						ClearPedTasks(PlayerPedId())
					else
						ClearPedTasks(PlayerPedId())
					end
					end, 3, 8) -- NumberOfCircles, 
						end)
			end,
			canInteract = function()
			if Config.Joblock then
				if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
					return true end
			else
			return true end end,
		},
		{
			name = 'makemuffin',
			icon = "fas fa-sign-in-alt",
			label = "Make Muffin",
			item = "cannabutter",
			action = function()
					TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
						QBCore.Functions.Progressbar("drink_something", "Making Special Muffin", 4000, false, true, {
						disableMovement = false,
						disableCarMovement = false,
						disableMouse = false,
						disableCombat = true,
						disableInventory = true,
					}, {}, {}, {}, function()-- Done
					exports['ps-ui']:Circle(function(success)
					if success then
						TriggerServerEvent("md-drugs:server:makemuffin")
						ClearPedTasks(PlayerPedId())
					else
						ClearPedTasks(PlayerPedId())
					end
					end, 3, 8) -- NumberOfCircles, 
						end)
			end,
			canInteract = function()
			if Config.Joblock then
				if  QBCore.Functions.GetPlayerData().job.name == Config.weedjob then
					return true end
			else
			return true end end,
		},
	},	
})
exports['qb-target']:AddBoxZone("makeoil",Config.MakeOil,1.5, 1.75, { -- 963.37, .z-2122.95, 31.47
		name = "makeoil",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.MakeOil.z-2,
		maxZ = Config.MakeOil.z+2,
	}, {
options = {
		{
			name = 'Oil',
			icon = "fas fa-sign-in-alt",
			label = "Make Oil",
			action = function()
						TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
						QBCore.Functions.Progressbar("drink_something", "Making Wax Oil", 4000, false, true, {
							disableMovement = false,
							disableCarMovement = false,
							disableMouse = false,
							disableCombat = true,
							disableInventory = true,
						}, {}, {}, {}, function()-- Done
							exports['ps-ui']:Circle(function(success)
						if success then
							TriggerServerEvent("md-drugs:server:makeoil")       
							ClearPedTasks(PlayerPedId())
						else
							local explosion = math.random(1,100)
							local loc = GetEntityCoords(PlayerPedId())
							if explosion <= 99 then
								AddExplosion(loc.x, loc.y, loc.z, 49, 10, true, false, true, true)
								exploded = true
								QBCore.Functions.Notify("Stove Is Too Hot Wait 30 Seconds To Cool Down", "error")
								Wait(1000 * 30)
								exploded = nil
							end	
							ClearPedTasks(PlayerPedId())
							end
						end, 3, 8) -- NumberOfCircles, 
						end)
			end,
			canInteract = function()
			if exploded == nil then return true end
			end,
		},
	},	
})
end)

CreateThread(function()
    BikerWeedFarm = exports['bob74_ipl']:GetBikerWeedFarmObject()
    BikerWeedFarm.Style.Set(BikerWeedFarm.Style.upgrade)
    BikerWeedFarm.Security.Set(BikerWeedFarm.Security.upgrade)
    BikerWeedFarm.Details.Enable(BikerWeedFarm.Details.chairs, true)
    BikerWeedFarm.Details.Enable({BikerWeedFarm.Details.production, BikerWeedFarm.Details.chairs, BikerWeedFarm.Details.drying}, true)
	BikerWeedFarm.Plant1.Clear(false)
    BikerWeedFarm.Plant2.Clear(false)
    BikerWeedFarm.Plant3.Clear(false)
    BikerWeedFarm.Plant4.Clear(false)
    BikerWeedFarm.Plant5.Clear(false)
    BikerWeedFarm.Plant6.Clear(false)
    BikerWeedFarm.Plant7.Clear(false)
    BikerWeedFarm.Plant8.Clear(false)
    BikerWeedFarm.Plant9.Clear(false)
    RefreshInterior(BikerWeedFarm.interiorId)
	stove = CreateObject("prop_cooker_03",vector3(1045.49, -3198.46, -38.15-1), true, false)
	SetEntityHeading(stove, 270.00)
	FreezeEntityPosition(stove, true)
	stove2 = CreateObject("prop_cooker_03",vector3(1038.90, -3198.66, -38.17-1), true, false)
	SetEntityHeading(stove2, 90.00)
	FreezeEntityPosition(stove2, true)
end)

RegisterNetEvent('md-drugs:client:bluntwraps', function(args)
  lib.registerContext({
    id = 'bluntroll',
    title = 'Blunt Types',
    menu = 'bluntroll',
    options = {
     {
      title = 'Roll Blunt',
      description = 'Roll A Regular Blunt',
      icon = 'check',
      serverEvent = 'md-drugs:server:rollblunt',
	},
	{
      title = 'Dip Blunt Wrap In Lean',
      description = 'Roll A Lean Blunt',
      icon = 'check',
      serverEvent = 'md-drugs:server:rollleanblunt',
	},
	{
      title = 'Dip Blunt Wrap In Dextro',
      description = 'Roll A Dextro Blunt',
      icon = 'check',
      serverEvent = 'md-drugs:server:rolldextroblunt',
	},
	{
      title = 'Roll A Chewy Blunt',
      description = 'Roll A Chewy Blunt',
      icon = 'check',
      serverEvent = 'md-drugs:server:rollchewyblunt',
	},
  },
  })
 
  lib.showContext('bluntroll')
end)

RegisterNetEvent("md-drugs:client:rollanim", function()
	TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
Wait(4000)
ClearPedTasks(PlayerPedId())
end)



RegisterNetEvent("md-drugs:client:dodabs", function()
	TriggerEvent('animations:client:EmoteCommandStart', {'uncuff'}) 
AlienEffect()
end)

RegisterNetEvent("md-drugs:client:edibles", function()
	QBCore.Functions.Progressbar("use_lsd", "Eating Edibles", 1750, false, true, {
        disableMovement = false,
        disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
    }, {
		animDict = "mp_suicide",
		anim = "pill",
		flags = 49,
    }, {}, {}, function()
AlienEffect()
ClearPedTasks(PlayerPedId())
end)
end)

CreateThread(function()
local WeedShop = {}
local current = "u_m_m_jesus_01"
lib.requestModel(current, timeout)
local CurrentLocation = vector3(1030.46, -3203.63, -38.2)
	 WeedGuy = CreatePed(0,current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, CurrentLocation.h, false, false)
             FreezeEntityPosition(WeedGuy, true)
            SetEntityInvincible(WeedGuy, true)
			SetEntityHeading(WeedGuy, 270.0)
			exports['qb-target']:AddTargetEntity(WeedGuy, { 
                options = {
                    {
                        label = "Weed Shop",
                        icon = "fas fa-eye",
						action = function()
						lib.showContext('WeedShop')
						end,
						
                    },
                }
               
				})
for k, v in pairs (Config.Weed.items) do 
	WeedShop[#WeedShop + 1] = {
		icon = "nui://"..Config.imagelink..QBCore.Shared.Items[v.name].image,
		 header = v.label,
		 title = v.label,
		 event = "md-drugs:client:WeedShop",
		 args = {
			 item = v.name,
			 cost = v.price,
			 amount = v.amount,
		 }
	 }
 
 lib.registerContext({id = 'WeedShop',title = "Weed Shop", options = WeedShop})
end

end)

RegisterNetEvent("md-drugs:client:WeedShop", function(data)
	local price = data.cost 
	local settext = "Amnt: "..data.amount.." | Cost: "..price or "Cost: "..price
	local max = data.amount  
	local dialog = exports.ox_lib:inputDialog(data.item .."!",   {
		{ type = 'select', label = "Payment Type", default = "cash",
			options = {
				{ value = "cash"},
				{ value = "bank"},
			}
		},
		{ type = 'number', label = "Amount to buy", description = settext, min = 0, max = max, default = 1 },
	})
	if data.cost == "Free" then data.cost = 0 end
		TriggerServerEvent("md-drugs:server:travellingmerchantox", dialog[2], dialog[1], data.item, data.cost )
end)

RegisterNetEvent('md-drugs:client:smokeblunts', function(itemName)
    TriggerEvent('animations:client:EmoteCommandStart', {'smoke'}) 
	TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
		Wait(1000)
			if itemName == "blunts" then
				AlienEffect()
			elseif itemName == "leanblunts" or itemName == "dextroblunts" then
				EcstasyEffect()
			else
				TrevorEffect()
			end
end)