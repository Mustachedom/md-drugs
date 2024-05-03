local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function() 
local current = "g_m_y_famdnf_01"
	lib.requestModel(current, Config.RequestModelTime)
	local CurrentLocation = Config.Travellingmerchant[math.random(#Config.Travellingmerchant)]
	local travellingmerchant = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, CurrentLocation.w, false, false)
    FreezeEntityPosition(travellingmerchant, true)
    SetEntityInvincible(travellingmerchant, true)
	if Config.oxtarget then
		local options = {
			{ label = "Travelling Merchant", icon = "fas fa-eye", onSelect = function() 	lib.showContext('travellingmerchant') end},
		}
		exports.ox_target:addLocalEntity(travellingmerchant, options)
	else
		exports['qb-target']:AddTargetEntity(travellingmerchant, { 
			options = {
				{ label = "Travelling Merchant", icon = "fas fa-eye", action = function() 	lib.showContext('travellingmerchant') end},
			}
		})
	end
end)

CreateThread(function()
	local ShopMenu = {}

	for k, v in pairs (Config.Items.items) do 
		ShopMenu[#ShopMenu + 1] = {
			   icon = "nui://"..Config.imagelink..QBCore.Shared.Items[v.name].image,
			    description = '$'.. v.price,
				title = QBCore.Shared.Items[v.name].label,
				event = "md-drugs:client:travellingmerchantox",
				args = {
					item = v.name,
					cost = v.price,
					amount = v.amount,
					table = Config.Items.items,
					num = k
				}
			}
		
		lib.registerContext({id = 'travellingmerchant',title = "Travelling Merchant", options = ShopMenu})
	end
end)


RegisterNetEvent("md-drugs:client:travellingmerchantox", function(data) local dialog
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
		TriggerServerEvent("md-drugs:server:travellingmerchantox", dialog[2], dialog[1], data.item, data.cost, data.table, data.num )
end)
