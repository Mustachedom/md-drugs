Config = {} --Ignore.
ps = exports.ps_lib:init()  --Ignore.
ps.loadLangs("en") -- set your language

Config.Fuel = "LegacyFuel" -- type the name of script you use i.e. ps-fuel, cdn-fuel, LegacyFuel, ox_fuel
Config.TierSystem = true -- allows for three tiers of certain drugs ( coke, heroin, crack, lsd)

----------------------------------- TierSystem levels ** ONLY IN USE IF CONFIG.TIERSYTEM IS TRUE
Config.Tier1 = 100 -- amount to hit for level 2
Config.Tier2 = 300 -- amount to hit for level 3

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
Config.minigametype = 'ps_circle' -- look above for options or choose none if you dont want any minigames 


Config.Drugs = { -- want a drug turn on? keep it true, want it turned off, mark it false
    cocaine = true,
    consumables = true,
    cornerselling = true,
    crack = true,
    deliveries = true,
    heroin = true,
    lean = true,
    lsd = true,
    mescaline = true,
    meth = true,
    oxyruns = true,
    pharma = true,
    shrooms = true,
    TravellingMerchant = true,
    weed = true,
    wholesale = false,
    xtc = true,
}

Config.Bzz = { -- if you have BZZZ props for these turn it on if you want
    cocaine = false,
    heroin =false,
    shrooms = false,
    weed = false,

}
