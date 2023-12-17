local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('md-drugs:client:consumedrugs', function(itemName)
    QBCore.Functions.Progressbar("use_lsd", "Have Fun!", 1750, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_suicide",
        anim = "pill",
        flags = 49,
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerEvent("evidence:client:SetStatus", "widepupils", 300)
        if itemName == "white_playboys" or itemName == "white_playboys2" or itemName == "white_playboys3" or itemName == "white_playboys4" or
            itemName == "blue_playboys" or itemName == "blue_playboys2" or itemName == "blue_playboys3" or itemName == "blue_playboys4" or
            itemName == "red_playboys" or itemName == "red_playboys2" or itemName == "red_playboys3" or itemName == "red_playboys4" or
            itemName == "orange_playboys" or itemName == "orange_playboy2s" or itemName == "orange_playboys3" or itemName == "orange_playboys4" or
            itemName == "white_aliens" or itemName == "white_aliens2" or itemName == "white_aliens3" or itemName == "white_aliens4" or
            itemName == "blue_aliens" or itemName == "blue_aliens2" or itemName == "blue_aliens3" or itemName == "blue_aliens4" or
            itemName == "red_aliens" or itemName == "red_aliens3" or itemName == "red_aliens2" or itemName == "red_aliens4" or
            itemName == "orange_aliens" or itemName == "orange_aliens2" or itemName == "orange_aliens3" or itemName == "orange_aliens4" or
            itemName == "white_pl" or itemName == "white_pl2" or itemName == "white_pl3" or itemName == "white_pl4" or
            itemName == "blue_pl" or itemName == "blue_pl2" or itemName == "blue_pl3" or itemName == "blue_pl4" or
            itemName == "red_pl" or itemName == "red_pl2" or itemName == "red_pl3" or itemName == "red_pl4" or
            itemName == "orange_pl" or itemName == "orange_pl2" or itemName == "orange_pl3" or itemName == "orange_pl4" or
            itemName == "white_trolls" or itemName == "white_trolls2" or itemName == "white_trolls3" or itemName == "white_trolls4" or
            itemName == "blue_trolls" or itemName == "blue_trolls2" or itemName == "blue_trolls3" or itemName == "blue_trolls4" or
            itemName == "red_trolls" or itemName == "red_trolls2" or itemName == "red_trolls3" or itemName == "red_trolls4" or
            itemName == "orange_trolls" or itemName == "orange_trolls2" or itemName == "orange_trolls3" or itemName == "orange_trolls4" or
            itemName == "white_cats2" or itemName == "white_cats3" or itemName == "white_cats4" or itemName == "white_cats" or
            itemName == "blue_cats" or itemName == "blue_cats3" or itemName == "blue_cats2" or itemName == "blue_cats4" or
            itemName == "red_cats" or itemName == "red_cats2" or itemName == "red_cats3" or itemName == "red_cats4" or
            itemName == "orange_cats" or itemName == "orange_cats2" or itemName == "orange_cats3" or itemName == "orange_cats4" then
            AlienEffect()
        elseif itemName == "cupoflean" or itemName == "cupofdextro" or itemName == "baggedcracked" or itemName == "baggedcrackedstagetwo" or
            itemName == "baggedcrackedstagethree" then
            CokeBaggyEffect()
        else
            TrevorEffect()
        end
    end)
end)
