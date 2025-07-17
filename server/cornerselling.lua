
local DrugDeals = {}
local Drugs = {
    ["weed_white-widow"] =          {rep = 1,min = 15, max = 24 },
    ["weed_og-kush"] =              {rep = 1,min = 15, max = 28 },
    ["weed_skunk"] =                {rep = 1,min = 15, max = 31 },
    ["weed_amnesia"] =              {rep = 1,min = 18, max = 34 },
    ["weed_purple-haze"] =          {rep = 1,min = 18, max = 37},
    ["weed_ak47"] =                 {rep = 1,min = 18, max = 40},
    ["crack_baggy"] =               {rep = 1,min = 18, max = 34},
    ["cokebaggy"] =                 {rep = 1,min = 18, max = 37},
    ["cokebaggystagetwo"] =         {rep = 1,min = 18, max = 40},
    ["cokebaggystagethree"] =       {rep = 1,min = 18, max = 40},
    ["heroin_ready"] =              {rep = 1,min = 18, max = 40},
    ["heroin_readystagetwo"] =      {rep = 1,min = 18, max = 40},
    ["heroin_readystagethree"] =    {rep = 1,min = 18, max = 40},
    ["baggedcracked"] =             {rep = 1,min = 18, max = 40},
    ["baggedcrackedstagetwo"] =     {rep = 1,min = 18, max = 40},
    ["baggedcrackedstagethree"] =   {rep = 1,min = 18, max = 40},
    ["white_playboys"] =            {rep = 1,min = 18, max = 40},
    ["white_playboys2"] =           {rep = 1,min = 18, max = 40},
    ["white_playboys3"] =           {rep = 1,min = 18, max = 40},
    ["white_playboys4"] =           {rep = 1,min = 18, max = 40},
    ["blue_playboys"] =             {rep = 1,min = 18, max = 40},
    ["blue_playboys2"] =            {rep = 1,min = 18, max = 40},
    ["blue_playboys3"] =            {rep = 1,min = 18, max = 40},
    ["blue_playboys4"] =            {rep = 1,min = 18, max = 40},
    ["red_playboys"] =              {rep = 1,min = 18, max = 40},
    ["red_playboys2"] =             {rep = 1,min = 18, max = 40},
    ["red_playboys3"] =             {rep = 1,min = 18, max = 40},
    ["red_playboys4"] =             {rep = 1,min = 18, max = 40},
    ["orange_playboys"] =           {rep = 1,min = 18, max = 40},
    ["orange_playboys2"] =          {rep = 1,min = 18, max = 40},
    ["orange_playboys3"] =          {rep = 1,min = 18, max = 40},
    ["orange_playboys4"] =          {rep = 1,min = 18, max = 40},
    ["white_aliens"] =              {rep = 1,min = 18, max = 40},
    ["white_aliens2"] =             {rep = 1,min = 18, max = 40},
    ["white_aliens3"] =             {rep = 1,min = 18, max = 40},
    ["white_aliens4"] =             {rep = 1,min = 18, max = 40},
    ["blue_aliens"] =               {rep = 1,min = 18, max = 40},
    ["blue_aliens2"] =              {rep = 1,min = 18, max = 40},
    ["blue_aliens3"] =              {rep = 1,min = 18, max = 40},
    ["blue_aliens4"] =              {rep = 1,min = 18, max = 40},
    ["red_aliens"] =                {rep = 1,min = 18, max = 40},
    ["red_aliens2"] =               {rep = 1,min = 18, max = 40},
    ["red_aliens3"] =               {rep = 1,min = 18, max = 40},
    ["red_aliens4"] =               {rep = 1,min = 18, max = 40},
    ["orange_aliens"] =             {rep = 1,min = 18, max = 40},
    ["orange_aliens2"] =            {rep = 1,min = 18, max = 40},
    ["orange_aliens3"] =            {rep = 1,min = 18, max = 40},
    ["orange_aliens4"] =            {rep = 1,min = 18, max = 40},
    ["white_pl"] =                  {rep = 1,min = 18, max = 40},
    ["white_pl2"] =                 {rep = 1,min = 18, max = 40},
    ["white_pl3"] =                 {rep = 1,min = 18, max = 40},
    ["white_pl4"] =                 {rep = 1,min = 18, max = 40},
    ["blue_pl"] =                   {rep = 1,min = 18, max = 40},
    ["blue_pl2"] =                  {rep = 1,min = 18, max = 40},
    ["blue_pl3"] =                  {rep = 1,min = 18, max = 40},
    ["blue_pl4"] =                  {rep = 1,min = 18, max = 40},
    ["red_pl"] =                    {rep = 1,min = 18, max = 40},
    ["red_pl2"] =                   {rep = 1,min = 18, max = 40},
    ["red_pl3"] =                   {rep = 1,min = 18, max = 40},
    ["red_pl4"] =                   {rep = 1,min = 18, max = 40},
    ["orange_pl"] =                 {rep = 1,min = 18, max = 40},
    ["orange_pl2"] =                {rep = 1,min = 18, max = 40},
    ["orange_pl3"] =                {rep = 1,min = 18, max = 40},
    ["orange_pl4"] =                {rep = 1,min = 18, max = 40},
    ["white_trolls"] =              {rep = 1,min = 18, max = 40},
    ["white_trolls2"] =             {rep = 1,min = 18, max = 40},
    ["white_trolls3"] =             {rep = 1,min = 18, max = 40},
    ["white_trolls4"] =             {rep = 1,min = 18, max = 40},
    ["blue_trolls"] =               {rep = 1,min = 18, max = 40},
    ["blue_trolls2"] =              {rep = 1,min = 18, max = 40},
    ["blue_trolls3"] =              {rep = 1,min = 18, max = 40},
    ["blue_trolls4"] =              {rep = 1,min = 18, max = 40},
    ["red_trolls"] =                {rep = 1,min = 18, max = 40},
    ["red_trolls2"] =               {rep = 1,min = 18, max = 40},
    ["red_trolls3"] =               {rep = 1,min = 18, max = 40},
    ["red_trolls4"] =               {rep = 1,min = 18, max = 40},
    ["orange_trolls"] =             {rep = 1,min = 18, max = 40},
    ["orange_trolls2"] =            {rep = 1,min = 18, max = 40},
    ["orange_trolls3"] =            {rep = 1,min = 18, max = 40},
    ["orange_trolls4"] =            {rep = 1,min = 18, max = 40},
    ["white_cats"] =                {rep = 1,min = 18, max = 40},
    ["white_cats2"] =               {rep = 1,min = 18, max = 40},
    ["white_cats3"] =               {rep = 1,min = 18, max = 40},
    ["white_cats4"] =               {rep = 1,min = 18, max = 40},
    ["blue_cats"] =                 {rep = 1,min = 18, max = 40},
    ["blue_cats2"] =                {rep = 1,min = 18, max = 40},
    ["blue_cats3"] =                {rep = 1,min = 18, max = 40},
    ["blue_cats4"] =                {rep = 1,min = 18, max = 40},
    ["red_cats"] =                  {rep = 1,min = 18, max = 40},
    ["red_cats2"] =                 {rep = 1,min = 18, max = 40},
    ["red_cats3"] =                 {rep = 1,min = 18, max = 40},
    ["red_cats4"] =                 {rep = 1,min = 18, max = 40},
    ["orange_cats"] =               {rep = 1,min = 18, max = 40},
    ["orange_cats2"] =              {rep = 1,min = 18, max = 40},
    ["orange_cats3"] =              {rep = 1,min = 18, max = 40},
    ["orange_cats4"] =              {rep = 1,min = 18, max = 40},	
    ["blunts"] =                    {rep = 1,min = 18, max = 40},
    ["leanblunts"] =                {rep = 1,min = 18, max = 40},
    ["dextroblunts"] =              {rep = 1,min = 18, max = 40},
    ["chewyblunt"] =                {rep = 1,min = 18, max = 40},
    ["blunt"] =                     {rep = 1,min = 18, max = 40},
    ["specialchocolate"] =          {rep = 1,min = 18, max = 40},
    ["specialbrownie"] =            {rep = 1,min = 18, max = 40},
    ["specialcookie"] =             {rep = 1,min = 18, max = 40},
    ["specialmuffin"] =             {rep = 1,min = 18, max = 40},
    ["shatter"] =                   {rep = 1,min = 18, max = 40},
    ["ciggie"] =                    {rep = 1,min = 18, max = 40},
    ["methbags"] =                  {rep = 1,min = 18, max = 40},	
    ["driedmescaline"] =            {rep = 1,min = 18, max = 40},
    ["shrooms"] =                   {rep = 1,min = 18, max = 40},
    ["gratefuldead_tabs"] =         {rep = 1,min = 18, max = 40},
    ["bart_tabs"] =                 {rep = 1,min = 18, max = 40},
    ["pineapple_tabs"] =            {rep = 1,min = 18, max = 40},
    ["yinyang_tabs"] =              {rep = 1,min = 18, max = 40},
    ["wildcherry_tabs"] =           {rep = 1,min = 18, max = 40},	
    ["smiley_tabs"] =               {rep = 1,min = 18, max = 40},
    ["cupoflean"] =                 {rep = 1,min = 18, max = 40},
    ["cupofdextro"] =               {rep = 1,min = 18, max = 40},
}

local drugsNames = {}
for k, v in pairs(Drugs) do
    table.insert(drugsNames, k)
end
GlobalState.DrugNames = drugsNames

local robChance = 1 -- Chance To Be Robbed
local RobbedDrugs = {}

local function beingRobbed(source, item, amount, ped)
    local src = source
    local math = math.random(1,100)
    if math <= robChance then
        ps.removeItem(src, item, amount)
        ps.notify(src, 'You Got Robbed Nerd', 'error')
        RobbedDrugs[ps.getIdentifier(source)] = {item = item, amount = amount, ped = ped}
        return true
    else
        return false
    end
end

local function getDrugBack(source, item, amount)
    local src = source
    if RobbedDrugs[ps.getIdentifier(source)] then
        if RobbedDrugs[ps.getIdentifier(source)].item == item and RobbedDrugs[ps.getIdentifier(source)].amount == amount then
            ps.addItem(src, item, amount)
            ps.notify(src, 'You Got Your Drugs Back', 'success')
            RobbedDrugs[ps.getIdentifier(source)] = nil
            return true
        end
    end
end

ps.registerCallback('md-drugs:server:cornerselling:getAvailableDrugs', function(source, ped)
    local Player = ps.getPlayer(source)
    local rep = getRep(source, 'cornerselling')
    if not Player then return nil end
    for k, v in pairs(Drugs) do
        local item = ps.getItemCount(source, k) or 0
        if item >= 1 then
            local maths = math.random(1,100)
            if maths <= robChance then
                beingRobbed(source, k, item, ped)
                return 'robbed'
            else
                if item > 15 then item = 15 end
                local amount = math.random(1, item)
                local price = (math.random(Drugs[k]['min'], Drugs[k]['max']) * amount) * rep.price
                DrugDeals[ps.getIdentifier(source)] = {item = k, amount = amount, price = math.floor(price), ped = ped}     
                return DrugDeals[ps.getIdentifier(source)]
            end
        end
    end
    return false
end)

ps.registerCallback('md-drugs:server:hasDrugs', function(source)
    for k, v in pairs(Drugs) do
        if hasItem(source, k, 1) then
            return true
        end
    end
    return false
end)

local function csCheck(src, item, amount, price)
    local isIn = false
    for k, v in pairs (Drugs) do
        if item == k then
            isIn = true
        end
    end
    if not isIn then return false end

    if DrugDeals[ps.getIdentifier(src)] then
        if DrugDeals[ps.getIdentifier(src)].item == item and DrugDeals[ps.getIdentifier(src)].amount == amount and DrugDeals[ps.getIdentifier(src)].price == price then
            return true
        end
    end
    return false
end

RegisterNetEvent('md-drugs:server:sellCornerDrugs', function(item, amount, price) 
    local src = source
    if not csCheck(src, item, amount, price) then return end
    if not ps.removeItem(src, item, amount) then
        ps.notify(src, 'You Do Not Have Enough Of This Item', 'error')
        DrugDeals[ps.getIdentifier(src)] = nil
        return
    end
    AddRep(src, 'cornerselling', Drugs[item].rep * amount)
    --Log(string.format('%s Sold %s Of %s For A Price Of $%s !', GetName(src),amount, item, price), 'cornerselling')
    DrugDeals[ps.getIdentifier(src)] = nil
    ps.addMoney(src, 'cash', price)
end)

RegisterNetEvent('md-drugs:server:getBackRobbed', function() 
    local tabl = RobbedDrugs[ps.getIdentifier(source)]
    if tabl == nil then return end
    getDrugBack(source, tabl.item, tabl.amount)
    RobbedDrugs[ps.getIdentifier(source)] = nil
end)

lib.addCommand('cornersell', {
    help = 'Sell Things On The Corner',
    params = {
    },
}, function(source, args, raw)
    local src = source
    TriggerClientEvent('md-drugs:client:cornerselling', src)
end)

RegisterServerEvent('md-drugs:server:cornerselling:stop', function()
    local src = source
    if DrugDeals[ps.getIdentifier(src)] then
        DrugDeals[ps.getIdentifier(src)] = nil
    end
end)