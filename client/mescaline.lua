

RegisterNetEvent("md-drugs:client:drymescaline", function()
    if not ItemCheck('cactusbulb')  then return end 
	if not progressbar(Lang.mescaline.dry, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:drymescaline")
end)

RegisterNetEvent("md-drugs:client:takemescaline", function()
    local chance, chance2 = math.random(1,100), math.random(1,100)
    local weapon = ''
    if chance2 == 100 then weapon = 'weapon_rpg' else weapon = 'weapon_flaregun' end
    if not progressbar(Lang.mescaline.eat, 4000, 'uncuff') then return end
	if chance <= Config.Badtrip then 
		AlienEffect()
		local clone = ClonePed(PlayerPedId(), false, false, true)
		SetEntityAsMissionEntity(clone)
		SetPedFleeAttributes(clone, false)
		GiveWeaponToPed(clone, weapon, 1, false, true)
		TaskCombatPed(clone, PlayerPedId(), 0, 16)
		SetPedCombatAttributes(clone, 46, true)
		Wait(1000 * 30)
        DeleteEntity(clone)
	else
		AlienEffect()
	end
end)
