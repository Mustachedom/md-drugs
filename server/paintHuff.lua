local paintLocs = {
    stores = {
        {loc = vector4(2675.91, 3499.18, 53.3, 334.3), gang = ""},
    }
}

local itemList = {
    red_paint = 50,
    blue_paint = 50,
    yellow_paint = 50,
    green_paint = 50,
    black_paint = 50,
    paper_bag = 2,
}

ps.registerCallback('md-drugs:server:GetPaintLocs', function(source)
    return paintLocs
end)

ps.registerCallback('md-drugs:server:GetPaintItems', function(source)
    return itemList
end)

RegisterNetEvent("md-drugs:server:purchasePaint", function(loc, item)
    local src = source
    if not ps.checkDistance(src, paintLocs.stores[loc].loc, 10) then
        ps.notify(src, ps.lang('Catches.notIn'), "error")
        return
    end
    if not itemList[item] then
        ps.notify(src, ps.lang('Catches.invalidItem'), "error")
        return
    end
    if ps.removeMoney(src, 'cash', itemList[item]) then
        ps.addItem(src, item, 1)
    else
        ps.notify(src, ps.lang('Catches.notEnoughMoney'), "error")
    end
end)

for k, v in pairs (itemList) do
    if k == "paper_bag" then goto continue end
    ps.createUseable(k, function(source, item)
        local src = source
        if ps.hasItem(src, "paper_bag", 1) then
            if ps.removeItem(src, k, 1) and ps.removeItem(src, "paper_bag", 1) then
                ps.addItem(src, "painted_"..k, 1)
                ps.notify(src, ps.lang('paintHuff.used', {k}), 'success')
            else
                ps.notify(src, ps.lang('Catches.invalidItem'), "error")
            end
        else
            ps.notify(src, ps.lang('paintHuff.noBag'), "error")
        end
        -- TODO: add usage here
    end)
    ::continue::
end