

ps.registerCallback('md-drugs:client:consumedrugs', function(time, effect, anim, progresstext, status, item)
	if not progressbar(progresstext .. GetLabel(item).. "!", time, anim ) then return end
	for k, v in pairs (status) do 
		if k == 'health' then
			local cur = GetEntityHealth(PlayerPedId())
			SetEntityHealth(PlayerPedId(), cur + v)
		elseif k == 'thirst' or k == 'stress' or k == 'hunger' then 
			TriggerServerEvent('md-drugs:server:updatestatus', k, v)	
		elseif k == "armor" then 
			TriggerServerEvent('hospital:server:SetArmor', v)
    	   	TriggerServerEvent('consumables:server:useArmor')
    	   	SetPedArmour(PlayerPedId(), v)
		elseif k == 'speed' then 
			TriggerEvent('md-drugs:client:recievebuff', k, v)
		elseif k == 'strength' then 
			TriggerEvent('md-drugs:client:recievebuff', k, v)
		end
	end
	TriggerEvent('evidence:client:SetStatus', 'widepupils', 200)
	TriggerEvent('md-drugs:client:applyFeeling', effect)
	return true
end)

RegisterNetEvent('md-drugs:client:recievebuff', function(type, amount)
	if type == 'speed' then
		local count = 0
		SetRunSprintMultiplierForPlayer(PlayerPedId(), 1.49)
		repeat 
			count = count + 1
			Wait(1000) 
		until count == amount
		SetRunSprintMultiplierForPlayer(PlayerPedId(), 1.00)
	end
	if type == 'strength' then 
		local strength = 0
		SetCurrentPedWeapon(PlayerPedId(), 'weapon_unarmed', true)
		SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 50.0) 
		repeat 
			strength = strength + 1
			Wait(1000) 
		until strength == amount
		SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"), 1.0) 
	end
end)

RegisterNetEvent('md-drugs:client:applyFeeling', function(effect)
	if effect == "alien" then 
		AlienEffect() 
	elseif effect == "ecstacy" then
		 EcstasyEffect()
	elseif effect == "meth" then 
		MethBagEffect() 
	elseif effect == "coke" then 
		CokeBaggyEffect() 
	elseif effect == "trevor" then 
		TrevorEffect() 
	else 

	end
end)