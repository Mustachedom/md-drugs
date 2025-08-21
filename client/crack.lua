local locations = ps.callback('md-drugs:server:GetCrackLocations')

for k, v in pairs (locations.makecrack) do
	ps.boxTarget('makeCrack'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
		{
			label = ps.lang('crack.targetMake'),
			icon = 'fa-solid fa-temperature-high',
			action = function()
				if not ps.hasItem('bakingsoda') then
					ps.notify(ps.lang('Catches.itemMissings', ps.getLabel('bakingsoda')), 'error')
					return
				end
				if not minigame() then
					TriggerServerEvent("md-drugs:server:failcrackone", k)
					return
				end
				local qty = promptBatchQuantity('Select Quantity')
				if not qty then return end
				if not progressbarScaled(ps.lang('crack.cook'), qty, 'uncuff') then return end
				TriggerServerEvent('md-drugs:server:makecrackone', k, qty)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		}
	})
end

for k, v in pairs (locations.bagcrack) do
	ps.boxTarget('bagCrack'..k, v.loc, {length = v.l, width = v.w, height = 1.0, rotation = v.rot}, {
		{
			label = ps.lang('crack.targetBag'),
			icon = 'fa-solid fa-weight-scale',
			action = function()
				if not ps.hasItem('empty_weed_bag') then
					ps.notify(ps.lang('Catches.itemMissings', ps.getLabel('empty_weed_bag')), 'error')
					return
				end
				local qty = promptBatchQuantity('Select Quantity')
				if not qty then return end
				if not progressbarScaled(ps.lang('crack.bag'), qty, 'uncuff') then return end
				TriggerServerEvent("md-drugs:server:bagcrack", k, qty)
			end,
			canInteract = function()
				if not handleGang(v.gang) then return false end
				return true
			end
		}
	})
end