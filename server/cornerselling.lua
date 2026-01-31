
local DrugDeals = {}
local drugsNames = {}
local soldPeds = {}

for k, v in pairs(Config.Cornerselling.Drugs) do
    table.insert(drugsNames, k)
end
GlobalState.DrugNames = drugsNames

GlobalState.MDDrugsLocations = Locations
local RobbedDrugs = {}


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

Bridge.Callback.Register('md-drugs:server:cornerselling:getAvailableDrugs', function(source, ped)
    local src = source
    local rep = getRep(source, 'cornerselling')
    local priceAdjust = rep.price

    local ped = NetworkGetEntityFromNetworkId(ped)
    if not checkDistance(src, GetEntityCoords(ped), 5.0, 'md-drugs:server:cornerselling:getAvailableDrugs') then
        return false
    end

    if soldPeds[src] == nil then
        soldPeds[src] = {}
    end

    if soldPeds[src][ped] then
        return false
    end

    for k, v in pairs(Config.Cornerselling.Drugs) do
        local count = Bridge.Inventory.GetItemCount(src, k)
        if count >= 1 then
            local maths = math.random(1,100)
            
            if maths <= Config.CornerSelling.config.robChance then
                beingRobbed(source, k, count, ped)
                soldPeds[src][ped] = {item = k, amount = count}
                return 'robbed'
            else
                if count > 15 then count = 15 end
                local amount = math.random(1, count)
                local price = (math.random(Config.Cornerselling.Drugs[k]['min'], Config.Cornerselling.Drugs[k]['max']) * amount) * priceAdjust
                DrugDeals[src] = {item = k, amount = amount, price = math.floor(price), ped = ped}
                soldPeds[src][ped] = DrugDeals[src]
                return DrugDeals[src]
            end
        end
    end
    return false
end)

Bridge.Callback.Register('md-drugs:server:hasDrugs', function(source)
    for k, v in pairs(Config.Cornerselling.Drugs) do
        if Bridge.Inventory.HasItem(source, k) then
            return true
        end
    end
    return false
end)

local function csCheck(src, item, amount, price)
    local isIn = false
    for k, v in pairs (Config.Cornerselling.Drugs) do
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
    if not checkDistance(src, GetEntityCoords(ped), 5.0, 'md-drugs:server:sellCornerDrugs') then
        return
    end

    if not soldPeds[src] or not soldPeds[src][ped] then
        return
    end

    if not Bridge.Inventory.RemoveItem(src, item, amount) then
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Cornerselling.notEnough'), 'error')
        DrugDeals[src] = nil
        return
    end

    AddRep(src, 'cornerselling', Config.Cornerselling.Drugs[item].rep * amount)
    DrugDeals[src] = nil

    if Config.CornerSelling.config.MarkedBills then
        Bridge.Inventory.AddItem(src, 'markedbills', price, nil, {worth = price})
        return
    end
    if Config.CornerSelling.config.CustomItem ~= '' then
        Bridge.Inventory.AddItem(src, Config.CornerSelling.config.CustomItem, price)
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
    if not checkDistance(src, GetEntityCoords(ped), 5.0, 'md-drugs:server:getBackRobbed') then
        return
     end
    getDrugBack(src, tabl.item, tabl.amount)
    RobbedDrugs[src] = nil
end)


RegisterCommand('cornersell', function(source, args, raw)
    local src = source
    if #Bridge.Framework.GetPlayersByJob('police') < Config.CornerSelling.config.policeRequired then
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('Cornerselling.notEnoughCops', Config.CornerSelling.config.policeRequired - #Bridge.Framework.GetPlayersByJob('police')), 'error')
        return
    end
    TriggerClientEvent('md-drugs:client:cornerselling', src)
end, false)

TriggerClientEvent('chat:addSuggestion', -1, '/cornersell', Bridge.Language.Locale('Cornerselling.comDes'))

RegisterServerEvent('md-drugs:server:cornerselling:stop', function()
    local src = source
    if DrugDeals[src] then
        DrugDeals[src] = nil
    end
end)