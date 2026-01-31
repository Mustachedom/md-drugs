
local dealer = {}
local buyer = nil

repeat Wait(100) until GlobalState.MDDrugDealers ~= nil

local function SpawnDealer()
    if #dealer >= 1 then
        for k,v in pairs (dealer) do
            DeletePed(v)
        end
        dealer = {}
    end
    for k,v in pairs(GlobalState.MDDrugDealers) do
        requestModel(v.model)
        dealer[k] = CreatePed(0, v.model, v.coords.x, v.coords.y, v.coords.z-1, v.coords.w, false, false)
        Freeze(dealer[k], true, v.coords.w)
        Bridge.Target.AddLocalEntity(dealer[k], {
            {
                icon = Bridge.Language.Locale('Deliveries.targetGetDelIcon'),
                label = Bridge.Language.Locale('Deliveries.targetGetDel'),
                action = function()
                    TriggerServerEvent('md-drugs:server:requestDelivery', k)
                end,
            },
            {
                icon = Bridge.Language.Locale('Deliveries.targetOpenShopIcon'),
                label = Bridge.Language.Locale('Deliveries.targetOpenShop'),
                action = function()
                    local rep = GetRep()
                    local options = {}
                    for m, d in pairs (Config.Deliveries.Recipes) do
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

SpawnDealer()

RegisterNetEvent('md-drugs:client:RefreshDealers', function()
    SpawnDealer()
end)

RegisterNetEvent('md-drugs:client:setLocation', function(data)
    if buyer then
        DeletePed(buyer)
    end
    local coord = data.coords
    SetNewWaypoint(coord.x, coord.y)
    requestModel("g_m_y_famdnf_01") 
    buyer = CreatePed(0, "g_m_y_famdnf_01",coord.x, coord.y, coord.z-1, coord.w, false, false)
    Freeze(buyer, true, coord.w)
    Bridge.Target.AddLocalEntity(buyer  ,  {
        {
            icon = Bridge.Language.Locale('Deliveries.targetHandOffIcon'),
            label = Bridge.Language.Locale('Deliveries.targetHandOff'),
            action = function()
               if not progressbar(Bridge.Language.Locale('Deliveries.delivering')) then return end
               TriggerServerEvent('md-drugs:server:giveDeliveryItems')
               Wait(400)
                DeletePed(buyer)
            end,
        }
    })
end)