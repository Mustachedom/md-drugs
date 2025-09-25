local isActive = false
local dealer = {}

local function SpawnDealer()
    local getDealers = ps.callback('md-drugs:server:getDealers')
    for k,v in pairs(getDealers) do
		local Ped = "g_m_y_famdnf_01"
        ps.requestModel(Ped, 30000)
        local loc = json.decode(v.coords)
        dealer[k] = CreatePed(0, Ped,loc.x,loc.y, loc.z-1, loc.h, false, false)
        Freeze(dealer[k], true, loc.h)
        ps.entityTarget(dealer[k], {
            {
                icon = 'fas fa-user-secret',
                label = ps.lang('Deliveries.targetGetDel'),
                action = function()
                    local data = ps.callback('md-drugs:server:GetDeliveryItem', k)
                    if type(data) == 'table' and data.coords then
                        TriggerEvent('md-drugs:client:setLocation', data)
                    end
                end,
            },
            {
                icon = "fa-solid fa-store",
                label = ps.lang('Deliveries.targetOpenShop'),
                action = function()
                    local rep = GetRep()
                    local items = ps.callback('md-drugs:server:dealerList')
                    local options = {}
                    for m, d in pairs (items) do
                        if rep.dealerrep >= d.minrep then
                            options[#options+1] = {
                                title = ps.getLabel(d.name),
                                description = '$' .. d.price,
                                icon = ps.getImage(d.name),
                                action = function()
                                    TriggerServerEvent('md-drugs:server:buyItemDealer', m)
                                end,
                            }
                        end
                    end
                    ps.menu(ps.lang('Deliveries.shopHeader'), ps.lang('Deliveries.shopHeader'), options)
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
    ps.entityTarget(Buyer,  {
        {
            icon = 'fas fa-user-secret',
            label = ps.lang('Deliveries.targetHandOff'),
            action = function()
               if not ps.progressbar(ps.lang('Deliveries.delivering'), 4000, 'uncuff') then return end
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
