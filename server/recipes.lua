

recipe = {
    mescaline = {
        dry = {
            dried = {take = {cactusbulb = 1}, give = {driedmescaline = 1} }
        }
    },
    lean = {
        cups = {
            cupoflean = {take = {leancup = 1, sprunk = 1, mdlean = 1}, give = {cupoflean = 1}},
            cupofdextro = {take = {leancup = 1, sprunk = 1, mdreddextro = 1}, give = {cupofdextro = 1}},
        }
    },
    meth = {
        cook = {
            heat = {take = {ephedrine = 1, acetone = 1}, give = {}}
        },
        bag = {
            bags = {take = {empty_weed_bag = 5}, give = {methbags = 5} }
        }
    },
    weed = {
        oil = {
            shatter = {take = {butane = 1, grindedweed = 1}, give = {shatter = 1}}
        },
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
    },
}

function GetRecipe(source, type, method, tier)
    return ps.craftItem(source, recipe[type][method][tier])
end

ps.registerCallback('md-drugs:server:GetRecipe', function(source, type, cat)
    if not source then return false end
    return recipe[type][cat]
end)

function craft(source, tbl, item)
    local src = source
    local need, have = 0,0
    for k, v in pairs(tbl.take) do
        if ps.hasItem(src, k, v) then
            have = have + v
        end
        need = need + v
    end
    if need == have then
        for k, v in pairs (tbl.take) do
            ps.removeItem(src, k, v)
        end
        ps.addItem(src, item , tbl.amount)
        return true
    end
    return false
end