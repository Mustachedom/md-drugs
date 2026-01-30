
local badTrip = 100
repeat Wait(100) until GlobalState.MDDrugsRecipes.Mescaline ~= nil
local locations = GlobalState.MDDrugsLocations.Mescaline
local function AlienEffect()
	CreateThread(function()
    StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
    StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
    Wait(math.random(25000, 35000))
    StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
    StopScreenEffect("DrugsMichaelAliensFightIn")
    StopScreenEffect("DrugsMichaelAliensFight")
    StopScreenEffect("DrugsMichaelAliensFightOut")
	end)
end


for k, v in pairs (locations.DryOutMescaline) do
	Bridge.Target.AddBoxZone('dryoutMesc'..k, v.loc, v.size, v.loc.w or 180.0,{
		{
			label = Bridge.Language.Locale('mesc.targetDry'),
			icon = 'fa-solid fa-temperature-high',
			action = function()
				if not itemCheck('cactusbulb') then return end
				if not progressbar(Bridge.Language.Locale('mesc.dry')) then return end
				TriggerServerEvent("md-drugs:server:drymescaline", k)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		}
	})
	targets[#targets+1] = 'dryoutMesc'..k
end

RegisterNetEvent("md-drugs:client:takemescaline", function()
    local chance, chance2 = math.random(1,100), math.random(1,100)
    local weapon = ''
    if chance2 == 100 then weapon = 'weapon_rpg' else weapon = 'weapon_flaregun' end
    if not progressbar(Bridge.Language.Locale('mesc.eat')) then return end
	if chance <= badTrip then
		AlienEffect()
		Wait(math.random(3000,6000))
		local clone = ClonePed(PlayerPedId(), true, true, true)
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
