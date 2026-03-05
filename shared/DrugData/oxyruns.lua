if not Config.Drugs['oxyruns'] then return end
Config.Oxy = {
    Locations = {
        OxyPayForTruck = {
            {loc = vector3(1437.64, -1491.91, 63.62), truckSpawn = vector4(1450.87, -1482.13, 63.22, 69.95),size = vector3(1.0, 1.0, 2.0), gang = ""},
        },
	    oxylocations = {
            vector4(-2352.32, 266.78, 165.3, 23.46),
            vector4(-1467.49, 874.01, 183.59, 298.45),
            vector4(-856.71, 874.26, 202.85, 205.3),
            vector4(950.58, -128.49, 74.42, 205.3),
            vector4(1152.71, -328.43, 69.21, 205.3),
	        vector4(112.66, -1955.67, 20.75, 37.94),
	        vector4(-544.4, -1684.8, 19.89, 252.07),
	        vector4(-1185.02, -1805.4, 3.91, 184.83),
	        vector4(-1641.4, -981.99, 7.58, 35.38),
	        vector4(-1827.93, 782.36, 138.29, 219.99),
	        vector4(-320.84, 2818.73, 59.45, 337.22),
	        vector4(474.88, 2609.56, 44.48, 357.0),
        }
    },
    prices = {
	    payfortruck = 500,
	    hotchance = 30,
	    itemChance = 20,
    },
    itemList = {
        {item = 'lockpick', amount = 1},
    }
}