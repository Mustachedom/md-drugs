local QBCore = exports['qb-core']:GetCoreObject()

local recipe = {
    cocaine = {
       cokepowder = {
            tier1 = {take = {coca_leaf = 1}, give = {coke = 1}},
            tier2 = {take = {coca_leaf = 1}, give = {cokestagetwo = 1}},
            tier3 = {take = {coca_leaf = 1}, give = {cokestagethree = 1}},
       },
       cutcoke = {
            tier1 = {take = {coke = 1,           bakingsoda = 1}, give = {loosecoke = 1}},
            tier2 = {take = {cokestagetwo = 1,   bakingsoda = 1}, give = {loosecokestagetwo = 1}},
            tier3 = {take = {cokestagethree = 1, bakingsoda = 1}, give = {loosecokestagethree = 1}},
       },
       bagcoke = {
            tier1 = {take = {loosecoke = 1,             empty_weed_bag = 1}, give = {cokebaggy = 1}},
            tier2 = {take = {loosecokestagetwo = 1,     empty_weed_bag = 1}, give = {cokebaggystagetwo = 1}},
            tier3 = {take = {loosecokestagethree = 1,   empty_weed_bag = 1}, give = {cokebaggystagethree = 1}},
       }
    },
    crack = {
        cookcrack = {
             tier1 = {take = {loosecoke = 1,          bakingsoda = 1}, give = {crackrock = 1}},
             tier2 = {take = {loosecokestagetwo = 1,  bakingsoda = 1}, give = {crackrockstagetwo = 1}},
             tier3 = {take = {loosecokestagethree = 1,bakingsoda = 1}, give = {crackrockstagethree = 1}},
        },
        bagcrack = {
             tier1 = {take = {crackrock = 1,           empty_weed_bag = 1}, give = {baggedcracked = 1}},
             tier2 = {take = {crackrockstagetwo = 1,   empty_weed_bag = 1}, give = {baggedcrackedstagetwo = 1}},
             tier3 = {take = {crackrockstagethree = 1, empty_weed_bag = 1}, give = {baggedcrackedstagethree = 1}},
        }
     },
     heroin = {
        dryheroin = {
            tier1 = {take = {poppyresin = 1}, give = {heroin = 1}},
            tier2 = {take = {poppyresin = 1}, give = {heroinstagetwo = 1}},
            tier3 = {take = {poppyresin = 1}, give = {heroinstagethree = 1}},
        },
        cutheroin = {
            tier1 = {take = {heroin = 1,            bakingsoda = 1}, give = {heroincut = 1}},
            tier2 = {take = {heroinstagetwo = 1,    bakingsoda = 1}, give = {heroincutstagetwo = 1}},
            tier3 = {take = {heroinstagethree = 1,  bakingsoda = 1}, give = {heroincutstagethree = 1}},
        },
        fillvial = {
            tier1 = {take = {heroincut = 1,            emptyvial = 1}, give = {heroinvial = 1}},
            tier2 = {take = {heroincutstagetwo = 1,    emptyvial = 1}, give = {heroinvialstagetwo = 1}},
            tier3 = {take = {heroincutstagethree = 1,  emptyvial = 1}, give = {heroinvialstagethree = 1}},
        },
        fillneedle = {
            tier1 = {take = {heroinvial = 1,            needle = 1}, give = {heroin_ready = 1}},
            tier2 = {take = {heroin_readystagetwo = 1,  needle = 1}, give = {heroin_readystagetwo = 1}},
            tier3 = {take = {heroinvialstagethree = 1,  needle = 1}, give = {heroin_readystagethree = 1}},
        }
     },
     lsd = {
        vial = {
            heat = {take = {lysergic_acid = 1, diethylamide = 1,}, give = {lsd_vial_one = 1}}
        },
        
     },
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
        edibles = {
            cannabutter =       {take = {   mdbutter = 1,       grindedweed = 1},           give = {cannabutter = 1}},
            specialbrownie =     {take = {   cannabutter = 1, 	flour = 1, 	chocolate = 1}, give = {specialbrownie = 1}},
            specialcookie =     { take = {  cannabutter = 1, 	flour = 1},                 give = {specialcookie = 1}},
            specialchocolate =  { take = { 	cannabutter = 1, 	chocolate = 1},             give = {specialchocolate = 1}},
            specialmuffin =     { take = { 	cannabutter = 1, 	flour = 1},                 give = {specialmuffin = 1}},
        },
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
    xtc = {
        raw = {
            raw_xtc = {take = {mdp2p = 1, isosafrole = 1}, give = {raw_xtc = 1}}
        },
        singlestack = {
            white =  {take = {raw_xtc = 1}, give = {white_xtc = 1}},
            red =    {take = {raw_xtc = 1, loosecoke = 1 }, give = {red_xtc = 1}},
            orange = {take = {raw_xtc = 1, heroinvial = 1}, give = {orange_xtc = 1}},
            blue =   {take = {raw_xtc = 1, crackrock = 1 }, give = {blue_xtc = 1}},
        },
        dualstack = {
            white = {take = {raw_xtc = 1}, give = {white_xtc2 = 1}},
            red = {take = {raw_xtc = 1, loosecoke = 1}, give = {red_xtc2 = 1}},
            orange = {take = {raw_xtc = 1, heroinvial = 1}, give = {orange_xtc2 = 1}},
            blue = {take = {raw_xtc = 1, crackrock = 1}, give = {blue_xtc2 = 1}},
        },
        triplestack = {
            white = {take = {raw_xtc = 1}, give = {white_xtc3 = 1}},
            red = {take = {raw_xtc = 1, loosecoke = 1}, give = {red_xtc3 = 1}},
            orange = {take = {raw_xtc = 1, heroinvial = 1}, give = {orange_xtc3 = 1}},
            blue = {take = {raw_xtc = 1, crackrock = 1}, give = {blue_xtc3 = 1}},
        },
        quadstack = {
            white = {take = {raw_xtc = 1}, give = {white_xtc4 = 1}},
            red = {take = {raw_xtc = 1, loosecoke = 1}, give = {red_xtc4 = 1}},
            orange = {take = {raw_xtc = 1, heroinvial = 1}, give = {orange_xtc4 = 1}},
            blue = {take = {raw_xtc = 1, crackrock = 1}, give = {blue_xtc4 = 1}},
        },
        press = {
            dual = {take = {white_xtc = 20, blue_xtc = 20, red_xtc = 20, orange_xtc = 20, singlepress = 1}, give = {dualpress = 1}},
            triple = {take = {white_xtc2 = 50, blue_xtc2 = 50, red_xtc2 = 50, orange_xtc2 = 50, dualpress = 1}, give = {triplepres = 1}},
            quad = { take = {white_xtc3 = 50, blue_xtc3 = 50, red_xtc3 = 50, orange_xtc3 = 50, triplepress = 1}, give = {quadpress = 1}}
        }
    }
}

function GetRecipe(source, type, method, tier)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source) 
    local has = 0
    local need = 0 
        for k, v in pairs (recipe[type][method][tier].take) do 
            local item = Player.Functions.GetItemByName(k) 
            if item and item.amount >= v then 
                has = has + 1
            else
                Notifys(src, ' You Need ' .. v .. ' Of '  .. GetLabels(k) .. ' To Do This', 'error')
            end
            need = need + 1
        end
        if has == need then 
            for k, v in pairs (recipe[type][method][tier].take) do
                RemoveItem(src, k, v) 
            end
            for k,v in pairs (recipe[type][method][tier].give) do
                AddItem(src, k, v) 
            end
    
            return true
        else
            return false
        end
    end 
    
lib.callback.register('md-drugs:server:GetRecipe', function(source, type, cat)
if not source then return false end
return recipe[type][cat]
end)