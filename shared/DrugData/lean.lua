Config.Lean = {
    Locations = {
        SyrupVendor = {
            {ped = 'a_m_m_farmer_01', loc = vector4(365.21, -578.77, 39.30, 347.23), gang = ""},
        },
        startLoc = { -- where truck spawns for lean and meth missions
            vector3(-2307.22, 434.77, 174.47),
            vector3(614.75, 1786.26, 199.39),
            vector3(-224.89, 6388.32, 31.59)
        },
    },
    Recipes = {
        {
            item = 'cupoflean',
            amount = 1,
            ingredients = {
                {item = 'leancup', amount = 1},
                {item = 'mdlean', amount = 1},
                {item = 'sprunk', amount = 1},
            }
        },
        {
            item = 'cupofdextro',
            amount = 1,
            ingredients = {
                {item = 'leancup', amount = 1},
                {item = 'mdreddextro', amount = 1},
                {item = 'sprunk', amount = 1},
            }
        }
    }
}