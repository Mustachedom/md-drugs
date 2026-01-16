local locations = GlobalState.MDDrugsLocations.Crack

for k, v in pairs (locations.makecrack) do
	Bridge.Target.AddBoxZone('makeCrack'..k,  v.loc, vector3(v.l, v.w, 2.0), v.loc.w or 180.0, {
		{
			label = Bridge.Language.Locale('crack.targetMake'),
			icon = 'fa-solid fa-temperature-high',
			action = function()
				if not Bridge.Inventory.HasItem('bakingsoda') then
					Bridge.Notify.SendNotify(Bridge.Language.Locale('Catches.itemMissings',  Bridge.Inventory.GetItemInfo('bakingsoda').label), 'error')
					return
				end
				if not minigame() then
					TriggerServerEvent("md-drugs:server:failcrackone", k)
					return
				end
				if not progressbar(Bridge.Language.Locale('crack.cook'), 4000, 'uncuff') then return end
				TriggerServerEvent('md-drugs:server:makecrackone', k)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		}
	})
end

for k, v in pairs (locations.bagcrack) do
	Bridge.Target.AddBoxZone('bagCrack'..k, v.loc, vector3(v.l, v.w, 2.0), v.loc.w or 180.0, {
		{
			label = Bridge.Language.Locale('crack.targetBag'),
			icon = 'fa-solid fa-weight-scale',
			action = function()
				if not Bridge.Inventory.HasItem('empty_weed_bag') then
					Bridge.Notify.SendNotify(Bridge.Language.Locale('Catches.itemMissings',  Bridge.Inventory.GetItemInfo('empty_weed_bag').label), 'error')
					return
				end
				if not progressbar(Bridge.Language.Locale('crack.bag'), 4000, 'uncuff') then return end
				TriggerServerEvent("md-drugs:server:bagcrack", k)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		}
	})
end