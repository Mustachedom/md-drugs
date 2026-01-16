local isActive = false
local dealer = {}
--TODO: Finish Dealers 
local function SpawnDealer()
    if #dealer >= 1 then
        for k,v in pairs (dealer) do
            DeletePed(v)
        end
        dealer = {}
    end
    for k,v in pairs(GlobalState.MDDrugsLocations.Dealers) do
		local Ped = "g_m_y_famdnf_01"
        requestModel(Ped, 30000)
        local loc = json.decode(v.coords)
        dealer[k] = CreatePed(0, Ped,loc.x,loc.y, loc.z-1, loc.h, false, false)
        Freeze(dealer[k], true, loc.h)
        Bridge.Target.AddLocalEntity(dealer[k], {
            {
                icon = 'fas fa-user-secret',
                label = Bridge.Language.Locale('Deliveries.targetGetDel'),
                action = function()
                    local data = Bridge.Callback.Trigger('md-drugs:server:GetDeliveryItem', k)
                    if type(data) == 'table' and data.coords then
                        TriggerEvent('md-drugs:client:setLocation', data)
                    end
                end,
            },
            {
                icon = "fa-solid fa-store",
                label = Bridge.Language.Locale('Deliveries.targetOpenShop'),
                action = function()
                    local rep = GetRep()
                    local items = Bridge.Callback.Trigger('md-drugs:server:dealerList', k)
                    local options = {}
                    for m, d in pairs (items) do
                        if rep.dealerrep >= d.minrep then
                            options[#options+1] = {
                                title = Bridge.Inventory.GetItemInfo(d.name).label,
                                description = '$' .. d.price,
                                icon = Bridge.Inventory.GetItemInfo(d.name).image,
                                onSelect = function()
                                    TriggerServerEvent('md-drugs:server:buyItemDealer', m, k)
                                end,
                            }
                        end
                    end
                    Bridge.Menu.Open({
                        id = 'DealerMenu',
                        title = Bridge.Language.Locale('Deliveries.shopHeader'),
                        description = Bridge.Language.Locale('Deliveries.shopHeader'),
                        options = options
                    })
                end,
            }
        })
    end
end

RegisterNetEvent('md-drugs:client:RefreshDealers', function()
    SpawnDealer()
end)

SpawnDealer()

RegisterNetEvent('md-drugs:client:setLocation', function(data)
    local coord = json.decode(data.coords)
    SetNewWaypoint(coord.x, coord.y)
    if isActive then return end
    isActive = true
    local Buyer = CreatePed(0, "g_m_y_famdnf_01",coord.x, coord.y, coord.z-1, coord.w, false, false)
    Freeze(Buyer, true, coord.w)
    Bridge.Target.AddLocalEntity(Buyer,  {
        {
            icon = 'fas fa-user-secret',
            label = Bridge.Language.Locale('Deliveries.targetHandOff'),
            action = function()
               if not progressbar(Bridge.Language.Locale('Deliveries.delivering'), 4000, 'uncuff') then return end
               isActive = false
               DeletePed(Buyer)
               TriggerServerEvent('md-drugs:server:giveDeliveryItems', data.item, data.amount)
            end,
            canInteract = function()
                if isActive then
                    return true
                end
            end
        }
    })
end)
