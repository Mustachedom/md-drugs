Config = {} --Ignore.

Config.Target = 'ox' -- qb or ox
Config.respawnTime = 10 -- Seconds
Config.Fuel = "LegacyFuel" -- type the name of script you use i.e. ps-fuel, cdn-fuel, LegacyFuel
Config.TierSystem = true -- allows for three tiers of certain drugs ( coke, heroin, crack, lsd)
Config.StupidassNewQbItemName = true -- true if you have updated your items.lua from base qb after november 2023 because changing item names this far in a framework is 3 IQ points total
Config.RequestModelTime = 30000 -- if you need more time than this, uhhhh wow

----------------------------------- TierSystem levels ** ONLY IN USE IF CONFIG.TIERSYTEM IS TRUE
Config.Tier1 = 100 -- amount to hit for level 2
Config.Tier2 = 300 -- amount to hit for level 3

---------------------------------- BRIDGE 
Config.progressbartype = 'oxcir' -- either 'qb', 'oxcir', 'oxbar'
Config.Notify = 'ox' -- -- either 'qb' or 'ox' or 'okok'
Config.Phone = 'qb' -- either 'qb' or 'yflip' or 'qs'
Config.Dispatch = 'ps' -- either 'ps', 'cd', 'core', 'aty'

Config.Minigames = {
    ps_circle =     {amount = 2,     speed = 8,},
    ps_maze =       {timelimit = 15},
    ps_scrambler =  {type = 'numeric', time = 15, mirrored = 0},
    ps_var =        {numBlocks = 5, time = 10},
    ps_thermite =   {time = 10, gridsize = 5, incorrect = 3},
    ox =            {'easy', 'easy'},   --easy medium or hard each one corresponds to how many skillchecks and the difficulty
    blcirprog =     {amount = 2, speed = 50},       -- speed = 1-100
    blprog =        {amount = 1, speed = 50},       -- speed = 1-100
    blkeyspam =     {amount = 1, difficulty = 50}, -- difficulty = 1-100
    blkeycircle =   {amount = 1, difficulty = 50, keynumbers = 3},
    blnumberslide = {amount = 1, difficulty = 50, keynumbers = 3},
    blrapidlines =  {amount = 1, difficulty = 50, numberofline = 3},
    blcircleshake = {amount = 1, difficulty = 50, stages = 3},
    glpath =        {gridSize = 19,  lives = 3,     timelimit = 10000},
    glspot =        {gridSize = 6, timeLimit = 999999, charSet = "alphabet", required = 10},
    glmath =        {timeLimit = 300000},

}
Config.minigametype = 'ox' -- look above for options or choose none if you dont want any minigames 
------------- you can either set a gang or leave it blank, if blank it will autopopulate data to not require it :)
----
---
------------- Cocaine -- new animations require to be in a certain spot or they get fucky. uses bob74 ipl if you turn Config.FancyCokeAnims you can put it anywhere :) 
Config.FancyCokeAnims = false -- if you want multi location this needs to be false
Config.tabcost = 100 -- price per piece of tab paper event does 10 at a time
Config.lsdlabkitcost = 10000 -- price of the lsd lab kit
Config.heroinlabkitprice = 10000 -- price of the lsd lab kit
Config.Badtrip = 20 -- number means % chance to spawn a clone that chases and attacks while on mescaline
-------------- lean

Config.StartLoc = {
    vector3(-2307.22, 434.77, 174.47), -- where the truck spawns
    vector3(614.75, 1786.26, 199.39),
    vector3(-224.89, 6388.32, 31.59)
}

---------- Pharma
Config.PharmaJob = "ems" -- what TYPE role you need to be on to get the command

-------------- weed
Config.WeedDry = { -- where you dry leaves 
    {loc = vector3(1043.0, -3191.59, -38.39),},
    {loc = vector3(1041.0, -3191.59, -38.39),},
    {loc = vector3(1045.0, -3191.59, -38.39),},
    {loc = vector3(1039.0, -3191.59, -38.39),},
}

Config.Joblock = false -- if you want weed to be a job
Config.weedjob = "" -- what the job name is

----------------- Wholesale
Config.SuccessfulChance = 90 --- this is the chance of a Success wholesale 1-100
Config.AlertPoliceWholesale = 90 -- 1-100 of how often it will alert police
Config.WholesaleTimeout = 600 -- time in seconds to get to the location
Config.PoliceCount = 0 -- Amount of police required
Config.Wcoke =  { min = 20, max = 60} -- pricings per item
Config.Wcrack = { min = 20, max = 60} -- pricings per item
Config.Wlsd = { min = 20, max = 60} -- pricings per item
Config.WXTC = { min = 20, max = 60} -- pricings per item


--- travelling merchant

Config.Travellingmerchant = { ------------ these are the random locations the merchant can spawn on script start. whatever you want for the merchant is in Config.Items right below
    vector4(-119.66, -977.43, 304.25, 88.21),
	vector4(-1522.93, 1476.01, 111.45, 41.25),
	vector4(-3278.98, 973.38, 5.35, 101.53),
}

--------------------------------------- oxy runs
---- How oxyruns work. You pay for a truck, you get in it and it gives a route. There is a 20% chance that the car will be "hot" and you have to ditch it. No Routes will spawn if that pops up
----- when you get to the drop off point third eye the truck. You will carry a box to the ped. He will give you cash, some oxy and maybe a random item. Rinse and repeat
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
Config.MethHeist = false