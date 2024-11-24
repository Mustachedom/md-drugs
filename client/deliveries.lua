local QBCore = exports['qb-core']:GetCoreObject()
local isActive = false
local dealer = {}

RegisterNetEvent('md-drugs:client:opendealermenu', function()
    local rep = GetRep()
    makeMenu('dealermenu', rep)
    lib.showContext('dealermenu')
end)

local function SpawnDealer()
    local getDealers = lib.callback.await('md-drugs:server:getDealers', false)
     for k,v in pairs(getDealers) do
		local Ped = "g_m_y_famdnf_01"
        lib.requestModel(Ped, Config.RequestModelTime)
        local loc = json.decode(v.coords)
        dealer[k] = CreatePed(0, Ped,loc.x,loc.y, loc.z-1, loc.h, false, false)
        Freeze(dealer[k], true, loc.h)
        AddMultiModel(dealer[k], {
        { icon = 'fas fa-user-secret', label = string.format(Lang.targets.Delivery.Deliver, v.name),
            action = function()
                local bool, item, amount, coords = lib.callback.await('md-drugs:server:GetDeliveryItem', false, k)
                if bool then 
                    Email(Lang.Delivery.emailn, Lang.Delivery.emailsub, string.format(Lang.Delivery.emailcon, amount, GetLabel(item)))
                    TriggerEvent('md-drugs:client:setLocation', {bool = bool, item = item, amount = amount, coords = coords})
                end
            end,
        },
        { icon = "fa-solid fa-store", label = string.format(Lang.targets.Delivery.open, v.name),
            action =   function()   TriggerEvent('md-drugs:client:opendealermenu') end,
         }}, dealer[k])
     end
end

RegisterNetEvent('md-drugs:client:RefreshDealers', function()
    SpawnDealer()
end)

CreateThread(function()
    SpawnDealer()
end)

RegisterNetEvent('md-drugs:client:setLocation', function(data)
    local coord = json.decode(data.coords)
    SetNewWaypoint(coord.x, coord.y)
    if isActive then return end
    isActive = true
    local Buyer = CreatePed(0, "g_m_y_famdnf_01",coord.x, coord.y, coord.z-1, coord.w, false, false)
    Freeze(Buyer, true, coord.w)
    AddSingleModel(Buyer,  {
        icon = 'fas fa-user-secret',
        label = Lang.targets.Delivery.hand,
        action = function()
           if not progressbar(Lang.Delivery.pack, 4000, 'uncuff') then return end
           isActive = false
           DeletePed(Buyer)
           TriggerServerEvent('md-drugs:server:giveDeliveryItems', data.item, data.amount) 
        end,
        canInteract = function()
            if isActive then
                return true
            end
        end
    }, nil)
end)
