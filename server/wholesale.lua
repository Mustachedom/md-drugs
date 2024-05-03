local QBCore = exports['qb-core']:GetCoreObject()
local coke = { "cokebaggy", "cokebaggystagethree", "cokebaggystagetwo"}
local crack = {"baggedcracked", "baggedcrackedstagetwo", "baggedcrackedstagethree"}
local lsd = {'smiley_tabs', 'yinyang_tabs', 'wildcherry_tabs', 'pineapple_tabs', 'bart_tabs', 'gratefuldead_tabs'}
local heroin = {'heroin_ready', 'heroin_readystagetwo', 'heroin_readystagethree'}
local xtc = {"white_playboys",  "white_playboys2",  "white_playboys3",  "white_playboys4", "blue_playboys",  "blue_playboys2",  "blue_playboys3",  "blue_playboys4",  "red_playboys",  "red_playboys2",  "red_playboys3",  "red_playboys4",  "orange_playboys",  "orange_playboy2s",  "orange_playboys3",  "orange_playboys4",  "white_aliens",  "white_aliens2",  "white_aliens3",  "white_aliens4",  "blue_aliens",  "blue_aliens2",  "blue_aliens3",  "blue_aliens4",  "red_aliens",  "red_aliens3",  "red_aliens2",  "red_aliens4",  "orange_aliens",  "orange_aliens2",  "orange_aliens3",  "orange_aliens4",  "white_pl",  "white_pl2",  "white_pl3",  "white_pl4", "blue_pl",  "blue_pl2",  "blue_pl3",  "blue_pl4",  "red_pl",  "red_pl2",  "red_pl3",  "red_pl4",  "orange_pl",  "orange_pl2",  "orange_pl3",  "orange_pl4",  "white_trolls",  "white_trolls2",  "white_trolls3",  "white_trolls4", "blue_trolls",  "blue_trolls2",  "blue_trolls3",  "blue_trolls4",  "red_trolls",  "red_trolls2",  "red_trolls3",  "red_trolls4",  "orange_trolls",  "orange_trolls2",  "orange_trolls3",  "orange_trolls4",  "white_cats2",  "white_cats3",  "white_cats4",  "white_cats", "blue_cats",  "blue_cats3",  "blue_cats2",  "blue_cats4",  "red_cats",  "red_cats2",  "red_cats3",  "red_cats4",  "orange_cats",  "orange_cats2",  "orange_cats3",  "orange_cats4" }

QBCore.Functions.CreateUseableItem("cokeburner", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
		TriggerClientEvent("md-drugs:client:GetLocation", src, 'coke', "Bring Me All The Coke You Have")
end)
 
RegisterServerEvent('md-drugs:server:wholesalecoke', function()	
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local price = math.random(Config.Wcoke.min, Config.Wcoke.max)
	
    for k, v in pairs(coke) do
        local item = Player.Functions.GetItemByName(v)

        if item and item.amount > 0 then
            local removed = Player.Functions.RemoveItem(v, item.amount)
            Player.Functions.AddMoney("cash", item.amount * price)
			Notifys("You received " .. item.amount * price .. "  Dollars!" , "success")
        end
    end
end)


QBCore.Functions.CreateUseableItem("crackburner", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	
	TriggerClientEvent("md-drugs:client:GetLocation", src, 'crack', "Bring Me All The Crack You Have")
end)

RegisterServerEvent('md-drugs:server:wholesalecrack', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local price = math.random(Config.Wcrack.min, Config.Wcrack.max)
	
    for k, v in pairs(crack) do
        local item = Player.Functions.GetItemByName(v)
        if item and item.amount > 0 then
            local removed = Player.Functions.RemoveItem(v, item.amount)
            Player.Functions.AddMoney("cash", item.amount * price)
			Notifys("You received " .. item.amount * price .. "  Dollars!" , "success")        
        end
    end
end)
----------------- lsd

QBCore.Functions.CreateUseableItem("lsdburner", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	
	TriggerClientEvent("md-drugs:client:GetLocation", src, 'lsd', "Bring Me All The lsd You Have")
    
end)

RegisterServerEvent('md-drugs:server:wholesalelsd', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local price = math.random(Config.Wlsd.min, Config.Wlsd.max)
	
    for k, v in pairs(lsd) do
        local item = Player.Functions.GetItemByName(v)

        if item and item.amount > 0 then
            local removed = Player.Functions.RemoveItem(v, item.amount)
            Player.Functions.AddMoney("cash", item.amount * price)
			Notifys("You received " .. item.amount * price .. "  Dollars!" , "success")
        end
    end
end)
----------------- heroin

QBCore.Functions.CreateUseableItem("heroinburner", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	
	TriggerClientEvent("md-drugs:client:GetLocation", src, 'heroin', "Bring Me All The Heroin You Have")
end)

RegisterServerEvent('md-drugs:server:wholesaleheroin', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local price = math.random(Config.WHeroin.min, Config.WHeroin.max)
	
    for k, v in pairs(heroin) do
        local item = Player.Functions.GetItemByName(v)

        if item and item.amount > 0 then
            local removed = Player.Functions.RemoveItem(v, item.amount)
            Player.Functions.AddMoney("cash", item.amount * price)
			Notifys("You received " .. item.amount * price .. "  Dollars!" , "success")
           
        end
    end
end)
---- xtc
QBCore.Functions.CreateUseableItem("xtcburner", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
	
	TriggerClientEvent("md-drugs:client:GetLocation", src, 'xtc', "Bring Me All The xtc You Have")
end)

RegisterServerEvent('md-drugs:server:wholesalextc', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local price = math.random(Config.WXTC.min, Config.WXTC.max)
	
    for k, v in pairs(xtc) do
        local item = Player.Functions.GetItemByName(v)

        if item and item.amount > 0 then
            local removed = Player.Functions.RemoveItem(v, item.amount)
            Player.Functions.AddMoney("cash", item.amount * price)
            Notifys("You received " .. item.amount * price .. "  Dollars!" , "success")
        end
    end
end)


RegisterServerEvent('md-drugs:server:RemoveBurner', function(item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if item == 'coke' then
        if Player.Functions.RemoveItem('cokeburner', 1) then
        else
            DropPlayer(src, 'How Did You Trigger The Event Without The Item?')    
        end    
    elseif item == 'crack' then 
        if Player.Functions.RemoveItem('crackburner', 1) then
        else
            DropPlayer(src, 'How Did You Trigger The Event Without The Item?')    
        end     
    elseif item == 'heroin' then
        if Player.Functions.RemoveItem('heroinburner', 1) then
        else
            DropPlayer(src, 'How Did You Trigger The Event Without The Item?')    
        end     
    elseif item == 'lsd' then
        if Player.Functions.RemoveItem('lsdburner', 1) then
        else
            DropPlayer(src, 'How Did You Trigger The Event Without The Item?')    
        end     
    elseif item == 'xtc' then
        if Player.Functions.RemoveItem('xtcburner', 1) then
        else
            DropPlayer(src, 'How Did You Trigger The Event Without The Item?')    
        end      
    end          
end)






