if not Config.Drugs['xtc'] then return end
Config.XTC = {
    Recipes = {
        raw = {
            raw_xtc = {take = {mdp2p = 1, isosafrole = 1}, give = {raw_xtc = 1}}
        },
	    singlestack = {
	        white_xtc =  {give = {white_xtc = 1}, take = {raw_xtc = 1}},
	    	red_xtc = 	 {give = {red_xtc = 1}, take = {raw_xtc = 1, loosecoke = 1},},
	    	orange_xtc = {give = {orange_xtc = 1}, take = {raw_xtc = 1, heroinvial = 1},},
	    	blue_xtc = 	 {give = {blue_xtc = 1}, take = {raw_xtc = 1, crackrock = 1},},
	     },
	     dualstack = {
	        white_xtc2 =  {give = {white_xtc2 = 1}, take = {raw_xtc = 1},},
	    	red_xtc2 =    {give = {red_xtc2 = 1}, take = {raw_xtc = 1, loosecoke = 1},},
	    	orange_xtc2 = {give = {orange_xtc2 = 1}, take = {raw_xtc = 1, heroinvial = 1},},
	    	blue_xtc2 =   {give = {blue_xtc2 = 1}, take = {raw_xtc = 1, crackrock = 1},},
	     },
	     triplestack = {
	        white_xtc3 =   {give = {white_xtc3 = 1}, take = {raw_xtc = 1},},
	    	red_xtc3 = 	   {give = {red_xtc3 = 1}, take = {raw_xtc = 1, loosecoke = 1},},
	    	orange_xtc3 =  {give = {orange_xtc3 = 1}, take = {raw_xtc = 1, heroinvial = 1},},
	    	blue_xtc3 =    {give = {blue_xtc3 = 1}, take = {raw_xtc = 1, crackrock = 1},},
	     },
	     quadstack = {
	    	white_xtc4 = 	{give = {white_xtc4 = 1}, take = {raw_xtc = 1},},
	    	red_xtc4 = 		{give = {red_xtc4 = 1}, take = {raw_xtc = 1, loosecoke = 1},},
	    	orange_xtc4 = 	{give = {orange_xtc4 = 1}, take = {raw_xtc = 1, heroinvial = 1},},
	    	blue_xtc4 = 	{give = {blue_xtc4 = 1}, take = {raw_xtc = 1, crackrock = 1},},
	     },
	    presses = {
	    	singlepress = {type = 1,cash = 10000},
	    	dualpress =   {type = 2,give  = {dualpress = 1}, take = {white_xtc = 20, blue_xtc = 20, red_xtc = 20, orange_xtc = 20, singlepress = 1}},
	    	triplepress = {type = 3,give  = {triplepress = 1}, take = {white_xtc2 = 50, blue_xtc2 = 50, red_xtc2 = 50, orange_xtc2 = 50, dualpress = 1}},
	    	quadpress =   {type = 4,give  = {quadpress = 1}, take = {white_xtc3 = 50, blue_xtc3 = 50, red_xtc3 = 50, orange_xtc3 = 50, triplepress = 1}},
	    }
    },
    Locations = {
        isosafrole = { -- where to steal isosafrole
            {loc = vector3(844.39, -902.92, 25.42), size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
        mdp2p = { -- where to steal mdp2p
            {loc = vector3(844.4, -898.79, 25.23), size = vector3(1.0, 1.0, 2.0), rot = 45.0, gang = ""},
        },
        rawxtcloc = { --  where to combine the 2 ingridents to make raw xtc
            {loc = vector3(844.71, -910.33, 25.37), size = vector3(1.0, 1.0, 2.0), rot = 45.0, gang = ""},
        },
        xtcpress = {
            {ped = 'g_f_y_families_01',loc = vector4(845.82, -884.79, 25.18, 180.0), size = vector3(1.0, 1.0, 2.0), rot = 45.0, gang = ""},
        },
        stamp = {  --  where to stamp pills
            {loc = vector3(844.71, -900.56, 25.43), size = vector3(1.0, 1.0, 2.0), rot = 45.0, gang = ""},
        },
    }
}