local locations = ps.callback('md-drugs:server:GetMescalineLocs')
for k, v in pairs (locations.DryOutMescaline) do
	ps.boxTarget('dryoutMesc'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
		{
			label = ps.lang('mesc.targetDry'),
			icon = 'fa-solid fa-temperature-high',
			action = function()
				if not ps.hasItem('cactusbulb') then 
					ps.notify(ps.lang('Catches.itemNeeded', ps.getLabel('cactusbulb')), 'error') 
					return 
				end
				if not ps.progressbar(ps.lang('mescaline.dry'), 4000, 'uncuff') then return end
				TriggerServerEvent("md-drugs:server:drymescaline", k)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		}
	})
end

RegisterNetEvent("md-drugs:client:takemescaline", function()
    local chance, chance2 = math.random(1,100), math.random(1,100)
    local weapon = ''
    if chance2 == 100 then weapon = 'weapon_rpg' else weapon = 'weapon_flaregun' end
    if not ps.progressbar(ps.lang('mescaline.eat'), 4000, 'uncuff') then return end
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
