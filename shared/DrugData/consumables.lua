local emotes = {
    smoke = {
        dict = "amb@world_human_aa_smoke@male@idle_a",
        clip = "idle_a",
        flag = 49,
        prop = {
            model = 'ng_proc_cigarette01a',
            bone = 28422,
            pos = {0.0, 0.0, 0.0},
            rot = {0.0, 0.0, 0.0}
        }
    },
    smell = {
        dict = 'move_p_m_two_idles@generic',
        clip = 'fidget_sniff_fingers',
    },
    shoot_up = {
        dict = "rcmpaparazzo1ig_4",
        clip = "miranda_shooting_up",
        prop = {
            model = 'prop_syringe_01',
            bone = 18905,
            pos = {0.11, 0.03, 0.0},
            rot = {-124.0, 0.0, 0.0}
        }
    },
    eat = {
        dict = "mp_player_inteat@burger",
        clip = "mp_player_int_eat_burger",
    },
    drink = {
        dict = "mp_player_intdrink",
        clip = "loop_bottle",
    }
}

Config.Consumables = {
    Defaults = {
        time = 4000, -- time in ms
        defaultAnim = {
            dict = "mp_player_inteat@burger",
            clip = "mp_player_int_eat_burger",
        },
        defaultText = 'Consuming ',
        defaultStats = 0
    },
    
}


--[[
    effect options
    alien
    ecstacy
    meth
    coke
    trevor
    none
]]

--[[
add = {} 
health = number -- amount of health to give
stress = number -- number of stress to give 
speed = number -- number of seconds you a fast boi
hunger = number -- number of hunger to fill
thirst = number -- same shit 
strength = number -- how long you are strong boi

]]

Config.Consumables.Consume = {
    methbags =                { time = 4000, effect = 'meth', anim = emotes.smoke, progressbartext = "Injesting",
                                add = {health = -20, stress = -10, speed = 40, strength = 10, thirst = -30}},
cokebaggy =               { anim = emotes.smell, time = 4000, effect = 'coke', add = { stress = -10 }},
cokebaggystagetwo =       { anim = emotes.smell, time = 1000, effect = 'coke', add = { stress = -10 }},
cokebaggystagethree =     { anim = emotes.smell, time = 1000, effect = 'coke', add = { stress = -10 }},
-- heroin
heroin_ready        =     { anim = emotes.shoot_up, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
heroin_readystagetwo =    { anim = emotes.shoot_up, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
heroin_readystagethree =  { anim = emotes.shoot_up, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
-- crack
baggedcracked           = { anim = emotes.smell, time = 1000, effect = 'coke', add = { stress = -10 }},
baggedcrackedstagetwo   = { anim = emotes.smell, time = 1000, effect = 'coke', add = { stress = -10 }},
baggedcrackedstagethree = { anim = emotes.smell, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
-- xtc
white_playboys          = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_playboys2         = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_playboys3         = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_playboys4         = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_playboys           = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_playboys2          = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_playboys3          = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_playboys4          = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_playboys            = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10, hunger = 10 }},
red_playboys2           = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_playboys3           = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_playboys4           = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_playboys         = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_playboy2s        = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_playboys3        = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_playboys4        = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_aliens            = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_aliens2           = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_aliens3           = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_aliens4           = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_aliens             = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_aliens2            = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_aliens3            = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_aliens4            = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_aliens              = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_aliens3             = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_aliens2             = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_aliens4             = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_aliens           = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_aliens2          = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_aliens3          = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_aliens4          = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_pl                = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_pl2               = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_pl3               = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_pl4               = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_pl                 = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_pl2                = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_pl3                = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_pl4                = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_pl                  = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_pl2                 = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_pl3                 = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_pl4                 = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_pl               = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_pl2              = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_pl3              = { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_pl4 =              { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_trolls =            { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_trolls2 =           { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_trolls3 =           { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_trolls4 =           { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_trolls =             { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_trolls2 =            { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_trolls3 =            { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_trolls4 =            { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_trolls =              { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_trolls2 =             { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_trolls3 =             { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_trolls4 =             { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_trolls =           { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_trolls2 =          { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_trolls3 =          { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_trolls4 =          { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_cats2 =             { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_cats3 =             { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_cats4 =             { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_cats =              { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_cats =               { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_cats3 =              { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_cats2 =              { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_cats4 =              { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_cats =                { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_cats2 =               { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_cats3 =               { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_cats4 =               { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_cats =             { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_cats2 =            { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_cats3 =            { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_cats4 =            { anim = emotes.eat, time = 1000, effect = 'ecstacy', add = { stress = -10 }},
-- weed
specialbrownie =          { anim = emotes.eat, effect = 'alien', add = { hunger = 10, stress = -10 }},
specialcookie =           { anim = emotes.eat, effect = 'alien', add = { hunger = 10, stress = -10 }},
specialchocolate =        { anim = emotes.eat, effect = 'alien', add = { hunger = 10, stress = -10 }},
specialmuffin =           { anim = emotes.eat, effect = 'alien', add = { hunger = 10, stress = -10 }},
blunt =                   { anim = emotes.smoke, effect = 'alien', add = { stress = -10 }},
dextroblunts =            { anim = emotes.smoke, effect = 'alien', add = { stress = -10 }},
leanblunts =              { anim = emotes.smoke, effect = 'alien', add = { stress = -10 }},
chewyblunt =              { anim = emotes.smoke, effect = 'alien', add = { stress = -10 }},
-- lean 
cupofdextro =             { anim = emotes.drink, effect = 'alien', add = { stress = -10 }},
cupoflean =               { anim = emotes.drink, effect = 'alien', add = { stress = -10 }},
-- lsd
smiley_tabs  =            { anim = emotes.eat, effect = 'trevor', add = { stress = -10 }},
wildcherry_tabs  =        { anim = emotes.eat, effect = 'trevor', add = { stress = -10 }},
yinyang_tabs  =           { anim = emotes.eat, effect = 'trevor', add = { stress = -10 }},
pineapple_tabs =          { anim = emotes.eat, effect = 'trevor', add = { stress = -10 }},
bart_tabs  =              { anim = emotes.eat, effect = 'trevor', add = { stress = -10 }},
gratefuldead_tabs  =      { anim = emotes.eat, effect = 'trevor', add = { stress = -10 }},

-- pharma 
vicodin =                 { anim = emotes.eat, effect = 'none', add = { health = 20 }},
adderal =                 { anim = emotes.eat, effect = 'none', add = { stress = -20 }},
morphine =                { anim = emotes.eat, effect = 'none', add = { health = 40 }},
xanax =                   { anim = emotes.eat, effect = 'none', add = { stress = -40 }},
}