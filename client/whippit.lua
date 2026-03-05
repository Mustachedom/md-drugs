if not Config.Drugs['whippit'] then return end
local prop = nil

local function animation(color)
    local coords = GetEntityCoords(PlayerPedId())
    Bridge.Anim.RequestDict('mp_player_intdrink')
    requestModel(color)
    prop = CreateObject(GetHashKey(color), coords.x, coords.y, coords.z, true, true, true)
    AttachEntityToEntity(prop, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905), 0.087000, -0.130001, 0.138999, 63.630001, 3.299881, -21.000000, true, true, false, true, 1, true)
    TaskPlayAnim(PlayerPedId(), 'mp_player_intdrink', 'loop_bottle', 8.0, -8.0, -1, 49, 0, false, false, false)
    if progressbar('Inhaling Nitrous', 5000, false) then
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

Bridge.Callback.Register('md-drugs:client:useWhippit', function(color)
    if animation(color) then
        blur(30000)
        return true
    else
        return false
    end
end)

local function spawnShops()

    for k, v in pairs(Config.Whippit.Locations.Whippit) do
        requestModel(v.ped)
        local ped = CreatePed(5, GetHashKey(v.ped), v.loc.x, v.loc.y, v.loc.z, v.loc.w, true, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        Bridge.Target.AddLocalEntity(ped, {
           {
               label = Bridge.Language.Locale('Whippit.targetShop'),
               icon = Bridge.Language.Locale('Whippit.whippitIcon'),
               action = function()
                   local menu = {}
                   for item, price in pairs (Config.Whippit.Recipes.shop) do
                    local itemInfo = Bridge.Inventory.GetItemInfo(item)
                       menu[#menu + 1] = {
                           title = itemInfo.label,
                           icon = itemInfo.image,
                           description = '$' .. price,
                           onSelect = function()
                               local amount = Bridge.Input.Open(itemInfo.label, {
                                   {type = 'number', label = 'Amount', name = 'amount', min = 1, max = 100, default = 1}
                               })
                               if amount and amount[1] then
                                   TriggerServerEvent('md-drugs:server:buyWhippitItem', k, item, amount[1])
                               end
                           end
                       }
                   end
                   Bridge.Menu.Open({
                       id = 'whippitShop',
                       title = Bridge.Language.Locale('Whippit.shopHeader'),
                       options = menu
                   })
               end
           },
        })
        targets[#targets+1] = ped
    end
end

spawnShops()