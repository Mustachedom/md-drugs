
local badTrip = 100

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

local locations = GlobalState.MDDrugsLocations.Mescaline
for k, v in pairs (locations.DryOutMescaline) do
	Bridge.Target.AddBoxZone('dryoutMesc'..k, v.loc, vector3(v.l, v.w, 2.0), v.loc.w or 180.0,{
		{
			label = Bridge.Language.Locale('mesc.targetDry'),
			icon = 'fa-solid fa-temperature-high',
			action = function()
				if not Bridge.Inventory.HasItem('cactusbulb') then 
					Bridge.Notify.SendNotify(Bridge.Language.Locale('Catches.itemNeeded', Bridge.Inventory.GetItemInfo('cactusbulb').label), 'error') 
					return 
				end
				if not progressbar(Bridge.Language.Locale('mescaline.dry'), 4000, 'uncuff') then return end
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
    if not progressbar(Bridge.Language.Locale('mescaline.eat'), 4000, 'uncuff') then return end
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
