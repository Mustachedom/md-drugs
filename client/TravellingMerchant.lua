
local function spawn()
    local location, menus = ps.callback('md-drugs:server:GetMerchant')
    local model = 's_m_m_trucker_01'
    ps.requestModel(model)
    local ped = CreatePed(4, model, location.x, location.y, location.z, location.w, false, true)
    Freeze(ped, true, location.w)
    ps.entityTarget(ped, {
        {
            label = ps.lang('merchant.targetOpen'),
            action = function()
                local options = {}
                for k, v in pairs (menus) do
                    options[#options+1] = {
                        title = ps.getLabel(k),
                        description = '$'..v,
                        action = function()
                            ps.triggerServerEvent('md-drugs:server:purchaseGoods', k)
                        end
                    }
                end
                ps.menu('Travelling Merchant', 'Travelling Merchant', options)
            end
        }
    })
end
spawn()
