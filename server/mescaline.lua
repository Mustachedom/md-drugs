local mescalineLocation = {
    DryOutMescaline = { -- where to dry out your mescaline
        {loc = vector3(1850.12, 2595.23, 45.67), l = 1.0, w = 1.0, rot = 0.0, gang = ""},
    },
}
local mescalineRecipes = {
    mescaline = {
        dry = {
            dried = {take = {cactusbulb = 1}, give = {driedmescaline = 1} }
        }
    },
}

ps.registerCallback('md-drugs:server:GetMescalineLocs', function(source)
    return mescalineLocation
end)

RegisterNetEvent("md-drugs:server:drymescaline", function(num)
    local src = source
    if timeOut(src, 'md-drugs:server:drymescaline') then return end
    if not ps.checkDistance(src, mescalineLocation.DryOutMescaline[num].loc, 3.0) then
        ps.notify(src, ps.lang('Catches.notIn'), "error")
        return
    end
    if not ps.craftItem(src, mescalineRecipes.mescaline.dry.dried) then
        verifyHas(src, mescalineRecipes.mescaline.dry.dried.take)
        return
    end
end)

ps.createUseable("driedmescaline", function(source, item)
    local src = source
    if ps.removeItem(src, "driedmescaline", 1) then
	    TriggerClientEvent("md-drugs:client:takemescaline", src)
    end
end)