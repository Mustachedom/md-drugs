
local function spawn()
    local data = Bridge.Callback.Trigger('md-drugs:server:GetMerchant')
    local model = 's_m_m_trucker_01'
    requestModel(model)
    local ped = CreatePed(4, model, data.loc.x, data.loc.y, data.loc.z, data.loc.w, false, true)
    Freeze(ped, true, data.loc.w)
    Bridge.Target.AddLocalEntity(ped, {
        {
            label = Bridge.Language.Locale('merchant.targetOpen'),
            action = function()
                local options = {}
                for k, v in pairs (data.items) do
                    local itemInfo = Bridge.Inventory.GetItemInfo(k)
                    options[#options+1] = {
                        title = itemInfo.label,
                        description = '$'..v,
                        icon = itemInfo.image,
                        action = function()
                            TriggerServerEvent('md-drugs:server:purchaseGoods', k)
                        end
                    }
                end
                Bridge.Menu.Open({
                    id = 'merchant_menu',
                    title = Bridge.Language.Locale('merchant.menuTitle'),
                    options = options
                })
            end
        }
    })
end
spawn()
