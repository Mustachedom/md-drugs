

RegisterNetEvent("md-drugs:server:drymescaline", function(num)
    local src = source
    if not ps.checkDistance(src, GlobalState.MDDrugsLocs.DryOutMescaline[num].loc, 3.0) then
        ps.notify(src, "You are not in the right location", "error")
        return
    end
    if not GetRecipe(src, 'mescaline', 'dry', 'dried') then return end
end)

ps.createUseable("driedmescaline", function(source, item)
    local src = source
    if ps.removeItem(src, "driedmescaline", 1) then 
	    TriggerClientEvent("md-drugs:client:takemescaline", src)
        --Log(GetName(source) .. ' Consumed Mescaline', 'consume')
    end
end)