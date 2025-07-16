

RegisterNetEvent("md-drugs:server:drymescaline", function()
    local src = source
    if not checkLoc(src, 'singleSpot', 'DryOut') then return end
    if not GetRecipe(src, 'mescaline', 'dry', 'dried') then return end
end)

CUI("driedmescaline", function(source, item)
    local src = source
    if RemoveItem(src, "driedmescaline", 1) then 
	    TriggerClientEvent("md-drugs:client:takemescaline", src)
        Log(GetName(source) .. ' Consumed Mescaline', 'consume')
    end
end)
