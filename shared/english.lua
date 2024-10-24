Lang = {}

Lang.targets = {
    coke = {
        pick = 'Pick Cocaine',
        cut = 'Cut Cocaine',
        bag = 'Bag Cocaine',
        enter = 'Enter Building',
        exit = 'Exit Building',
        chop = 'Chop Coca Leaves',
        
    },
    CornerSell = {
        sell = 'Sell %s Of %s For $%s',
        deny = 'Deny Price'
    },
    crack = {
        cook = 'Cook Crack',
        bag = 'Bag Crack'
    },
    Delivery = {
        Deliver = 'Deliver For %s',
        open = 'Open %s Shop',
        hand = 'Hand Over'
    },
    heroin = {
        pick = 'Pick Poppies',
        up = 'Pick Up Table',
        dry = 'Dry Poppies',
        cut = 'Cut Heroin',
        cook = 'Cook Heroin',
        kit = 'Buy Heroin Lab Kit',
        clean = 'Clean Table',
        fill = 'Fill Syringe',
        vial = 'Make Vial',
    },
    lean = {
        git = 'Get Task'
    },
    lsd = {
        buy = 'Buy LSD Lab Kit',
        heat = 'Heat Liquid',
        refine = 'Refine Quality',
        paper = 'Make Tab Paper',
        back = 'Pick Up Lab Kit',
        dab = 'Dab LSD on sheets',
        clean = 'Clean Table',
        lys = 'Steal Lysergic Acid',
        die = 'Steal Diethylamide',
        buyt = 'Buy Tabs',
    },
    mescaline = {
        pick = 'Pick Cactus',
        dry = 'Dry Out Cactus',
    },
    meth = {
        bag = 'Bag Up Meth',
        enter = 'Enter Buidling',
        exit = 'Exit Building',
        cook = 'Cook Meth',
        tray = 'Grab Tray',
        box = 'Box Up Meth',
        adjust = 'Adjust Temperature',
        eph = 'Steal Ephedrine',
        ace = 'Steal Acetone',
        mission = 'Get Mission'
    },
    oxy = {
        pack = 'Get Oxy Package',
        talk = 'Talk To Buyer',
        pay = 'Pay For Truck',
    },
    pha = {
        fill = 'Fill Prescription',
    },
    shrooms = {
        pick = 'Pick Shrooms',
    },
    xtc = {
        iso = 'Steal Isosafrole',
        mdp = 'Steal MDP2P',
        raw = 'Make Raw XTC',
        press = 'Buy XTC Press',
        stamp = 'Stamp Pills',
        make = 'Make XTC',
        pick = 'Pick Up Press',
    },
    weed = {
        pick = 'Pick Weed',
        dry = 'Dry Weed',
        dpick = 'Pick Dried Weed',
        butt = 'Open Edible Menu',
        oil = 'Make Oil'
    },
    Wholesale = {
        talk = 'Talk To Buyer'
    },
    
}

Lang.Coke = { 
    -- client side progressbars
    picking = "Picking Leaves",
    makepow = 'Chopping Leaves Into A Powder',
    cutting = 'Cutting Coke With Baking Soda',
    bagging = "Bilbo Baggins This Bitch",
    -- end progressbars
    cut = "You Cut Some Coke",
    nocutcoke = "You Cant Cut Coke With No Coke Idiot",
    bagcoke = "You Bagged Up Coke",
    nobagcoke = "You Cant Bag Up Coke Without Coke Idiot",
}
Lang.Crack = {
    --client side
    cookcrack = "Cooking Some Crack",
    bagcrack = 'Bilbo Baggin This Bitch',
    -- server
    makecrack = 'Nice Crack',
    nocoke = 'You Cant Make This Without Coke'
}
Lang.Cornerselling = {
    -- client side notifys
    inveh = 'STRANGER DANGER, I WONT GET IN THE CAR WITH YOU',
    toofar = "To Far From Your Corner Homie",
    selling = 'Selling %s For $%s',
    deny = "Fuck That Offer",
    start = "Get That Paper",
    stop = "Lazy Ass Cant Even Sell Drugs",
    nodrugs = "What You Gonna sell? Air?",
    notcops = "Not Enough Cops",
    -- end client side notifys
    -- progressbars
    sell = "Selling Drugs",
}
Lang.Delivery = {
    -- client side
    emailn = 'Not A Drug Dealer',
    emailsub = 'Hurry Up And Get The Package To The Buyer',
    emailcon = 'I Swear To God If It Doesnt Get There I Will Tell Your Mom You Said Fuck Just Bring %s Of %s',
    search = "Searching For A Delivery ...",
    none = "Nothing Close By",
    busy = "You Havent Even Finished The One I Told You Too",
    found = "Marked On Your Map",
    already = "Already Deliverying",
    checkrep = "Current Dealer Rep: ",
    -- progressbars
    pack = 'Handing Off Package',
    -- end client side
}

Lang.Heroin = {
    --client
    pick = " Picking Poppies Up",
    tableout = 'You Already Have A Table Out',
    dryout = "Drying Out Poppies",
    cutting = "Cutting Heroin With Baking Soda",
    secret = "SHHHHHHHHH",
    table = "Placing Table Down",
    success = "Heated Heroin Properly",
    clean = 'Cleaning Heroin Table',
    needles = 'Filling Syringe',
    pickup = 'Picking Up The Heroin Table',
    -- 
    cutheroin = 'You Made Some Cut Heroin',
    noheroin = "How Can You Cut Heroin Without Heroin Idiot",
    vial = 'You Made A Vial Of Heroin',
    novial = "How Can You Make Heroin Vials Without Heroin Idiot",
    fail = 'You Over Heated Them Idiot',
    fill = 'Filled The Syringe',
    nofill = 'How Are You Going To Fill Needles Of Heroin Without Heroin'
}
Lang.Lean = {
    marked = ' Car Has Been Marked On Your Map',
    lean = 'You Got Purple Lean',
    dextro = ' You Got Red Dextro',
    act = 'You Already Have A Lean Task',
}

Lang.lsd = {
    steallys = 'Stealing Lysergic Acid',
    stealdie = 'Stealing Lysergic Acid',
    tableout = 'You Already Have A Table Out',
    tablepack = 'Packing Table Up',
    heat = 'Heating Up Liquids',
    clean = 'Cleaning The Table',
    refine = 'Refining The Quality',
    dip = 'Dipping LSD On The Paper',
    buypaper = 'Buying Tab Paper',
    buykit = 'Buying Lab Kit',
    place = 'Placing Table Down',
    hav = 'You Already Have A Table',
    -- server
    lys = 'You Got Lysergic Acid',
    die = 'You Got Diethylamide',
    cleaned = 'You Cleaned It Perfectly',
    madelsd = 'You Made LSD!',
    failed = 'You Over Heated Them Idiot',
    refined = 'You Refined Them!',
    broke = 'Your Broke Ass Cant Afford these!',
    novial = 'No LSD Vials Idiot',
}
Lang.mescaline = {
    pick = "Picking Cactus",
    dry = 'Drying Out Cactus',
    nocactus = 'No Cactus Bulbs',
    eat = 'eating mescaline'
}

Lang.meth = {
    inside = 'Stuff Inside Already',
    increaseheat = 'Increasing Heat',
    mission = 'Car Has Been Marked On Your Map',
    ace = 'You Got Some Acetone',
    eph = 'You Got Some Ephedrine',
    mix = 'Adding Things To The Mix',
    nobag = 'No Bags',
    act = 'You Already Have A Meth Task',
}

Lang.oxy = {
    truck = 'Your Truck Is Here',
    cantcarry = 'You Aint That Strong, You Can Only Carry One',
    hand = 'Handing Over oxy',
    empty = 'You Cant Be Empty Handed Idiot',
    broke = 'Your Broke Ass Cant Afford This',
    hot = 'Car Is Hot Dump It Now',
    next = 'Get To the Next Location'
}

Lang.Pharma = {
    notems = 'You Are Not A Medical Person',
    write = 'Writing Prescription',
    fill = 'Filling Prescription',
    open = 'Opening Bottle',
    pills = 'You Got Some Pills!',
    no = 'You Dont Have A Prescription'
}

Lang.Shrooms = {
    pick = 'Picking Shrooms',
    eat = 'Eating Shrooms',
    trip = 'Have A Good Trip!'
}

Lang.Weed = {
    pick = 'Harvesting Weed',
    busy = 'Already Drying One Out',
    canna = 'Making Canna-butter',
    brown = 'Making Special Brownies',
    cook = 'Making Special Cookies',
    Choc = 'Making Special Chocolate',
    muff = 'Making Special Muffin',
    stovehot = 'Stove Is Too Hot Wait 30 Seconds To Cool Down',
    shat = 'Making Shatter',
    roll = 'Rolling Blunts',
    wait = 'Wait A Little Bit For To Drive',
    take = 'Taking Down The Weed',
    -- 
    nodry = 'You Need Wet Cannabis To Dry',
    noweed = 'Cant Roll A Blunt With Air',
    noshat = 'You Need Shatter To Do A Dab',
    notorch = 'You Need A butane Torch'
}

Lang.xtc = {
    out = 'You Have A Press Out Already',
    pressing = 'Pressing Pills',
    raw = 'Making Raw XTC',
    mdp2p = 'Stealing MDP2P',
    iso = 'Stealing Isosafrole',
    fail = 'Dude Its A Circle Not Rocket Science',
    pickup = 'Picking Up The Press',
    stamp = 'Stamping %s Pills',
    buyp = "Buying Press",
    --
    cash = 'I need 20k In Cash',
    press = {
        title = {single = 'Single Press', dual = 'Dual Press', triple = 'Triple Press', quad = 'Quad Press'},
        des = {single ='Buy a single press for 20k', dual = '20 of each unstamped single stack pill and your single press ', 
            triple = '50 of each unstamped dual stack pill and your dual press ', quad = '150 of each unstamped Triple stack pill and your triple press'
        }
    }
}

Lang.Wholesale = {
    al = 'Already Called Someone!'
}