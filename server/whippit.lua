
local itemCraft = {
    cracker = {
        'blue_uninflated_balloon',
        'green_uninflated_balloon',
        'orange_uninflated_balloon',
        'purple_uninflated_balloon',
        'red_uninflated_balloon',
        'white_uninflated_balloon',
        'yellow_uninflated_balloon'
    }
}

ps.createUseable('cracker', function(source)
    local src = source
    if not itemCraft['cracker'] then return end
    if not ps.hasItem(src, 'cracker') then return end
    if not ps.hasItem(src, 'whipped_cream_cannister') then return end
    local hasBalloon = nil
    for _, balloon in pairs(itemCraft['cracker'].optionalColors) do
        if ps.getItemCount(src, balloon) >= 1 then
            hasBalloon = balloon
            break
        end
    end
    if not hasBalloon then
        return ps.notify(src, 'You do not have a balloon to use the cracker on', 'error')
    end

    if not ps.removeItem(src, 'whipped_cream_cannister', 1) then
        return ps.notify(src, 'Failed to remove whipped cream canister', 'error')
    end
    if not ps.removeItem(src, hasBalloon, 1) then
        return ps.notify(src, 'Failed to remove balloon', 'error')
    end
    --TODO: Add animation callback
end)