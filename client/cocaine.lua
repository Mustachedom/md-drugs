
local cuttingcoke = nil
local baggingcoke = nil

for k, v in pairs (GlobalState.MDDrugsLocs.MakePowder) do
    ps.boxTarget('cocaplant'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
        {
            label = ps.lang('.targets.coke.pick'),
            icon = 'fa-solid fa-seedling',
            action = function()
                if not ps.hasItem('coca_leaf') then
                    ps.notify('You Need A Coke Leaf')
                    return
                end
                if not ps.progressbar(ps.lang('Coke.makepow'), 4000, 'uncuff') then return end
	            TriggerServerEvent("md-drugs:server:makepowder", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

for k, v in pairs (GlobalState.MDDrugsLocs.CuttingCoke) do
    ps.boxTarget('cutcoke'..k, v.loc, {length = 1.0, width = 1.0, height = 1.0, rotation = 180.0}, {
        {
            label = ps.lang('targets.coke.cut'),
            icon = 'fa-solid fa-mortar-pestle',
            action = function()
                CutCoke(v.loc, v.offset, v.rotation)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                if cuttingcoke ~= nil or baggingcoke ~= nil then return false end
                return true
            end,
        }
    })
end

for k, v in pairs (GlobalState.MDDrugsLocs.BaggingCoke) do
    ps.boxTarget('bagcoke'..k, v.loc, {length = 1.0, width = 1.0, height = 1.0, rotation = 180.0}, {
        {
            label = ps.lang('targets.coke.bag'),
            icon = 'fa-solid fa-sack-xmark',
            action = function()
                BagCoke(v.loc, v.offset, v.rotation)
            end,
            canInteract = function()
                if not handleGang(v.gang) then return false end
                if cuttingcoke ~= nil or baggingcoke ~= nil then return false end
                return true
            end
        }
    })
end