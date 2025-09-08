

ps.registerCallback('md-drugs:client:consumedrugs', function(time, effect, anim, progresstext, status, item)
	if not ps.progressbar(progresstext .. ps.getLabel(item).. "!", time, anim ) then return end
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

local function EcstasyEffect()
    local startStamina = 50
    SetFlash(0, 0, 500, 20000, 500)
    while startStamina > 0 do
        Wait(1000)
        startStamina = startStamina - 1
        RestorePlayerStamina(PlayerId(), 1.0)
        if math.random(1, 100) < 51 then
            SetFlash(0, 0, 500, 7000, 500)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08)
        end
    end
    if IsPedRunning(PlayerPedId()) then
        SetPedToRagdoll(PlayerPedId(), math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end
    startStamina = 0
end

local function TrevorEffect()
    StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
    Wait(3000)
    StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
    Wait(3000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

local function MethBagEffect()
    local startStamina = 30
    TrevorEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.49)
    while startStamina > 0 do
        Wait(1000)
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(5, 100) < 51 then
            TrevorEffect()
        end
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

local function AlienEffect()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(5000, 8000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
end

local function CokeBaggyEffect()
    local startStamina = 20
    local ped = PlayerPedId()
    AlienEffect()
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
    while startStamina > 0 do
        Wait(1000)
        if math.random(1, 100) < 20 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
        if math.random(1, 100) < 10 and IsPedRunning(ped) then
            SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
        end
        if math.random(1, 300) < 10 then
            AlienEffect()
            Wait(math.random(3000, 6000))
        end
    end
    if IsPedRunning(ped) then
        SetPedToRagdoll(ped, math.random(1000, 3000), math.random(1000, 3000), 3, 0, 0, 0)
    end

    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

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
	end
end)