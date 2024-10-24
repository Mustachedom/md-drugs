local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function() 
local current = "g_m_y_famdnf_01"
	lib.requestModel(current, Config.RequestModelTime)
	local num = lib.callback.await('md-drugs:server:GetMerchant', false)
	local CurrentLocation = Config.Travellingmerchant[num]
	local travellingmerchant = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, CurrentLocation.w, false, false)
	Freeze(travellingmerchant, true, CurrentLocation.w)
	AddSingleModel(travellingmerchant, { label = "Travelling Merchant", icon = "fas fa-eye", 
	action = function()
		local ShopMenu = {}
			for k, v in pairs (Config.Items.items) do 
				ShopMenu[#ShopMenu + 1] = {
					    icon =  GetImage(v.name),
					    description = '$'.. v.price,
						title = GetLabel(v.name),
						event = "md-drugs:client:travellingmerchantox",
						args = {
							item = v.name,
							cost = v.price,
							amount = v.amount,
							table = Config.Items.items,
							num = k
						}
					}
					sorter(ShopMenu, 'title')
				lib.registerContext({id = 'travellingmerchant',title = "Travelling Merchant", options = ShopMenu})
			end
			
		lib.showContext('travellingmerchant') 

	end}, nil)
end)

RegisterNetEvent("md-drugs:client:travellingmerchantox", function(data)
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
	if not dialog[1] then return end
	if data.cost == "Free" then data.cost = 0 end
		TriggerServerEvent("md-drugs:server:travellingmerchantox", dialog[2], dialog[1], data.item, data.cost, data.table, data.num )
end)
