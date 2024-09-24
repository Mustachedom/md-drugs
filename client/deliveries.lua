local QBCore = exports['qb-core']:GetCoreObject()
local isActive = false
RegisterNetEvent('md-drugs:client:opendealermenu', function()
    local dealermenu = {}
    if Config.StupidassNewQbItemName then
        for k, v in pairs (QBConfig.ProductsStupidNameRewrite) do 
			if  QBCore.Functions.GetPlayerData().metadata["dealerrep"] >= v.minrep then 
            dealermenu[#dealermenu + 1] = {
                          icon =  GetImage(v.name),
                          title = GetLabel(v.name),
                          description = v.price,
                          event = "md-drugs:client:travellingmerchantox",
                          args = {
                              item = v.name,
                              cost = v.price,
                             amount = v.amount,
                             table = QBConfig.ProductsStupidNameRewrite,
                             num = k,
                            }
                        }
               
                   lib.registerContext({id = 'dealermenu',title = "Dealer Menu", options = dealermenu})
			end	   
        end           
    else
         for k, v in pairs (QBConfig.Products) do 
			if  QBCore.Functions.GetPlayerData().metadata["dealerrep"] >= v.minrep then 
            dealermenu[#dealermenu + 1] = {
                          icon =  GetImage(v.name),
                          title = GetLabel(v.name),
                          description = v.price,
                          event = "md-drugs:client:travellingmerchantox",
                          args = {
                              item = v.name,
                              cost = v.price,
                             amount = v.amount,
                             table = QBConfig.Products,
                             num = k,
                            }
                        }

                   lib.registerContext({id = 'dealermenu',title = "Dealer Menu", options = dealermenu})
			end	   
        end     
    end
    lib.showContext('dealermenu')
end)

CreateThread(function()
    local dealer = {}
    local getDealers = lib.callback.await('md-drugs:server:getDealers', false)
     for k,v in pairs(getDealers) do
		local Ped = "g_m_y_famdnf_01"
        lib.requestModel(Ped, Config.RequestModelTime)
        local loc = json.decode(v.coords)
        dealer[k] = CreatePed(0, Ped,loc.x,loc.y, loc.z-1, loc.h, false, false)
        Freeze(dealer[k], true, loc.h)
        local options = {
            {
                icon = 'fas fa-user-secret',
                label = "Deliver For " .. v.name,
                action = function()
			      local bool, item, amount, coords = lib.callback.await('md-drugs:server:GetDeliveryItem', false, k)
                   if bool then 
                      Email('Not A Drug Dealer', 'Hurry Up And Get The Package To The Buyer', 'I Swear To God If It Doesnt Get There I Will Tell Your Mom You Said Fuck Just Bring ' .. amount .. ' Of '.. GetLabel(item) .. '!' )
                      TriggerEvent('md-drugs:client:setLocation', {bool = bool, item = item, amount = amount, coords = coords})
		          end
               end,
               onSelect = function()
                   local bool, item, amount, coords = lib.callback.await('md-drugs:server:GetDeliveryItem', false, k)
                   if item then
                       TriggerEvent('md-drugs:client:setLocation', {bool = bool, item = item, amount = amount, coords = coords})
                       Email('Not A Drug Dealer', 'Hurry Up And Get The Package To The Buyer', 'I Swear To God If It Doesnt Get There I Will Tell Your Mom You Said Fuck Just Bring ' .. amount .. ' Of '.. GetLabel(item) .. '!' )
		           end
               end    
            },
            {
                icon = 'fas fa-user-secret',
                label = "Open " .. v.name .. "'s Shop",
                action = function()
                   TriggerEvent('md-drugs:client:opendealermenu')
                end,
                onSelect = function()
                   TriggerEvent('md-drugs:client:opendealermenu')
               end  
                
            }
        }
        AddMultiModel(dealer[k], options)
     end
end)

RegisterNetEvent('md-drugs:client:setLocation', function(data)
    local coord = json.decode(data.coords)
    if isActive then
        Blip(vector3(coord.x, coord.y, coord.z), 'Drop Off')
        return
    end
    isActive = true
    Blip(vector3(coord.x, coord.y, coord.z), 'Drop Off')
    Buyer = CreatePed(0, "g_m_y_famdnf_01",coord.x, coord.y, coord.z-1, 180.0, false, false)
    Freeze(Buyer, true, 180)
        AddSingleModel(Buyer,  {
            icon = 'fas fa-user-secret',
            label = "Hand Off",
            action = function()
               if not progressbar('Delivering The Package', 4000, 'uncuff') then return end
               isActive = false
               DeletePed(Buyer)
               RemoveBlip(deliveryBlip)
               TriggerServerEvent('md-drugs:server:giveDeliveryItems', data.item, data.amount) 
            end,
            canInteract = function()
                if isActive then
                    return true
                end
            end
        }, nil)
end)