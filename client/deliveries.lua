local QBCore = exports['qb-core']:GetCoreObject()
local isActive = false

RegisterNetEvent('md-drugs:client:opendealermenu', function()
    local rep = GetRep()
    makeMenu('dealermenu', rep)
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
                label = string.format(Lang.targets.Delivery.Deliver, v.name),
                action = function()
			      local bool, item, amount, coords = lib.callback.await('md-drugs:server:GetDeliveryItem', false, k)
                   if bool then 
                      Email(Lang.Delivery.emailn, Lang.Delivery.emailsub, string.format(Lang.Delivery.emailcon, amount, GetLabel(item)))
                      TriggerEvent('md-drugs:client:setLocation', {bool = bool, item = item, amount = amount, coords = coords})
		          end
               end,
               onSelect = function()
                   local bool, item, amount, coords = lib.callback.await('md-drugs:server:GetDeliveryItem', false, k)
                   if item then
                       TriggerEvent('md-drugs:client:setLocation', {bool = bool, item = item, amount = amount, coords = coords})
                       Email(Lang.Delivery.emailn, Lang.Delivery.emailsub, string.format(Lang.Delivery.emailcon, amount, GetLabel(item)))
		           end
               end    
            },
            {
                icon = 'fas fa-user-secret',
                label = string.format(Lang.targets.Delivery.open, v.name),
                action =   function()   TriggerEvent('md-drugs:client:opendealermenu') end,
                onSelect = function()   TriggerEvent('md-drugs:client:opendealermenu') end  
            }
        }
        AddMultiModel(dealer[k], options)
     end
end)

RegisterNetEvent('md-drugs:client:setLocation', function(data)
    local coord = json.decode(data.coords)
        local deliveryBlip = AddBlipForCoord(coord.x, coord.y, coord.z)
        SetBlipSprite(deliveryBlip, 1)
        SetBlipDisplay(deliveryBlip, 2)
        SetBlipScale(deliveryBlip, 1.0)
        SetBlipAsShortRange(deliveryBlip, false)
        SetBlipColour(deliveryBlip, 27)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Drug Delivery')
        EndTextCommandSetBlipName(deliveryBlip)
        SetBlipRoute(deliveryBlip, true)
    if isActive then return end
    isActive = true
    local Buyer = CreatePed(0, "g_m_y_famdnf_01",coord.x, coord.y, coord.z-1, 180.0, false, false)
    Freeze(Buyer, true, 180)
        AddSingleModel(Buyer,  {
            icon = 'fas fa-user-secret',
            label = Lang.targets.Delivery.hand,
            action = function()
               if not progressbar(Lang.Delivery.pack, 4000, 'uncuff') then return end
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