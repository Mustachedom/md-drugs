Config.Heroin = {
    Recipes = {
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
            tier2 = {take = {heroinvialstagetwo = 1,    needle = 1}, give = {heroin_readystagetwo = 1}},
            tier3 = {take = {heroinvialstagethree = 1,  needle = 1}, give = {heroin_readystagethree = 1}},
        }
    },
    Locations = {
        dryplant = {  -- turn resin into powder
            {loc = vector3(-1353.77, -335.58, 43.92), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        cutheroinone = {  -- cut heroin stage 1-3 with baking soda
            {loc = vector3(-1360.14, -337.03, 43.92), size = vector3(1.0, 1.0, 2.0), gang = ""},
        }, 
        fillneedle = { -- fill needles with heroin
            {loc = vector3(-1366.32, -334.40, 44.44), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
	    buyKit = {
	    	{ped = 'a_m_m_farmer_01',loc = vector4(-1366.32, -334.40, 44.44,180.0), size = vector3(1.0, 1.0, 2.0), gang = ""},
	    }
    },
    prices = {
	    heroinlabkitprice = 10000
    }
}