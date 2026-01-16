Recipes, locations = Recipes or {}, locations or {}

Locations.Mescaline = {
    DryOutMescaline = { -- where to dry out your mescaline
        {loc = vector3(1850.12, 2595.23, 45.67), l = 1.0, w = 1.0, rot = 0.0, gang = ""},
    },
}
GlobalState.MDDrugsLocations = Locations
Recipes.Mescaline = {
    mescaline = {
        dry = {
            dried = {take = {cactusbulb = 1}, give = {driedmescaline = 1} }
        }
    },
}
GlobalState.MDDrugsRecipes = Recipes


RegisterNetEvent("md-drugs:server:drymescaline", function(num)
    local src = source
    if timeOut(src, 'md-drugs:server:drymescaline') then return end

    if not checkDistance(src, Locations.Mescaline.DryOutMescaline[num].loc, 3.0) then
        Bridge.Prints.Warn(src, Bridge.Language.Locale('Catches.notIn'), "error")
        return
    end

    if not craft(src, Recipes.Mescaline.mescaline.dry.dried) then
        return
    end
end)

Bridge.Framework.RegisterUsableItem("driedmescaline", function(source, item)
    local src = source
    if Bridge.Inventory.RemoveItem(src, "driedmescaline", 1) then
	    TriggerClientEvent("md-drugs:client:takemescaline", src)
    end
end)