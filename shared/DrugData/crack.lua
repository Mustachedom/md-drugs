Config.Crack = {
    Recipes = {
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
    Locations = {
        makecrack = { -- make crack with baking soda with cut coke 1-3
            {loc = vector3(2433.47, 4970.02, 42.18),  size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        bagcrack = {  ---  bag crack 1-3 stages
            {loc = vector3(2436.55, 4964.96, 42.18), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
    }
}