Config.Wholesale = {
    settings = {
        WholesaleQuantityBonus = 0.05, -- 5% bonus per 10 units sold (up to 20%)
        WholesaleMaxBonus = 0.20, -- Maximum 20% bonus
        WholesaleMinQuantity = 5, -- Minimum quantity required for wholesale
        WholesaleAmbushEnabled = true, -- Enable or disable ambush on failed deals
        WholesaleAmbushBase = 2, -- Base number of attackers on failed deals
        WholesaleAmbushScale = true, -- Scale number of attackers based on drug quantity
        WholesaleAmbushTier1 = 10, -- Drug quantity threshold for 3 attackers
        WholesaleAmbushTier2 = 20, -- Drug quantity threshold for 4 attackers
        WholesaleAmbushTier3 = 30, -- Drug quantity threshold for 5 attackers
        FailChance = 20, -- Percentage chance of ambush occurring on a failed deal
        PoliceCount = 0, -- Minimum police required to initiate a wholesale deal
    },
    Locs = {
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
    },
    Price = {
        cokeburner = {
            min = 25, 
            max = 50
        },
        crackburner = {
             min = 25, 
            max = 50
        },
        lsdburner = {
             min = 25, 
            max = 50
        },
        heroinburner = {
            min = 25, 
            max = 50
        },
        xtcburner = {
             min = 25, 
            max = 50
        },
        methburner = {
            min = 25, 
            max = 50
        }
    }
}