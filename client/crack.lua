local locations = GlobalState.MDDrugsLocations.Crack

for k, v in pairs (locations.makecrack) do
	Bridge.Target.AddBoxZone('makeCrack'..k,  v.loc, vector3(v.l, v.w, 2.0), v.loc.w or 180.0, {
		{
			label = Bridge.Language.Locale('crack.targetMake'),
			icon = Bridge.Language.Locale('crack.makeIcon'),
			action = function()
				if not itemCheck('baking_soda') then return end
				if not minigame() then
					TriggerServerEvent("md-drugs:server:failcrackone", k)
					return
				end
				if not progressbar(Bridge.Language.Locale('crack.cook')) then return end
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
			icon = Bridge.Language.Locale('crack.bagIcon'),
			action = function()
				if not itemCheck('empty_weed_bag') then return end
				if not progressbar(Bridge.Language.Locale('crack.bag')) then return end
				TriggerServerEvent("md-drugs:server:bagcrack", k)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		}
	})
end