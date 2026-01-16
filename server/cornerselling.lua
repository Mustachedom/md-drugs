
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
local soldPeds = {}
for k, v in pairs(Drugs) do
    table.insert(drugsNames, k)
end
GlobalState.DrugNames = drugsNames

local RobbedDrugs = {}
local cornsellConfig = {
    MarkedBills = false, -- if you want to use qb markedbills for selling set to true, if you want to use a custom item or cash set to false
    CustomItem = '', -- If you want to use a custom item for selling, put the item name here, if not leave it blank '' 
    --- if MarkedBills is false and CustomItem is blank it will pay cash
    policeRequired = 0, -- if you want cops to be required to sell set this to a number above 0
    robChance = 1, -- Chance To Be Robbed 1 = 1%
}

local function beingRobbed(source, item, amount, ped)
    local src = source
    Bridge.Inventory.RemoveItem(src, item, amount)
    Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Cornerselling.gotRobbed'), 'error')
    RobbedDrugs[src] = {item = item, amount = amount, ped = ped}
    return true
end

local function getDrugBack(source, item, amount)
    local src = source
    if RobbedDrugs[src] then
        if RobbedDrugs[src].item == item and RobbedDrugs[src].amount == amount then
            Bridge.Inventory.AddItem(src, item, amount)
            Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Cornerselling.gotBack'), 'success')
            RobbedDrugs[src] = nil
            return true
        end
    end
end

local function getLoc(src, ped)
    local coords, peds = GetEntityCoords(GetPlayerPed(src)), GetEntityCoords(ped)
    local dist = #(coords - peds)
    if dist < 5.0 then
        return true
    end
    return false
end
Bridge.Callback.Register('md-drugs:server:cornerselling:getAvailableDrugs', function(source, ped)
    local src = source
    local rep = getRep(source, 'cornerselling')
    local priceAdjust = rep.price
    local ped = NetworkGetEntityFromNetworkId(ped)
    if not getLoc(src, ped) then
        return false
    end
    if soldPeds[src] == nil then
        soldPeds[src] = {}
    end
    if soldPeds[src][ped] then
        return false
    end
    for k, v in pairs(Drugs) do
        local count = Bridge.Inventory.GetItemCount(src, k)
        if count >= 1 then
            local maths = math.random(1,100)
            if maths <= cornsellConfig.robChance then
                beingRobbed(source, k, count, ped)
                soldPeds[src][ped] = {item = k, amount = count}
                return 'robbed'
            else
                if count > 15 then count = 15 end
                local amount = math.random(1, count)
                local price = (math.random(Drugs[k]['min'], Drugs[k]['max']) * amount) * priceAdjust
                DrugDeals[src] = {item = k, amount = amount, price = math.floor(price), ped = ped}
                soldPeds[src][ped] = DrugDeals[src]
                return DrugDeals[src]
            end
        end
    end
    return false
end)

Bridge.Callback.Register('md-drugs:server:hasDrugs', function(source)
    for k, v in pairs(Drugs) do
        if Bridge.Inventory.HasItem(source, k) then
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
    if DrugDeals[src] then
        if DrugDeals[src].item == item and DrugDeals[src].amount == amount and DrugDeals[src].price == price then
            return true
        end
    end
    return false
end

RegisterNetEvent('md-drugs:server:sellCornerDrugs', function(item, amount, price, peds)
    local src = source
    if not csCheck(src, item, amount, price) then
        return
    end
    local ped = NetworkGetEntityFromNetworkId(peds)
    if not getLoc(src, ped) then
        print('not close enough to ped')
        return
    end
    if not soldPeds[src] or not soldPeds[src][ped] then
        print('ped not in soldPeds')
        return
    end
    if not Bridge.Inventory.RemoveItem(src, item, amount) then
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Cornerselling.notEnough'), 'error')
        DrugDeals[src] = nil
        return
    end
    AddRep(src, 'cornerselling', Drugs[item].rep * amount)
    DrugDeals[src] = nil
    if cornsellConfig.MarkedBills then
        Bridge.Inventory.AddItem(src, 'markedbills', price, nil, {worth = price})
        return
    end
    if cornsellConfig.CustomItem ~= '' then
        Bridge.Inventory.AddItem(src, cornsellConfig.CustomItem, price)
        return
    end
    Bridge.Framework.AddAccountBalance(src, 'cash', price)
end)

RegisterNetEvent('md-drugs:server:getBackRobbed', function(peds) 
    local src = source
    local tabl = RobbedDrugs[src]
    if tabl == nil then return end
    local ped = NetworkGetEntityFromNetworkId(peds)
    if ped ~= tabl.ped then return end
    if not getLoc(src, ped) then return end

    getDrugBack(src, tabl.item, tabl.amount)
    RobbedDrugs[src] = nil
end)

ps.registerCommand('cornersell', {
    help = Bridge.Language.Locale('Cornerselling.comDes'),
    params = {
    },
}, function(source, args, raw)
    local src = source
    local jobCount = ps.getJobTypeCount('leo')
    if jobCount < cornsellConfig.policeRequired then
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Catches.noCops'), 'error')
        return
    end
    TriggerClientEvent('md-drugs:client:cornerselling', src)
end)

RegisterServerEvent('md-drugs:server:cornerselling:stop', function()
    local src = source
    if DrugDeals[src] then
        DrugDeals[src] = nil
    end
end)