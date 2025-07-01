
for k, v in pairs (GlobalState.MDDrugsLocs.makecrack) do
	ps.boxTarget('makeCrack'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
		{
			label = ps.lang('targets.crack.makecrack'),
			icon = 'fa-solid fa-temperature-high',
			action = function()
				if not ps.hasItem('bakingsoda') then return end
				if not minigame() then TriggerServerEvent("md-drugs:server:failcrackone", k) return end
				if not ps.progressbar(ps.lang('Crack.makecrack'), 4000, 'uncuff') then return end
				TriggerServerEvent("md-drugs:server:makecrack", k)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		}
	})
end

for k, v in pairs (GlobalState.MDDrugsLocs.bagcrack) do
	ps.boxTarget('bagCrack'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
		{
			label = ps.lang('targets.crack.bagcrack'),
			icon = 'fa-solid fa-weight-scale',
			action = function()
				if not ps.hasItem('empty_weed_bag') then return end
				if not ps.progressbar(ps.lang('Crack.bagcrack'), 4000, 'uncuff') then return end
				TriggerServerEvent("md-drugs:server:bagcrack", k)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		}
	})
end