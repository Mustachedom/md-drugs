Lang = {}

Lang.targets = {
    coke = {
        pick = 'Rrrowr rraar rawr grrr',                    -- "Pick Wookie Leaf"
        cut = 'Rraar gwah raarrrk',                         -- "Cut Leaf Dust"
        bag = 'Rraar rawr wrooowr',                         -- "Bag Dust Fast"
        enter = 'Rrrowr hnnnngg kashyyyk',                  -- "Enter Safe Den"
        exit = 'Hrrooo kashyyyk',                           -- "Exit Den"
        chop = 'Rraar rawr gwah rrrr',                      -- "Chop Leaf Into Dust"
    },
    CornerSell = {
        sell = 'Rawr %s rraar %s grrr $%s',                 -- "Sell %s Of %s For $%s"
        deny = 'Rrrowr rraarrrk'                            -- "Deny Offer"
    },
    crack = {
        cook = 'Rraar rawr hrrrnngg',                       -- "Cook Fire Rock"
        bag = 'Rrrowr rawr wrooowr'                         -- "Bag Rock Fast"
    },
    Delivery = {
        Deliver = 'Rraar rawr %s',                          -- "Deliver For %s"
        open = 'Rraar rawr %s kraar',                       -- "Open %s Shop"
        hand = 'Rrrowr rawr'                                -- "Hand Over"
    },
    heroin = {
        pick = 'Rrrowr rawr grrr',                          -- "Pick Poppy Flower"
        up = 'Rrrowr rawr kraar',                           -- "Pick Up Table"
        dry = 'Rraar rawr hnnnngg',                         -- "Dry Poppy In Sun"
        cut = 'Rraar rawr grrr grrr',                       -- "Cut Dust With Sparkle"
        cook = 'Rraar rawr hrrrnngg',                       -- "Cook Dream Dust"
        kit = 'Rraar rawr lab kashyyyk',                    -- "Buy Heroin Lab Kit"
        clean = 'Rraar rawr kraar grrr',                    -- "Clean Table Dust"
        fill = 'Rraar rawr syringe',                        -- "Fill Syringe"
        vial = 'Rraar rawr vial',                           -- "Make Vial"
    },
    lean = {
        git = 'Rrrowr rawr task',                           -- "Get Task"
        st = 'Rrrowr rawr car grrr'                         -- "Steal From Car"
    },
    lsd = {
        buy = 'Rraar rawr lab kashyyyk',                    -- "Buy LSD Lab Kit"
        heat = 'Rraar rawr fire',                           -- "Heat Liquid"
        refine = 'Rraar rawr pure',                         -- "Refine Quality"
        paper = 'Rraar rawr paper',                         -- "Make Tab Paper"
        back = 'Rrrowr rawr lab kashyyyk',                  -- "Pick Up Lab Kit"
        dab = 'Rraar rawr paper dab',                       -- "Dab LSD on sheets"
        clean = 'Rraar rawr table grrr',                    -- "Clean Table"
        lys = 'Rrrowr rawr acid',                           -- "Steal Lysergic Acid"
        die = 'Rrrowr rawr ether',                          -- "Steal Diethylamide"
        buyt = 'Rraar rawr tab',                            -- "Buy Tabs"
    },
    mescaline = {
        pick = 'Rrrowr rawr cactus',                        -- "Pick Cactus"
        dry = 'Rraar rawr cactus hnnnngg',                  -- "Dry Out Cactus"
    },
    meth = {
        bag = 'Rrrowr rawr baggie',                         -- "Bag Up Meth"
        enter = 'Rrrowr hnnnngg kraar',                     -- "Enter Building"
        exit = 'Hrrooo kraar',                              -- "Exit Building"
        cook = 'Rraar rawr fire dust',                      -- "Cook Meth"
        tray = 'Rrrowr rawr tray',                          -- "Grab Tray"
        box = 'Rrrowr rawr box',                            -- "Box Up Meth"
        adjust = 'Rraar rawr heat',                         -- "Adjust Temperature"
        eph = 'Rrrowr rawr ephedrine',                      -- "Steal Ephedrine"
        ace = 'Rrrowr rawr acetone',                        -- "Steal Acetone"
        mission = 'Rrrowr rawr mission',                    -- "Get Mission"
        stealfromcar = 'Rrrowr rawr car grrr'               -- "Steal From Car"
    },
    oxy = {
        pack = 'Rrrowr rawr package',                       -- "Get Oxy Package"
        talk = 'Rrrowr rawr buyer',                         -- "Talk To Buyer"
        pay = 'Rrrowr rawr truck',                          -- "Pay For Truck"
    },
    pha = {
        fill = 'Rrrowr rawr script',                        -- "Fill Prescription"
    },
    shrooms = {
        pick = 'Rrrowr rawr mushie',                        -- "Pick Shrooms"
    },
    travel = {
        travel = 'Rrrowr rawr merchant',                    -- "Open Travelling Merchant"
    },
    xtc = {
        iso = 'Rrrowr rawr iso',                            -- "Steal Isosafrole"
        mdp = 'Rrrowr rawr mdp2p',                          -- "Steal MDP2P"
        raw = 'Rrrowr rawr raw xtc',                        -- "Make Raw XTC"
        press = 'Rrrowr rawr press',                        -- "Buy XTC Press"
        stamp = 'Rrrowr rawr stamp',                        -- "Stamp Pills"
        make = 'Rrrowr rawr xtc',                           -- "Make XTC"
        pick = 'Rrrowr rawr press up',                      -- "Pick Up Press"
    },
    weed = {
        pick = 'Rrrowr rawr weed',                          -- "Pick Weed"
        dry = 'Rraar rawr weed hnnnngg',                    -- "Dry Weed"
        dpick = 'Rrrowr rawr dried weed',                   -- "Pick Dried Weed"
        butt = 'Rrrowr rawr edible menu',                   -- "Open Edible Menu"
        oil = 'Rrrowr rawr oil',                            -- "Make Oil"
    },
    Wholesale = {
        talk = 'Rrrowr rawr buyer'                          -- "Talk To Buyer"
    },
}

-- 🌿 COKE: Wookiee Leaf Dust Hustle
Lang.Coke = {
    picking = "Rrrowr rawr leaf",
    makepow = 'Rraar rawr leaf dust',
    cutting = 'Rraar rawr dust sparkle',
    bagging = "Rraar rawr baggie wrooowr",
    cut = "Rraar rawr dust cut",
    nocutcoke = "Rrrowr rawr no dust? RRAAARRGH!",
    bagcoke = "Rraar rawr bagged dust",
    nobagcoke = "Rrrowr rawr no dust? RRAAARRGH!",
}

-- 💥 CRACK: Fire Rock Time
Lang.Crack = {
    cookcrack = "Rraar rawr fire rock",
    bagcrack = 'Rraar rawr baggie wrooowr',
    makecrack = 'Rraar rawr nice rock',
    nocoke = 'Rrrowr rawr no dust? RRAAARRGH!',
}

-- 🛍️ CORNER SELLING: Street Hustle
Lang.Cornerselling = {
    inveh = 'Rrrowr rawr car danger! RRAAARRGH!',
    toofar = "Rrrowr rawr too far den",
    selling = 'Rrrowr rawr %s grrr $%s',
    deny = "Rrrowr rawr no offer",
    start = "Rraar rawr get cash",
    stop = "Rrrowr rawr lazy",
    nodrugs = "Rrrowr rawr sell air? RRAAARRGH!",
    notcops = "Rrrowr rawr no cops",
    no = 'Rrrowr rawr no sell here',
    sell = "Rrrowr rawr selling",
}

-- 📦 DELIVERY: Wookiee Courier
Lang.Delivery = {
    emailn = 'Rrrowr rawr not dealer',
    emailsub = 'Rraar rawr hurry package',
    emailcon = 'Rrrowr rawr if no deliver, tell mom you say FUMP! Bring %s Of %s!',
    search = "Rrrowr rawr find delivery",
    none = "Rrrowr rawr nothing",
    busy = "Rrrowr rawr already busy",
    found = "Rrrowr rawr map mark",
    already = "Rrrowr rawr already go",
    checkrep = "Rrrowr rawr rep: ",
    pack = 'Rrrowr rawr hand package',
}

-- 💤 HEROIN: Dream Dust of the Forest
Lang.Heroin = {
    pick = "Rrrowr rawr poppy",
    tableout = 'Rrrowr rawr table out',
    dryout = "Rraar rawr poppy sun",
    cutting = "Rraar rawr dust sparkle",
    secret = "Rrrowr rawr SHHHHHHH",
    table = "Rrrowr rawr table down",
    success = "Rraar rawr heated good",
    clean = 'Rrrowr rawr table clean',
    needles = 'Rrrowr rawr syringe fill',
    pickup = 'Rrrowr rawr table up',
    cutheroin = 'Rraar rawr cut dust',
    noheroin = "Rrrowr rawr no dust? RRAAARRGH!",
    vial = 'Rraar rawr made vial',
    novial = "Rrrowr rawr no dust? RRAAARRGH!",
    fail = 'Rraar rawr too hot! RRAAARRGH!',
    fill = 'Rrrowr rawr syringe full',
    nofill = 'Rrrowr rawr no dust? RRAAARRGH!',
    haskit = 'Rrrowr rawr already have kit'
}

-- 🟪 LEAN: Purple Syrup of the Ancients
Lang.Lean = {
    marked = 'Rrrowr rawr car marked',
    lean = 'Rrrowr rawr purple juice',
    dextro = 'Rrrowr rawr red juice',
    act = 'Rrrowr rawr already task',
}

-- 🌈 LSD: Magic of the Ancient Trees
Lang.lsd = {
    steallys = 'Rrrowr rawr acid steal',
    stealdie = 'Rrrowr rawr ether steal',
    tableout = 'Rrrowr rawr table out',
    tablepack = 'Rrrowr rawr pack table',
    heat = 'Rraar rawr heat liquid',
    clean = 'Rrrowr rawr clean table',
    refine = 'Rraar rawr refine pure',
    dip = 'Rrrowr rawr dab paper',
    buypaper = 'Rrrowr rawr buy paper',
    buykit = 'Rrrowr rawr buy kit',
    place = 'Rrrowr rawr place table',
    hav = 'Rrrowr rawr already table',
    lys = 'Rrrowr rawr got acid',
    die = 'Rrrowr rawr got ether',
    cleaned = 'Rrrowr rawr table clean',
    madelsd = 'Rraar rawr made magic',
    failed = 'Rraar rawr too hot! RRAAARRGH!',
    refined = 'Rraar rawr refined good',
    broke = 'Rrrowr rawr no cash! RRAAARRGH!',
    novial = 'Rrrowr rawr no vials',
}

-- 🌵 MESCALINE: Desert Cactus of the Ancients
Lang.mescaline = {
    pick = "Rrrowr rawr cactus",
    dry = 'Rraar rawr cactus sun',
    nocactus = 'Rrrowr rawr no cactus',
    eat = 'Rrrowr rawr eat cactus'
}

-- ✨ METH: Fire Dust of the Northern Clans
Lang.meth = {
    inside = 'Rrrowr rawr already full',
    increaseheat = 'Rraar rawr heat up',
    mission = 'Rrrowr rawr car marked',
    ace = 'Rrrowr rawr got acetone',
    eph = 'Rrrowr rawr got ephedrine',
    mix = 'Rraar rawr mix dust',
    nobag = 'Rrrowr rawr no bags',
    act = 'Rrrowr rawr already task',
}

-- 💊 OXY: Healing Dust of the Elders
Lang.oxy = {
    truck = 'Rrrowr rawr truck here',
    cantcarry = 'Rrrowr rawr too heavy',
    hand = 'Rrrowr rawr hand over',
    empty = 'Rrrowr rawr empty hands? RRAAARRGH!',
    broke = 'Rrrowr rawr no cash! RRAAARRGH!',
    hot = 'Rrrowr rawr car hot! Dump!',
    next = 'Rrrowr rawr go next'
}

-- 🩺 PHARMA: Medicine of the Healers
Lang.Pharma = {
    notems = 'Rrrowr rawr not healer',
    write = 'Rrrowr rawr write script',
    fill = 'Rrrowr rawr fill script',
    open = 'Rrrowr rawr open bottle',
    pills = 'Rrrowr rawr got pills!',
    no = 'Rrrowr rawr no script'
}

-- 🍄 SHROOMS: Forest Spirits' Gift
Lang.Shrooms = {
    pick = 'Rrrowr rawr pick mushie',
    eat = 'Rrrowr rawr eat mushie',
    trip = 'Rrrowr rawr good trip!'
}

-- 🌿 WEED: Green Gift of the Trees
Lang.Weed = {
    pick = 'Rrrowr rawr harvest weed',
    busy = 'Rrrowr rawr already drying',
    canna = 'Rrrowr rawr make butter',
    brown = 'Rrrowr rawr make brownie',
    cook = 'Rrrowr rawr make cookie',
    Choc = 'Rrrowr rawr make chocolate',
    muff = 'Rrrowr rawr make muffin',
    stovehot = 'Rrrowr rawr stove hot! Wait!',
    shat = 'Rrrowr rawr make shatter',
    roll = 'Rrrowr rawr roll blunt',
    wait = 'Rrrowr rawr wait drive',
    take = 'Rrrowr rawr take weed',
    nodry = 'Rrrowr rawr need wet weed',
    noweed = 'Rrrowr rawr no weed? RRAAARRGH!',
    noshat = 'Rrrowr rawr need shatter',
    notorch = 'Rrrowr rawr need fire stick'
}

-- 💊 XTC: Sacred Pill of the Dance Clans
Lang.xtc = {
    out = 'Rrrowr rawr press out',
    pressing = 'Rrrowr rawr pressing pills',
    raw = 'Rrrowr rawr make raw xtc',
    mdp2p = 'Rrrowr rawr steal mdp2p',
    iso = 'Rrrowr rawr steal iso',
    fail = 'Rrrowr rawr circle not hard!',
    pickup = 'Rrrowr rawr pick up press',
    stamp = 'Rrrowr rawr stamp %s pills',
    buyp = "Rrrowr rawr buy press",
    cash = 'Rrrowr rawr need 20k cash',
    press = {
        title = {single = 'Rrrowr rawr single', dual = 'Rrrowr rawr dual', triple = 'Rrrowr rawr triple', quad = 'Rrrowr rawr quad'},
        des = {
            single = 'Rrrowr rawr buy single press 20k',
            dual = 'Rrrowr rawr 20 unstamped and press',
            triple = 'Rrrowr rawr 50 unstamped and press',
            quad = 'Rrrowr rawr 150 unstamped and press'
        }
    }
}

-- 💼 WHOLESALE: Great Trade of the Clans
Lang.Wholesale = {
    al = 'Rrrowr rawr already deliver',
    na = 'Rrrowr rawr no answer'
}
return Lang