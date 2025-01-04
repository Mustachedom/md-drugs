local QBCore = exports['qb-core']:GetCoreObject()
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

lib.callback.register('md-drugs:server:cornerselling:getAvailableDrugs', function(source, cb)
    local Player = getPlayer(source)
    local rep = getRep(source, 'cornerselling')
    if not Player then return nil end
    local type = 0
    for k, v in pairs(Drugs) do
        local item = Player.Functions.GetItemByName(k)
        if item and type == 0 then
            type = type + 1
            Log(GetName(source)  .. ' Allowed To Sell ' .. item.name .. '!' , 'cornerselling')
            local amount = math.random(1,item.amount)
            if amount >= 15 then amount = 15 end
            local price = math.random(Drugs[k]['min'], Drugs[k]['max']) * amount
            local result = math.floor(price * rep.price)
            return item.name, amount, result
        end
    end
    if type == 0 then 
        return 'nothing', 0, 0
    end
end)


RegisterNetEvent('md-drugs:server:sellCornerDrugs', function(item, amount, price)
    local src = source
    local Player = getPlayer(src)
    local isIn = false
    for k, v in pairs (Drugs) do 
        if item == k then 
            isIn = true
        end
    end
    if not isIn then return end
    if RemoveItem(src, item, amount) then
        if QBConfig.MarkedBills then
            local info = {
                worth = price
            }
            Player.Functions.AddItem('markedbills', 1, false, info )
        elseif QBConfig.CustomDirtyMoney then 
            AddItem(src, QBConfig.CustomDirtyMoneyitem, price)
        else
            Player.Functions.AddMoney('cash', price)
        end
        AddRep(src, 'cornerselling', Drugs[item].rep * amount)
        Log(GetName(src)  .. ' Sold ' .. amount .. ' Of ' .. item .. ' For A Price Of ' .. price .. '!' , 'cornerselling')
    end
end)

lib.addCommand('cornersell', {
    help = 'Sell Things On The Corner',
    params = {
    },
}, function(source, args, raw)
    local src = source
    local Player = getPlayer(src)
    Log(GetName(source)  .. ' Used Command cornersell!' , 'cornerselling')
    TriggerClientEvent('md-drugs:client:cornerselling', src)
end)
