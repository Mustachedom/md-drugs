
local function spawn()
    local data = ps.callback('md-drugs:server:GetMerchant')
    local model = 's_m_m_trucker_01'
    ps.requestModel(model)
    local ped = CreatePed(4, model, data.loc.x, data.loc.y, data.loc.z, data.loc.w, false, true)
    Freeze(ped, true, data.loc.w)
    ps.entityTarget(ped, {
        {
            label = ps.lang('merchant.targetOpen'),
            action = function()
                local options = {}
                for k, v in pairs (data.items) do
                    options[#options+1] = {
                        title = ps.getLabel(k),
                        description = '$'..v,
                        icon = ps.getImage(k),
                        action = function()
                            TriggerServerEvent('md-drugs:server:purchaseGoods', k)
                        end
                    }
                end
                ps.menu('Travelling Merchant', 'Travelling Merchant', options)
            end
        }
    })
end
spawn()
