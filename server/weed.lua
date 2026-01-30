Locations, Recipes = Locations or {}, Recipes or {}


Locations.Weed = {
    WeedTele = { -- where you tele out of weed
        {inside = vector3(1066.31, -3183.36, -39.16), outside = vector3(244.74, 374.54, 105.74), size = vector3(1.0, 1.0, 2.0), gang = ""},
    },
    MakeButter = {
        {loc = vector4(1045.43, -3198.75, -38.15, 270.0), prop = 'prop_cooker_03', checks = {}},
    },
    MakeOil = {
        {loc = vector4(1038.8, -3198.68, -38.17, 90.0), prop = 'prop_cooker_03', checks = {}},
    },
    WeedDry = {
        {loc = vector3(1043.0, -3191.59, -38.39), size = vector3(1.0, 1.0, 2.0)},
        {loc = vector3(1041.0, -3191.59, -38.39), size = vector3(1.0, 1.0, 2.0)},
        {loc = vector3(1045.0, -3191.59, -38.39), size = vector3(1.0, 1.0, 2.0)},
        {loc = vector3(1039.0, -3191.59, -38.39), size = vector3(1.0, 1.0, 2.0)},
    },
    WeedSalesman = {
        {loc = vector4(1030.77, -3203.18, -38.2, 262.37), ped = 'a_m_m_farmer_01', gang = ""},
    },
}
Recipes.Weed = {
    blunts = {
        blunt = {take = {bluntwrap = 1, grindedweed = 1}, give = {blunt = 1}},
        chewyblunt = {take = {bluntwrap = 1, grindedweed = 1, loosecoke = 1}, give = {chewyblunt = 1}},
        leanblunts = {take = {leanbluntwrap = 1, grindedweed = 1}, give = {leanblunts = 1}},
        dextroblunts = {take = {dextrobluntwrap = 1, grindedweed = 1}, give = {dextroblunts = 1}}
    },
    bluntwrap = {
        leanbluntwrap = {take = {bluntwrap = 5, mdlean = 1}, give = {leanbluntwrap = 5}},
        dextrobluntwrap = {take = {bluntwrap = 5, mdreddextro = 1}, give = {dextrobluntwrap = 5}},
    },
    makeButter= {
        cannabutter = {
            amount = 1, 
            time = 4000,
            anim = 'uncuff',
            recipe = {
               mdbutter = 1,
               grindedweed = 1
            }
        },
        specialbrownie = {
            amount = 1,
            time = 4000,
            anim = 'uncuff',
            recipe = {
                cannabutter = 1,
                flour = 1,
                chocolate = 1
            }
        },
        specialcookie = {
            amount = 1,
            time = 4000,
            anim = 'uncuff',
            recipe = {
                cannabutter = 1,
                flour = 1
            }
        },
        specialchocolate = {
            amount = 1,
            time = 4000,
            anim = 'uncuff',
            recipe = {
                cannabutter = 1,
                chocolate = 1
            }
        },
        specialmuffin = {
            amount = 1,
            time = 4000,
            anim = 'uncuff',
            recipe = {
                cannabutter = 1,
                flour = 1
            }
        }
    },
    makeOil = {
        shatter = {
            amount = 1, 
            time = 4000,
            anim = 'uncuff',
            recipe = {
                butane = 1,
                grindedweed = 1
            }
        }
    },
    weedStore = {
        weedgrinder =25,
        mdbutter =25,
        flour =25,
        chocolate =25,
        butane =25,
        butanetorch =2,
        dabrig =2,
        mdwoods =2,
    }
}
GlobalState.MDDrugsLocations = Locations
GlobalState.MDDrugsRecipes = Recipes

RegisterNetEvent('md-drugs:server:buyWeedItem', function(loc, name, amount)
	local src = source
    if not checkDistance(src, Locations.Weed.WeedSalesman[loc].loc, 3.5, 'md-drugs:server:buyWeedItem') then
        return
    end
    if not Recipes.Weed.weedStore[name] then
        Bridge.Prints.Warn(Bridge.Language.Locale('weed.itemDoesntExistWarn', Bridge.Framework.GetPlayerIdentifier(src), name))
        return
    end

	if Bridge.Framework.RemoveAccountBalance(src, 'cash', Recipes.Weed.weedStore[name] * amount) or Bridge.Framework.RemoveAccountBalance(src, 'bank', Recipes.Weed.weedStore[name] * amount) then
		Bridge.Inventory.AddItem(src, name, amount)
	else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.notEnoughMoney'), "error")
	end
end)

RegisterServerEvent('md-drugs:server:dryoutweed', function(loc)
	local src = source
    if timeOut(src, 'md-drugs:server:dryoutweed') then return end
    if not checkDistance(src, Locations.Weed.WeedDry[loc].loc, 5.0, 'md-drugs:server:dryoutweed') then
        return
    end
	if Bridge.Inventory.RemoveItem(src,"wetcannabis", 1) then
    	Bridge.Inventory.AddItem(src,"drycannabis", 1)
    else
		Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.noDry'), "error")
	end
end)

local bluntwrap = {'mdreddextro','mdlean'}
for k, v in pairs (bluntwrap) do
	Bridge.Framework.RegisterUsableItem(v, function(source, item) TriggerClientEvent('md-drugs:client:makeBluntWrap', source) end)
end

local bluntwraps = {'leanbluntwrap', 'dextrobluntwrap', 'bluntwrap'}

for k, v in pairs (bluntwraps) do 
	Bridge.Framework.RegisterUsableItem(v, function(source, item) TriggerClientEvent('md-drugs:client:rollBlunt', source) end)
end


RegisterServerEvent('md-drugs:server:MakeWeedItems', function(tabl, item, loc)
	local src = source
    if timeOut(src, 'md-drugs:server:MakeWeedItems') then return end
    local locs = tabl == 'makeButter' and 'MakeButter' or tabl == 'makeOil' and 'MakeOil' or nil
    if not locs then
        Bridge.Prints.Warn(Bridge.Language.Locale('weed.invalidTableWarn', Bridge.Framework.GetPlayerIdentifier(src), tabl))
        return
    end
    if not checkDistance(src, Locations.Weed[locs][loc].loc, 5.0, 'md-drugs:server:MakeWeedItems') then
        return
    end
    local recipe = Recipes.Weed[tabl][item]
    if not recipe then
        Bridge.Prints.Warn(Bridge.Language.Locale('weed.recipeDoesntExistWarn', Bridge.Framework.GetPlayerIdentifier(src), item))
        return
    end
    for k, v in pairs (recipe.recipe) do
        if not Bridge.Inventory.HasItem(src, k, v) then
            Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.missingItem', Bridge.Inventory.GetItemInfo(k).label), "error")
            return
        end
    end
    for k, v in pairs (recipe.recipe) do
        if not Bridge.Inventory.RemoveItem(src, k, v) then
            Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.missingItem', Bridge.Inventory.GetItemInfo(k).label), "error")
            return
        end
    end
    Bridge.Inventory.AddItem(src, item, recipe.amount)
end)


Bridge.Framework.RegisterUsableItem("dabrig", function(source, item)
    local src = source
    if Bridge.Inventory.HasItem(src, "butanetorch") then
    	if Bridge.Inventory.RemoveItem(src, "shatter", 1) then
        	TriggerClientEvent("md-drugs:client:dodabs", src)
        end
    else
    	Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.needItem', Bridge.Inventory.GetItemInfo("butanetorch").label), 'error')
    end
end)

Bridge.Framework.RegisterUsableItem("weedgrinder", function(source, item)
    local src = source
    if not Bridge.Inventory.HasItem(src, "drycannabis") then 
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('weed.needItem', Bridge.Inventory.GetItemInfo("drycannabis").label), 'error')
        return
    end
    local check = Bridge.Callback.Trigger('md-drugs:client:uncuff', src, 'Grinding Weed')
    if not check then return end
    if Bridge.Inventory.RemoveItem(src, "drycannabis",1 ) then
    	Bridge.Inventory.AddItem(src, "grindedweed", 1)
    end
end)

Bridge.Framework.RegisterUsableItem("mdwoods", function(source, item)
	local src = source
    local check = Bridge.Callback.Trigger('md-drugs:client:uncuff', src, Bridge.Language.Locale('weed.crackBlunt'))
    if not check then return end
	if Bridge.Inventory.RemoveItem(src, "mdwoods",1 ) then
		Bridge.Inventory.AddItem(src, "bluntwrap", 5)
		Bridge.Inventory.AddItem(src, "tobacco", 5)
	end
end)
