Config = {} --Ignore.

Config.UseTarget = true
Config.rewardItem = "coca_leaf"
Config.rewardItemheroin = "poppyresin"
Config.rewardshrooms = "shrooms"
Config.rewardMescaline = "cactusbulb"
Config.rewardWeed = "wetcannabis"
Config.requestModelTime = 30000 -- time for ox_lib to request the model to spawn props, increase based on your server and player's experience with failed model requests
Config.oxtarget = true --- turn to true if you use oxtarget
Config.respawnTime = 150 -- Seconds
Config.Fuel = "LegacyFuel" -- type the name of script you use i.e. ps-fuel, cdn-fuel, LegacyFuel
Config.OxInv = true -- true if you use ox inventory, false if you use qb/lj/ps
Config.TierSystem = true -- allows for three tiers of certain drugs ( coke, heroin, crack
Config.StupidassNewQbItemName = false -- true if you have updated your items.lua from base qb after november 2023 because changing item names this far in a framework is 3 IQ points total
Config.imagelink = "ox_inventory/web/images/"


------------- Cocaine -- new animations require to be in a certain spot or they get fucky. uses bob74 ipl 
Config.CokeTeleIn = vector3(198.16, -1276.92, 29.33)-- where you target to go inside
Config.CokeTeleOut = vector3(1088.81, -3187.57, -38.99) -- where you target to leave
Config.MakePowder = vector3(1087.29, -3195.33, -38.99) -- where you chop your coca leaves to make powder

---------------- Crack locations
Config.makecrack = vector3(2434.07, 4969.39, 42.35) -- make crack with baking soda with cut coke 1-3
Config.bagcrack = vector3(2435.85, 4965.3, 42.35) ---  bag crack 1-3 stages

------------------------- LSD Locations
Config.lysergicacid = vector3(-1370.71, -317.3, 39.51) -- get lysergic acid
Config.diethylamide = vector3(-1371.71, -316.02, 39.53) -- get diethylamide
Config.gettabs = vector3(-1370.77, -314.51, 39.58) -- buy tab paper
Config.buylsdlabkit = vector3(-1368.89, -318.72, 39.5)--  buy lab kit
Config.tabcost = 100 -- price per piece of tab paper event does 10 at a time
Config.lsdlabkitcost = 10000 -- price of the lsd lab kit
------------------------- Heroin Locations

Config.dryplant = vector3(-1364.7, -323.21, 39.44) -- turn resin into powder
Config.buyheroinlabkit = vector3(-1361.08, -321.41, 39.53) -- buy heroin lab kit
Config.cutheroinone = vector3(-1364.86, -320.15, 39.51) -- cut heroin stage 1-3 with baking soda
Config.fillneedle = vector3(-1366.18, -317.81, 39.56) -- fill needles with heroin
Config.heroinlabkitprice = 10000 -- price of the lsd lab kit
------------ XTC
Config.isosafrole = vector3(892.7, -957.2, 39.28) -- where to steal isosafrole
Config.mdp2p = vector3(901.07, -963.11, 39.28) -- where to steal mdp2p
Config.rawxtcloc = vector3(898.51, -960.2, 39.28) --  where to combine the 2 ingridents to make raw xtc
Config.stamp = vector3(895.98, -963.57, 39.28) --  where to stamp pills
Config.buypress = vector3(868.3, -960.72, 26.28)--  Where you buy your presses

----- mescaline
Config.DryOut = vector3(2622.6, 4222.57, 43.6) -- Place to dry out mescaline into usuable drug
Config.Badtrip = 20 -- number means % chance to spawn a clone that chases and attacks while on mescaline


-------------- lean
Config.SyrupVendor = vector3(362.71, -577.84, 39.3) -- where the mission ped starts
Config.StartLoc = {
vector3(-2307.22, 434.77, 174.47), -- where the truck spawns
vector3(614.75, 1786.26, 199.39),
vector3(-224.89, 6388.32, 31.59)
}


---------- Pharma
Config.FillPrescription = vector3(2432.89, 4252.2, 36.35) ----------- this is where you want people to take their prescription to get a bottle of pills. They use bottle to get a random amount of prescription pills
Config.PharmaJob = "ambulance" -- what job role you need to be on to get the command


-------------- weed
Config.Teleout = vector3(1066.31, -3183.36, -39.16) -- where you target to tele in
Config.Telein = vector3(244.74, 374.54, 105.74) -- where you target to tele out
Config.MakeButter = vector3(1045.48, -3198.49, -38.22) -- where you make cannabutter and baked edibles
Config.MakeOil = vector3(1038.90, -3198.66, -38.17-1) -- where you make shatter

Config.WeedDry = { -- where you dry leaves 
vector3(1043.0, -3191.59, -38.39),
vector3(1041.0, -3191.59, -38.39),
vector3(1045.0, -3191.59, -38.39),
vector3(1039.0, -3191.59, -38.39),
}

Config.Joblock = false -- if you want weed to be a job
Config.weedjob = "" -- what the job name is
Config.Weed = { --- this is the store for the weed ingridients
    label = "Weed Shop",
    slots = 8,
    items = {
        [1] = {name = "weedgrinder", 	label = "Weed Grinder",		price = 25, 	amount = 50, 	info = {}, type = "item", slot = 1},
		[2] = {name = "mdbutter", 		label = "Butter",			price = 25, 	amount = 50, 	info = {}, type = "item", slot = 2},
		[3] = {name = "flour", 			label = "Flour", 			price = 25, 	amount = 50, 	info = {}, type = "item", slot = 3},
		[4] = {name = "chocolate",  	label = "chocolate",		price = 25, 	amount = 50, 	info = {}, type = "item", slot = 4},
		[5] = {name = "butane", 		label = "Butane", 			price = 25, 	amount = 50, 	info = {}, type = "item", slot = 5},
		[6] = {name = "butanetorch", 	label = "Butane Torch", 	price = 2, 		amount = 1000, 	info = {}, type = "item", slot = 6},
		[7] = {name = "dabrig", 		label = "Dab Rig", 			price = 2, 		amount = 1000, 	info = {}, type = "item", slot = 7},
		[8] = {name = "mdwoods", 		label = "MD Woods", 		price = 2, 		amount = 1000, 	info = {}, type = "item", slot = 8},	
	}
}

----------------- Wholesale
Config.SuccessfulChance = 90 --- this is the chance of a Success wholesale 1-100
Config.AlertPoliceWholesale = 10 -- 1-100 of how often it will alert police


--- travelling merchant

Config.Travellingmerchant = { ------------ these are the random locations the merchant can spawn on script start. whatever you want for the merchant is in Config.Items right below
	vector3(-119.06, -977.19, 304.25),
	vector3(-1522.23, 1475.63, 112.02),
	vector3(-3278.99, 973.33, 5.34),
}
Config.Items = { --- this is the store for the travelling merchant
    label = "Travelling Merchant",
    slots = 24,
    items = {
        [1] = {name = "tab_paper", 		label = "Tab Paper", 		price = 50, 	amount = 50, 	info = {}, type = "item", slot = 1},
        [2] = {name = "bakingsoda", 	label = "Baking Soda",		price = 25, 	amount = 50, 	info = {}, type = "item", slot = 2},
		[3] = {name = "isosafrole", 	label = "Isosafrole",		price = 25, 	amount = 50, 	info = {}, type = "item", slot = 3},
		[4] = {name = "mdp2p", 			label = "MDP2P", 			price = 25, 	amount = 50, 	info = {}, type = "item", slot = 4},
		[5] = {name = "lysergic_acid",  label = "Lysergic Acid",	price = 25, 	amount = 50, 	info = {}, type = "item", slot = 5},
		[6] = {name = "diethylamide",   label = "Diethylamide", 	price = 25, 	amount = 50, 	info = {}, type = "item", slot = 6},
		[7] = {name = "empty_weed_bag", label = "Empty Weed Bag", 	price = 2, 	    amount = 1000, 	info = {}, type = "item", slot = 7},
		[8] = {name = "emptyvial", 		label = "Empty Vial", 		price = 2, 	    amount = 1000, 	info = {}, type = "item", slot = 8},
		[9] = {name = "needle", 		label = "Syringe", 			price = 2, 		amount = 1000,	info = {}, type = "item", slot = 9},
		[10] = {name = "cokeburner", 	label = "Nokie Burner", 	price = 25, 	amount = 50, 	info = {}, type = "item", slot = 10},
		[11] = {name = "crackburner", 	label = "Juke Burner",		price = 2, 		amount = 50, 	info = {}, type = "item", slot = 11},
		[12] = {name = "lsdburner",		label = "SideKick Burner",	price = 2, 		amount = 50, 	info = {}, type = "item", slot = 12},
		[13] = {name = "heroinburner", 	label = "Razr Burner",		price = 2, 		amount = 50, 	info = {}, type = "item", slot = 13},
		[14] = {name = "mdlean", 		label = "Sizzurup", 		price = 50, 	amount = 50, 	info = {}, type = "item", slot = 14},
        [15] = {name = "weedgrinder", 	label = "Weed Grinder",		price = 25, 	amount = 50, 	info = {}, type = "item", slot = 15},
		[16] = {name = "mdbutter", 		label = "Butter",			price = 25, 	amount = 50, 	info = {}, type = "item", slot = 16},
		[17] = {name = "flour", 		label = "Flour", 			price = 25, 	amount = 50, 	info = {}, type = "item", slot = 17},
		[18] = {name = "chocolate",  	label = "chocolate",		price = 25, 	amount = 50, 	info = {}, type = "item", slot = 18},
		[19] = {name = "butane", 		label = "Butane", 			price = 25, 	amount = 50, 	info = {}, type = "item", slot = 19},
		[20] = {name = "butanetorch", 	label = "Butane Torch", 	price = 2, 		amount = 1000, 	info = {}, type = "item", slot = 20},
		[21] = {name = "dabrig", 		label = "Dab Rig", 			price = 2, 		amount = 1000, 	info = {}, type = "item", slot = 21},
		[22] = {name = "mdwoods", 		label = "MD Woods", 		price = 2, 		amount = 1000, 	info = {}, type = "item", slot = 22},
		[23] = {name = "leancup", 		label = "Empty Cup", 		price = 25, 	amount = 50, 	info = {}, type = "item", slot = 23},
        [24] = {name = "xtcburner", 	label = "ENV Burner", 		price = 25, 	amount = 50, 	info = {}, type = "item", slot = 24},
		
	}
}
--------------------------------------- oxy runs
---- How oxyruns work. You pay for a truck, you get in it and it gives a route. There is a 20% chance that the car will be "hot" and you have to ditch it. No Routes will spawn if that pops up
----- when you get to the drop off point third eye the truck. You will carry a box to the ped. He will give you cash, some oxy and maybe a random item. Rinse and repeat


Config.truckspawn = vector4(1449.65, -1486.0, 63.22, 342.58) --- where the truck will spawn when you pay for it 
Config.Payfortruck = vector3(1437.64, -1491.91, 63.62) --- where you pay for the truck
Config.TruckPrice = 500 -- amount the truck will cost to rent
Config.OxyRunCompleteCash = 200 -- base price you get for completeing a run. 50% if the car needs to be ditched
Config.OxyRunDitchChance = 20 -- % of a fail mission and having to ditch the car and not get a new order
Config.OxyItemChance = 50 -- chance to recieve an item from the OxyRandItems list below 
Config.OxyItemAmount = 1 -- amount of the item you recieve when you get an item from OxyRandItems
Config.PoliceAlertOxy = 90 -- This is a % out of 100 to alert police

Config.oxylocations = { -- These are different locations where a ped spawns.
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

Config.OxyRandItems = { -- random items you get for completing the mission
"oxy",
"lockpick",
"cryptostick",
}


---------------------- Meth Config
Config.MethTeleIn = vector3(-2222.04, 303.99, 174.6) -- where you target to tele in
Config.MethTeleOut = vector3(996.91, -3200.83, -36.39) -- where you target to tele out
Config.MethHeistStart = vector3(-1102.93, -3066.76, 14.00) -- where you get the mission to get ingridients


----------------------------- these are the locations where props will be spawned to be picked 
Config.CocaPlant = {
    [1] = {
        location = vector3(1474.25, -2643.87, 42.88),
        heading = 334.49,
        model = "prop_plant_01a"
    },
    [2] = {
        location = vector3(1472.35, -2649.3, 41.87),
        heading = 329.56,
        model = "prop_plant_01a"
    },
    [3] = {
        location = vector3(1475.7, -2652.9, 40.8),
        heading = 25.16,
        model = "prop_plant_01a"
    },
    [4] = {
        location = vector3(1481.0, -2654.99, 39.86),
        heading = 21.52,
        model = "prop_plant_01a"
    },
    [5] = {
        location = vector3(1480.9, -2660.63, 38.68),
        heading = 202.97,
        model = "prop_plant_01a"
    },
    [6] = {
        location = vector3(1477.18, -2666.53, 38.19),
        heading = 202.97,
        model = "prop_plant_01a"
    },
    [7] = {
        location = vector3(1477.58, -2670.82, 37.73),
        heading = 202.97,
        model = "prop_plant_01a"
    },
    [8] = {
        location = vector3(1476.56, -2675.82, 37.46),
        heading = 202.97,
        model = "prop_plant_01a"
    },
    [9] = {
        location = vector3(1474.8, -2680.19, 37.03),
        heading = 202.97,
        model = "prop_plant_01a"
    },
    [10] = {
        location = vector3(1471.52, -2685.0, 36.82),
        heading = 202.97,
        model = "prop_plant_01a"
    },
    [11] = {
        location = vector3(1462.82, -2676.58, 38.83),
        heading = 202.97,
        model = "prop_plant_01a"
    },
    [12] = {
        location = vector3(1461.31, -2667.74, 39.67),
        heading = 202.97,
        model = "prop_plant_01a"
    },
    [13] = {
        location = vector3(1456.3, -2647.61, 43.39),
        heading = 202.97,
        model = "prop_plant_01a"
    },
    [14] = {
        location = vector3(1453.65, -2641.56, 45.0),
        heading = 202.97,
        model = "prop_plant_01a"
    },
}

Config.WeedPlant = {
    [1] = {
        location = vector3(1049.63, -3202.12, -39.15),
        heading = 334.49,
        model = "bkr_prop_weed_lrg_01b"
    },
    [2] = {
        location = vector3(1050.85, -3202.15, -39.15),
        heading = 329.56,
        model = "bkr_prop_weed_lrg_01b"
    },
    [3] = {
        location = vector3(1052.01, -3202.22, -39.13),
        heading = 25.16,
        model = "bkr_prop_weed_lrg_01b"
    },
    [4] = {
        location = vector3(1052.99, -3202.15, -39.15),
        heading = 21.52,
        model = "bkr_prop_weed_lrg_01b"
    },
    [5] = {
        location = vector3(1053.08, -3201.11, -39.13),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [6] = {
        location = vector3(1052.91, -3199.99, -39.14),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [7] = {
        location = vector3(1053.02, -3198.97, -39.11),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [8] = {
        location = vector3(1051.95, -3198.93, -39.11),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [9] = {
        location = vector3(1051.96, -3199.86, -39.12),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [10] = {
        location = vector3(1051.93, -3201.17, -39.12),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [11] = {
        location = vector3(1050.98, -3201.13, -39.14),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [12] = {
        location = vector3(1050.89, -3200.07, -39.12),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [13] = {
        location = vector3(1050.89, -3198.95, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [14] = {
        location = vector3(1049.72, -3198.95, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
	[15] = {
        location = vector3(1049.98, -3200.1, -39.14),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
	[16] = {
        location = vector3(1049.82, -3201.01, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
	[17] = {
        location = vector3(1053.07, -3194.51, -39.15),
        heading = 334.49,
        model = "bkr_prop_weed_lrg_01b"
    },
    [18] = {
        location = vector3(1052.97, -3195.55, -39.15),
        heading = 329.56,
        model = "bkr_prop_weed_lrg_01b"
    },
    [19] = {
        location = vector3(1052.82, -3196.58, -39.15),
        heading = 25.16,
        model = "bkr_prop_weed_lrg_01b"
    },
    [20] = {
        location = vector3(1052.94, -3197.59, -39.15),
        heading = 21.52,
        model = "bkr_prop_weed_lrg_01b"
    },
    [21] = {
        location = vector3(1051.92, -3197.54, -39.14),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [22] = {
        location = vector3(1051.88, -3196.61, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [23] = {
        location = vector3(1051.82, -3195.52, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [24] = {
        location = vector3(1051.95, -3194.38, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [25] = {
        location = vector3(1050.88, -3194.31, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [26] = {
        location = vector3(1050.78, -3195.29, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [27] = {
        location = vector3(1050.76, -3196.49, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [28] = {
        location = vector3(1050.77, -3197.62, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [29] = {
        location = vector3(1049.64, -3197.61, -39.14),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
    [30] = {
        location = vector3(1049.64, -3196.59, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
	[31] = {
        location = vector3(1049.62, -3195.51, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
	[32] = {
        location = vector3(1049.66, -3194.36, -39.15),
        heading = 202.97,
        model = "bkr_prop_weed_lrg_01b"
    },
}

Config.PoppyPlants = {
    [1] = {
        location = vector3(-2251.3, -99.18, 100.11),
        heading = 334.49,
        model = "prop_plant_01b"
    },
    [2] = {
        location = vector3(-2249.63, -92.97, 101.8),
        heading = 329.56,
        model = "prop_plant_01b"
    },
    [3] = {
        location = vector3(-2245.57, -85.12, 104.5),
        heading = 25.16,
        model = "prop_plant_01b"
    },
    [4] = {
        location = vector3(-2240.81, -88.48, 105.88),
        heading = 21.52,
        model = "prop_plant_01b"
    },
	[5] = {
        location = vector3(-2240.87, -93.36, 103.88),
        heading = 334.49,
        model = "prop_plant_01b"
    },
    [6] = {
        location = vector3(-2236.0, -95.34, 102.55),
        heading = 329.56,
        model = "prop_plant_01b"
    },
    [7] = {
        location = vector3(-2240.6, -100.01, 100.49),
        heading = 25.16,
        model = "prop_plant_01b"
    },
    [8] = {
        location = vector3(-2246.29, -104.92, 99.27),
        heading = 21.52,
        model = "prop_plant_01b"
    },
	[9] = {
        location = vector3(-2243.64, -107.99, 96.71),
        heading = 334.49,
        model = "prop_plant_01b"
    },
    [10] = {
        location = vector3(-2254.22, -108.76, 97.25),
        heading = 329.56,
        model = "prop_plant_01b"
    },
    [11] = {
        location = vector3(-2247.33, -108.92, 97.70),
        heading = 25.16,
        model = "prop_plant_01b"
    },
    [12] = {
        location = vector3(-2250.96, -111.22, 97.50),
        heading = 21.52,
        model = "prop_plant_01b"
    },
	 [13] = {
        location = vector3(465.95, -1021.32, 31.78),
        heading = 21.52,
        model = "prop_plant_01b"
    },
   
}

Config.shrooms = {
    [1] = {
        location = vector3(2185.14, 5183.81, 57.48),
        heading = 334.49,
        model = "mushroom"
    },
    [2] = {
        location = vector3(2174.45, 5187.85, 57.43),
        heading = 329.56,
        model = "mushroom"
    },
    [3] = {
        location = vector3(2166.22, 5196.56, 58.0),
        heading = 25.16,
        model = "mushroom"
    },
    [4] = {
        location = vector3(2166.82, 5204.83, 58.63),
        heading = 21.52,
        model = "mushroom"
    },
	[5] = {
        location = vector3(2174.84, 5205.82, 59.19),
        heading = 334.49,
        model = "mushroom"
    },
    [6] = {
        location = vector3(2184.46, 5201.23, 59.2),
        heading = 329.56,
        model = "mushroom"
    },
    [7] = {
        location = vector3(2192.45, 5194.89, 58.86),
        heading = 25.16,
        model = "mushroom"
    },
    [8] = {
        location = vector3(2207.53, 5187.81, 58.95),
        heading = 21.52,
        model = "mushroom"
    },
	[9] = {
        location = vector3(2213.46, 5191.11, 59.81),
        heading = 334.49,
        model = "mushroom"
    },
    [10] = {
        location = vector3(2218.31, 5180.0, 58.18),
        heading = 329.56,
        model = "mushroom"
    },
    [11] = {
        location = vector3(2212.75, 5172.35, 57.2),
        heading = 25.16,
        model = "mushroom"
    },
    [12] = {
        location = vector3(2208.56, 5167.06, 56.34),
        heading = 21.52,
        model = "mushroom"
    },
	 [13] = {
        location = vector3(2196.9, 5158.59, 54.84),
        heading = 21.52,
        model = "mushroom"
    },
   
    [14] = {
        location = vector3(2191.62, 5174.91, 56.68),
        heading = 21.52,
        model = "mushroom"
    },
    [15] = {
        location = vector3(2190.18, 5182.54, 57.47),
        heading = 21.52,
        model = "mushroom"
    },
    [16] = {
        location = vector3(2185.85, 5190.49, 58.1),
        heading = 21.52,
        model = "mushroom"
    },
    [17] = {
        location = vector3(2179.95, 5194.19, 58.26),
        heading = 21.52,
        model = "mushroom"
    },
	
   
   
}

Config.Mescaline = {
    [1] = {
        location = vector3(2598.73, 4207.89, 41.02),
        heading = 334.49,
        model = "prop_cactus_03"
    },
    [2] = {
        location = vector3(2601.46, 4199.34, 40.62),
        heading = 329.56,
        model = "prop_cactus_03"
    },
    [3] = {
        location = vector3(2611.63, 4194.18, 41.18),
        heading = 25.16,
        model = "prop_cactus_03"
    },
    [4] = {
        location = vector3(2620.18, 4202.69, 41.5),
        heading = 21.52,
        model = "prop_cactus_03"
    },
	[5] = {
        location = vector3(2624.26, 4211.75, 42.34),
        heading = 334.49,
        model = "prop_cactus_03"
    },
    [6] = {
        location = vector3(2635.21, 4207.5, 42.49),
        heading = 329.56,
        model = "prop_cactus_03"
    },
    [7] = {
        location = vector3(2644.97, 4193.51, 42.11),
        heading = 25.16,
        model = "prop_cactus_03"
    },
    [8] = {
        location = vector3(2654.21, 4195.31, 41.23),
        heading = 21.52,
        model = "prop_cactus_03"
    },
	[9] = {
        location = vector3(2653.32, 4206.49, 41.62),
        heading = 334.49,
        model = "prop_cactus_03"
    },
    [10] = {
        location = vector3(2647.45, 4213.94, 42.49),
        heading = 329.56,
        model = "prop_cactus_03"
    },
    [11] = {
        location = vector3(2636.3, 4218.49, 43.03),
        heading = 25.16,
        model = "prop_cactus_03"
    },
    [12] = {
        location = vector3(2627.37, 4223.2, 42.88),
        heading = 21.52,
        model = "prop_cactus_03"
    },
	 [13] = {
        location = vector3(2617.86, 4230.38, 42.63),
        heading = 21.52,
        model = "prop_cactus_03"
    },
   
    [14] = {
        location = vector3(2609.8, 4222.12, 41.19),
        heading = 21.52,
        model = "prop_cactus_03"
    },
    [15] = {
        location = vector3(2602.96, 4194.05, 41.01),
        heading = 21.52,
        model = "prop_cactus_03"
    },
    [16] = {
        location = vector3(2614.39, 4188.3, 41.68),
        heading = 21.52,
        model = "prop_cactus_03"
    },
    [17] = {
        location = vector3(2623.82, 4189.97, 41.44),
        heading = 21.52,
        model = "prop_cactus_03"
    },
   
   
}

