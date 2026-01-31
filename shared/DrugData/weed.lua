if not Config.Drugs['weed'] then return end
Config.Weed = {
    Locations = {
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
    },
    Recipes = {
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
}