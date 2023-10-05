local QBCore = exports['qb-core']:GetCoreObject()
local drugs = { "cokebaggystagetwo", "cokebaggystagethree", "heroin_ready", "heroin_readystagetwo", "heroin_readystagethree", "baggedcracked", "baggedcrackedstagetwo", "baggedcrackedstagethree", "white_playboys", "white_playboys2", "white_playboys3", "white_playboys4","blue_playboys", "blue_playboys2", "blue_playboys3", "blue_playboys4", "red_playboys", "red_playboys2", "red_playboys3", "red_playboys4", "orange_playboys", "orange_playboy2s", "orange_playboys3", "orange_playboys4", "white_aliens", "white_aliens2", "white_aliens3", "white_aliens4", "blue_aliens", "blue_aliens2", "blue_aliens3", "blue_aliens4", "red_aliens", "red_aliens3", "red_aliens2", "red_aliens4", "orange_aliens", "orange_aliens2", "orange_aliens3", "orange_aliens4", "white_pl", "white_pl2", "white_pl3", "white_pl4","blue_pl", "blue_pl2", "blue_pl3", "blue_pl4", "red_pl", "red_pl2", "red_pl3", "red_pl4", "orange_pl", "orange_pl2", "orange_pl3", "orange_pl4", "white_trolls", "white_trolls2", "white_trolls3", "white_trolls4","blue_trolls", "blue_trolls2", "blue_trolls3", "blue_trolls4", "red_trolls", "red_trolls2", "red_trolls3", "red_trolls4", "orange_trolls", "orange_trolls2", "orange_trolls3", "orange_trolls4", "white_cats2", "white_cats3", "white_cats4", "white_cats","blue_cats", "blue_cats3", "blue_cats2", "blue_cats4", "red_cats", "red_cats2", "red_cats3", "red_cats4", "orange_cats", "orange_cats2", "orange_cats3", "orange_cats4" }

for k, v in pairs (drugs) do QBCore.Functions.CreateUseableItem(v, function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)
	if TriggerClientEvent("md-drugs:client:consumedrugs", source, item.name) then
		Player.Functions.RemoveItem(item.name, 1) 
	end
end)
end


