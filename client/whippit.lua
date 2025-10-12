local prop = nil
local function animation(color)
    local coords = GetEntityCoords(PlayerPedId())
    ps.requestAnim('mp_player_intdrink')
    ps.requestModel(color)
    prop = CreateObject(GetHashKey(color), coords.x, coords.y, coords.z, true, true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.087000, -0.130001, 0.138999, 63.630001, 3.299881, -21.000000, true, true, false, true, 1, true)
    TaskPlayAnim(PlayerPedId(), 'mp_player_intdrink', 'loop_bottle', 8.0, -8.0, -1, 49, 0, false, false, false)
    if ps.progressbar('Inhaling Nitrous', 5000, false) then
        ClearPedTasks(PlayerPedId())
        DetachEntity(prop, true, true)
        DeleteEntity(prop)
        prop = nil
        return true
    else
        ClearPedTasks(PlayerPedId())
        DetachEntity(prop, true, true)
        DeleteEntity(prop)
        prop = nil
        return false
    end
end
local function blur(duration)
    CreateThread(function()
        TriggerScreenblurFadeIn(1000)
        Wait(duration)
        TriggerScreenblurFadeOut(1000)
    end)
end

ps.registerCallback('md-drugs:client:useWhippit', function(color)
    if animation(color) then
        blur(30000)
        return true
    else
        return false
    end
end)

local function spawnShops()
    local locations = ps.callback('md-drugs:server:getWhippitLocations')
    for k, v in pairs(locations) do
        ps.requestModel(v.ped)
        local ped = CreatePed(5, GetHashKey(v.ped), v.loc.x, v.loc.y, v.loc.z, v.loc.w, true, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        ps.entityTarget(ped, {
            {
                label = ps.lang('Whippit.targetShop'),
                icon = 'fa-solid fa-cart-shopping',
                action = function()
                    local menu = {}
                    local items = ps.callback('md-drugs:server:getwhippitShop')
                    for item, price in pairs (items) do
                        menu[#menu + 1] = {
                            title = ps.getLabel(item),
                            icon = ps.getImage(item),
                            description = '$' .. price,
                            action = function()
                                local amount = ps.input(ps.getLabel(item), {
                                    {type = 'number', label = 'Amount', name = 'amount', min = 1, max = 100, default = 1}
                                })
                                if amount and amount[1] then
                                    TriggerServerEvent('md-drugs:server:buyWhippitItem', k, item, amount[1])
                                end
                            end
                        }
                    end
                    ps.menu(ps.lang('Whippit.shopHeader'), ps.lang('Whippit.shopHeader'), menu)
                end
            },
        })
    end
end

spawnShops()