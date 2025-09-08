local weedLocs = {
    WeedTele = { -- where you tele out of weed
        {inside = vector3(1066.31, -3183.36, -39.16), outside = vector3(244.74, 374.54, 105.74), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    MakeButter = {
        {loc = vector3(1045.48, -3198.49, -38.22), checks = {}},
    },
    MakeOil = {
        {loc = vector3(1038.90, -3198.66, -38.17), checks = {}},
    },
    WeedDry = {
        {loc = vector3(1043.0, -3191.59, -38.39),},
        {loc = vector3(1041.0, -3191.59, -38.39),},
        {loc = vector3(1045.0, -3191.59, -38.39),},
        {loc = vector3(1039.0, -3191.59, -38.39),},
    },
    WeedSalesman = {
        {loc = vector4(1030.77, -3203.18, -38.2, 262.37), ped = 'a_m_m_farmer_01', gang = ""},
    },
}

local weedStore = {
	weedgrinder =25,
	mdbutter =25,
	flour =25,
	chocolate =25,
	butane =25,
	butanetorch =2,
	dabrig =2,
	mdwoods =2,
}

local weed = {
    blunts = {
        blunt = {take = {bluntwrap = 1, grindedweed = 1}, give = {blunt = 1}},
        chewyblunt = {take = {bluntwrap = 1, grindedweed = 1, loosecoke = 1}, give = {chewyblunt = 1}},
        leanblunts = {take = {leanbluntwrap = 1, grindedweed = 1}, give = {leanblunts = 1}},
        dextroblunts = {take = {dextrobluntwrap = 1, grindedweed = 1}, give = {dextroblunts = 1}}
    },
    bluntwrap = {
        leanbluntwrap = {take = {bluntwrap = 5, mdlean = 1}, give = {leanbluntwrap = 5}},
        dextrobluntwrap = {take = {bluntwrap = 5, mdreddextro = 1}, give = {dextrobluntwrap = 5}},
    }
}

ps.registerCallback('md-drugs:server:GetWeedRecipe', function(source, tableName)
    if not source then return false end
    return weed[tableName]
end)

ps.registerCallback('md-drugs:server:GetWeedLocs', function(source)
    return weedLocs
end)

ps.registerCallback('md-drugs:server:getWeedItems', function(source)
    return weedStore
end)

RegisterNetEvent('md-drugs:server:buyWeedItem', function(loc, name, amount)
	local src = source
    if not ps.checkDistance(src, weedLocs.WeedSalesman[loc].loc, 3.5) then
        ps.notify(src, ps.lang('Checks.notIn'), "error")
        return
    end
    if not weedStore[name] then
        ps.notify(src, ps.lang('weed.itemDoesntExist'), "error")
        return
    end
	if ps.removeMoney(src, 'cash', weedStore[name] * amount) or ps.removeMoney(src, 'bank', weedStore[name] * amount) then
		ps.addItem(src, name, amount)
	else
		ps.notify(src, ps.lang('Catches.notEnoughMoney'), "error")
	end
end)

RegisterServerEvent('md-drugs:server:dryoutweed', function()
	local src = source
    if timeOut(src, 'md-drugs:server:dryoutweed') then return end
	if ps.removeItem(src,"wetcannabis", 1) then
    	ps.addItem(src,"drycannabis", 1)
    else
		ps.notify(src, ps.lang('weed.noDry'), "error")
	end
end)

local bluntwrap = {'mdreddextro','mdlean'}
for k, v in pairs (bluntwrap) do
	ps.createUseable(v, function(source, item) TriggerClientEvent('md-drugs:client:makeBluntWrap', source) end)
end

local bluntwraps = {'leanbluntwrap', 'dextrobluntwrap', 'bluntwrap'}

for k, v in pairs (bluntwraps) do 
	ps.createUseable(v, function(source, item) TriggerClientEvent('md-drugs:client:rollBlunt', source) end)
end


RegisterServerEvent('md-drugs:server:MakeWeedItems', function(data)
	local src = source
    if timeOut(src, 'md-drugs:server:MakeWeedItems') then return end
	if not ps.craftItem(src, weed[data.table][data.item]) then
        verifyHas(src, weed[data.table][data.item].take)
		return
	end
end)


ps.createUseable("dabrig", function(source, item)
    local src = source
    if ps.hasItem(src, "butanetorch") then
    	if ps.removeItem(src, "shatter", 1) then
        	TriggerClientEvent("md-drugs:client:dodabs", src)
        end
    else
    	ps.notify(src, ps.lang('weed.needItem', ps.getItemLabel("butanetorch")), 'error')
    end
end)

ps.createUseable("weedgrinder", function(source, item)
    local src = source
    if not ps.hasItem(src, "drycannabis") then ps.notify(src, ps.lang('weed.needItem', ps.getItemLabel("drycannabis")), 'error') return end
    local check = ps.callback('md-drugs:client:uncuff', src, 'Grinding Weed')
    if not check then return end
    if ps.removeItem(src, "drycannabis",1 ) then
    	ps.addItem(src, "grindedweed", 1)
    end
end)

ps.createUseable("mdwoods", function(source, item)
	local src = source
    local check = ps.callback('md-drugs:client:uncuff', src, ps.lang('weed.crackBlunt'))
    if not check then return end
	if ps.removeItem(src, "mdwoods",1 ) then
		ps.addItem(src, "bluntwrap", 5)
		ps.addItem(src, "tobacco", 5)
	end
end)


exports['ps_lib']:registerCrafter({
    loc = weedLocs.MakeButter,
    recipes = {
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

    }
})

exports['ps_lib']:registerCrafter({
    loc = weedLocs.MakeOil,
    recipes = {
        shatter = {
            amount = 1, 
            time = 4000,
            anim = 'uncuff',
            recipe = {
                butane = 1,
                grindedweed = 1
            }
        }
    }
})


