Config.Meth = {
    Locations = {
        CookMeth = {
            {loc = vector3(1006.09, -3200.59, -38.52), size = vector3(1.0, 1.0, 2.0), offset = vec3(4.79, 2.13, -0.41), rotation = vector3(0,0,0.0), gang = ""},
        },
        MethDials = {
            {loc = vector3(1007.89, -3201.17, -38.99), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        MethSmash = {
            {loc = vector3(1012.04, -3194.96, -38.99), bucket = vector4(1012.86, -3194.13, -39.20, 90.00), size = vector3(1.0, 1.0, 2.0), offset = vec3(-3.143311, -1.666748, -1.010128), rotation = vector3(0,0,0.0), gang = ""},
        },
        BagMeth = {
            {loc = vector3(1014.25, -3194.93, -38.99), size = vector3(1.0, 1.0, 2.0), offset = vec3(-4.9, -1.70, -1.01), rotation = vector3(0,0,0.0), gang = ""},
        },
        MethEph = { -- get ephedrine
            {loc = vector3(3559.86, 3673.9, 28.13), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        MethAce = { -- get acetone
            {loc = vector3(3535.41, 3661.05, 28.12), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        MethHeist = {
            {loc = vector4(-1520.84, 827.72, 181.66, 184.13), ped = 'a_m_m_farmer_01', gang = ""},
        },
        StartLoc = { -- where truck spawns for lean and meth missions
            vector3(-2307.22, 434.77, 174.47),
            vector3(614.75, 1786.26, 199.39),
            vector3(-224.89, 6388.32, 31.59)
        },
	    MethTele = {
	    	{inside = vector3(996.91, -3200.83, -36.39), outside = vector3(-2222.04, 303.99, 174.6), size = vector3(1.0, 1.0, 2.0), gang = ""},
	    }
    },
    recipes = {
        cook = {
	    	heat = {take = {ephedrine = 1, acetone = 1}, give = {}}
	    },
	    bag = {
	    	bags = {take = {empty_weed_bag = 5}, give = {methbags = 5} }
	    }
    },
}