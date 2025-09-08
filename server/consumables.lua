
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

local Consumables = {}
Consumables.defaulttime = 4000
Consumables.defaultanim = 'pflag2'
Consumables.defaultprogresstext = 'Consuming ' -- it will always show the label of the item being used after what you put here, make sure to keep the space at the end :)
Consumables.defaultstatval = 0

local Consume = {
    -- meth
methbags =                { time = 4000, effect = 'meth', anim = "smoke", progressbartext = "Injesting",
                                add = {health = -20, stress = -10, speed = 40, strength = 10, thirst = -30}},
cokebaggy =               { anim = 'smell', time = 1000, effect = 'coke', add = { stress = -10 }},
cokebaggystagetwo =       { anim = 'smell', time = 1000, effect = 'coke', add = { stress = -10 }},
cokebaggystagethree =     { anim = 'smell', time = 1000, effect = 'coke', add = { stress = -10 }},
-- heroin
heroin_ready        =     { anim = 'shootup', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
heroin_readystagetwo =    { anim = 'shootup', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
heroin_readystagethree =  { anim = 'shootup', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
-- crack
baggedcracked           = { anim = 'smell', time = 1000, effect = 'coke', add = { stress = -10 }},
baggedcrackedstagetwo   = { anim = 'smell', time = 1000, effect = 'coke', add = { stress = -10 }},
baggedcrackedstagethree = { anim = 'smell', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
-- xtc
white_playboys          = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_playboys2         = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_playboys3         = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_playboys4         = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_playboys           = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_playboys2          = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_playboys3          = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_playboys4          = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_playboys            = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10, hunger = 10 }},
red_playboys2           = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_playboys3           = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_playboys4           = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_playboys         = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_playboy2s        = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_playboys3        = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_playboys4        = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_aliens            = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_aliens2           = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_aliens3           = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_aliens4           = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_aliens             = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_aliens2            = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_aliens3            = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_aliens4            = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_aliens              = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_aliens3             = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_aliens2             = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_aliens4             = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_aliens           = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_aliens2          = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_aliens3          = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_aliens4          = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_pl                = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_pl2               = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_pl3               = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_pl4               = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_pl                 = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_pl2                = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_pl3                = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_pl4                = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_pl                  = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_pl2                 = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_pl3                 = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_pl4                 = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_pl               = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_pl2              = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_pl3              = { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_pl4 =              { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_trolls =            { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_trolls2 =           { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_trolls3 =           { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_trolls4 =           { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_trolls =             { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_trolls2 =            { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_trolls3 =            { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_trolls4 =            { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_trolls =              { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_trolls2 =             { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_trolls3 =             { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_trolls4 =             { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_trolls =           { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_trolls2 =          { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_trolls3 =          { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_trolls4 =          { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_cats2 =             { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_cats3 =             { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_cats4 =             { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
white_cats =              { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_cats =               { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_cats3 =              { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_cats2 =              { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
blue_cats4 =              { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_cats =                { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_cats2 =               { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_cats3 =               { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
red_cats4 =               { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_cats =             { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_cats2 =            { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_cats3 =            { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
orange_cats4 =            { anim = 'edible', time = 1000, effect = 'ecstacy', add = { stress = -10 }},
-- weed
specialbrownie =          { anim = 'edible', effect = 'alien', add = { hunger = 10, stress = -10 }},
specialcookie =           { anim = 'edible', effect = 'alien', add = { hunger = 10, stress = -10 }},
specialchocolate =        { anim = 'edible', effect = 'alien', add = { hunger = 10, stress = -10 }},
specialmuffin =           { anim = 'edible', effect = 'alien', add = { hunger = 10, stress = -10 }},
blunt =                   { anim = 'smokeweed', effect = 'alien', add = { stress = -10 }},
dextroblunts =            { anim = 'smokeweed', effect = 'alien', add = { stress = -10 }},
leanblunts =              { anim = 'smokeweed', effect = 'alien', add = { stress = -10 }},
chewyblunt =              { anim = 'smokeweed', effect = 'alien', add = { stress = -10 }},
-- lean 
cupofdextro =             { anim = 'cup', effect = 'alien', add = { stress = -10 }},
cupoflean =               { anim = 'cup', effect = 'alien', add = { stress = -10 }},
-- lsd
smiley_tabs  =            { anim = 'edible', effect = 'trevor', add = { stress = -10 }},
wildcherry_tabs  =        { anim = 'edible', effect = 'trevor', add = { stress = -10 }},
yinyang_tabs  =           { anim = 'edible', effect = 'trevor', add = { stress = -10 }},
pineapple_tabs =          { anim = 'edible', effect = 'trevor', add = { stress = -10 }},
bart_tabs  =              { anim = 'edible', effect = 'trevor', add = { stress = -10 }},
gratefuldead_tabs  =      { anim = 'edible', effect = 'trevor', add = { stress = -10 }},

-- pharma 
vicodin =                 { anim = 'pill', effect = 'none', add = { health = 20 }},
adderal =                 { anim = 'pill', effect = 'none', add = { stress = -20 }},
morphine =                { anim = 'pill', effect = 'none', add = { health = 40 }},
xanax =                   { anim = 'pill', effect = 'none', add = { stress = -40 }},
}

for k, v in pairs(Consume) do
    ps.createUseable(k, function(source, item)
        if not ps.hasItem(source, k, 1) then return end
        local time = v.time or Consumables.defaulttime
        local effect = v.effect or 0
        local anim = v.anim or Consumables.defaultanim
        local progressbartext = v.progressbartext or Consumables.defaultprogresstext
        local add = v.add or {hunger = 0}
        local done = ps.callback('md-drugs:client:consumedrugs', source, time, effect, anim, progressbartext, add, k)
        if done then
            ps.removeItem(source, k, 1)
        end
    end)
end

RegisterNetEvent('md-drugs:server:updatestatus', function(stat, statval)
    local src = source
    local Player = ps.getPlayer(src)
    if GetResourceState('es_extended') == 'started' then return end
    local hunger, thirst = Player.PlayerData.metadata.hunger, Player.PlayerData.metadata.thirst
    if stat == "thirst" then
        local value = thirst + statval
        Player.Functions.SetMetaData('thirst', value)
        TriggerClientEvent('hud:client:UpdateNeeds', src, hunger, value)
    elseif stat == "hunger" then
        local value = hunger + statval
        Player.Functions.SetMetaData('hunger', value)
        TriggerClientEvent('hud:client:UpdateNeeds', src, value, thirst)
    elseif stat == "stress" then
        local value = Player.PlayerData.metadata.stress + statval
        Player.Functions.SetMetaData('stress', value)
        TriggerClientEvent('hud:client:UpdateStress', src, Player.PlayerData.metadata.stress, value)
    elseif stat == "armor" then
        local value = Player.PlayerData.metadata.armor + statval
        TriggerEvent('hospital:server:SetArmor', value)
        TriggerClientEvent('hud:client:UpdateStress', src, Player.PlayerData.metadata.armor, value)
    end
end)
