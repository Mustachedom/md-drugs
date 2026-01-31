

RegisterNetEvent("md-drugs:server:drymescaline", function(num)
    local src = source
    if timeOut(src, 'md-drugs:server:drymescaline') then return end

    if not checkDistance(src, Config.Mescaline.Locations.DryOutMescaline[num].loc, 3.0, 'md-drugs:server:drymescaline') then
        return
    end

    if not craft(src, Config.Mescaline.Recipes.dry.dried) then
        return
    end
end)

Bridge.Framework.RegisterUsableItem("driedmescaline", function(source, item)
    local src = source
    if Bridge.Inventory.RemoveItem(src, "driedmescaline", 1) then
	    TriggerClientEvent("md-drugs:client:takemescaline", src)
    end
end)