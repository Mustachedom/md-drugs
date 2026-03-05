if not Config.Drugs['cocaine'] then return end
Config.Cocaine = {
    Locations = {
         MakePowder = { -- size = vector3(x,y,z) x = length, y = width, z = height
            {loc = vector3(1086.20, -3195.30, -39.20), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        CuttingCoke = {
            {loc = vector3(1095.61, -3195.62, -39.13), size = vector3(1.0, 1.0, 2.0), offset = vec3(-1.782227, 0.445068, -0.502701), rotation = vector3(0,0,0), gang = ""},
        },
        BaggingCoke = {
            {loc = vector3(1093.16, -3195.78, -39.19), size = vector3(1.0, 1.0, 2.0), offset = vec3(4.515137, 2.542969, -0.814194), rotation = vector3(0,0,180.0), gang = ""},
        },
        cokeTele = {
            {inside = vector3(1088.81, -3187.57, -38.99), outside = vector3(198.16, -1276.92, 29.33), size = vector3(1.0, 1.0, 2.0), gang = ""},
        }
    },
    Recipes = {
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
    }
}