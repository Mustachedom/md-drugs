Consumables = {}
Consumables.defaulttime = 4000
Consumables.defaultanim = 'pflag2'
Consumables.defaultprogresstext = 'Consuming ' -- it will always show the label of the item being used after what you put here, make sure to keep the space at the end :)
Consumables.defaultstatval = 0
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
Consumables.Items = {
    -- meth
    ["methbags"] =                { time = 4000, effect = 'meth', anim = "smoke", progressbartext = "Smoking ", 
                                    add = {health = -20, stress = -10, speed = 40, strength = 10, thirst = -30}},
    -- coke
    ["cokebaggy"] =               {  anim = 'smell', time = 1000, effect = 'coke', progressbartext = "Sniffing ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["cokebaggystagetwo"] =       {  anim = 'smell', time = 1000, effect = 'coke', progressbartext = "Sniffing ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["cokebaggystagethree"] =     {  anim = 'smell', time = 1000, effect = 'coke', progressbartext = "Sniffing ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    -- heroin
    ["heroin_ready"]        =     {  anim = 'shootup', time = 4000, effect = 'ecstacy', progressbartext = "Shooting Up ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["heroin_readystagetwo"] =    {  anim = 'shootup', time = 1000, effect = 'ecstacy', progressbartext = "Shooting Up ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["heroin_readystagethree"] =  {  anim = 'shootup', time = 1000, effect = 'ecstacy', progressbartext = "Shooting Up ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    -- crack
    ["baggedcracked"] =           {  anim = 'smell', time = 1000, effect = 'coke', progressbartext = "Shooting Up ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["baggedcrackedstagetwo"] =   {  anim = 'smell', time = 1000, effect = 'coke', progressbartext = "Shooting Up ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["baggedcrackedstagethree"] = {  anim = 'smell', time = 1000, effect = 'coke', progressbartext = "Shooting Up ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    -- xtc
    ["white_playboys"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["white_playboys2"] =         {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["white_playboys3"] =         {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["white_playboys4"] =         {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["blue_playboys"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["blue_playboys2"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["blue_playboys3"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["blue_playboys4"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["red_playboys"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["red_playboys2"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["red_playboys3"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["red_playboys4"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["orange_playboys"] =         {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["orange_playboy2s"] =        {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["orange_playboys3"] =        {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["orange_playboys4"] =        {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["white_aliens"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["white_aliens2"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["white_aliens3"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["white_aliens4"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["blue_aliens"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["blue_aliens2"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["blue_aliens3"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["blue_aliens4"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["red_aliens"] =              {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["red_aliens3"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["red_aliens2"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["red_aliens4"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["orange_aliens"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["orange_aliens2"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["orange_aliens3"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["orange_aliens4"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["white_pl"] =                {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["white_pl2"] =               {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["white_pl3"] =               {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["white_pl4"] =               {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["blue_pl"] =                 {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["blue_pl2"] =                {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["blue_pl3"] =                {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["blue_pl4"] =                {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["red_pl"] =                  {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["red_pl2"] =                 {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["red_pl3"] =                 {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["red_pl4"] =                 {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["orange_pl"] =               {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["orange_pl2"] =              {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["orange_pl3"] =              {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["orange_pl4"] =              {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["white_trolls"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["white_trolls2"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["white_trolls3"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["white_trolls4"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["blue_trolls"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["blue_trolls2"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["blue_trolls3"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["blue_trolls4"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["red_trolls"] =              {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["red_trolls2"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["red_trolls3"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["red_trolls4"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["orange_trolls"] =           {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["orange_trolls2"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["orange_trolls3"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["orange_trolls4"] =          {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["white_cats"] =              {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["white_cats2"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["white_cats3"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["white_cats4"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["blue_cats"] =               {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["blue_cats3"] =              {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["blue_cats2"] =              {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["blue_cats4"] =              {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["red_cats"] =                {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["red_cats2"] =               {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}},
    ["red_cats3"] =               {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["red_cats4"] =               {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["orange_cats"] =             {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -10, speed = 10, strength = 10, thirst = 2}},
    ["orange_cats2"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -13, speed = 13, strength = 13, thirst = 2}}, 
    ["orange_cats3"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -17, speed = 17, strength = 17, thirst = 2}},
    ["orange_cats4"] =            {  anim = 'edible', time = 1000, effect = 'ecstacy', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    -- weed
    ["specialbrownie"] =          {  anim = 'edible',  effect = 'alien', progressbartext = "Eating ", add = {hunger = 10}},
    ["specialcookie"] =           {  anim = 'edible',  effect = 'alien', progressbartext = "Eating ", add = {hunger = 10}},
    ["specialchocolate"] =        {  anim = 'edible',  effect = 'alien', progressbartext = "Eating ", add = {hunger = 10}},
    ["specialmuffin"] =           {  anim = 'edible',  effect = 'alien', progressbartext = "Eating ", add = {hunger = 10}},
    ["blunt"] =                   {  anim = 'smokeweed', effect = 'alien', progressbartext = "Smoking ", add = {hunger = 10}},
    ["dextroblunts"] =            {  anim = 'smokeweed', effect = 'alien', progressbartext = "Smoking ", add = {hunger = 10}},
    ["leanblunts"] =              {  anim = 'smokeweed', effect = 'alien', progressbartext = "Smoking ", add = {hunger = 10}},
    ["chewyblunt"] =              {  anim = 'smokeweed', effect = 'alien', progressbartext = "Smoking ", add = {hunger = 10}},
    -- lean 
    ["cupofdextro"] =             {  anim = 'cup', effect = 'alien', progressbartext = "Drinking ", add = {thirst = 10}},
    ["cupoflean"] =               {  anim = 'cup', effect = 'alien', progressbartext = "Drinking ", add = {thirst = 10}},
    --lsd
    ["smiley_tabs"]  =            {  anim = 'edible', effect = 'trevor', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["wildcherry_tabs"]  =        {  anim = 'edible', effect = 'trevor', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["yinyang_tabs"]  =           {  anim = 'edible', effect = 'trevor', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["pineapple_tabs"] =          {  anim = 'edible', effect = 'trevor', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}}, 
    ["bart_tabs"]  =              {  anim = 'edible', effect = 'trevor', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
    ["gratefuldead_tabs"]  =      {  anim = 'edible', effect = 'trevor', progressbartext = "Taking ",add = {health = 1, stress = -20, speed = 20, strength = 20, thirst = 2}},
}
