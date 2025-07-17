
local onRun = {}

local function setTimeout(identifier)
	if onRun[identifier] then
		CreateThread(function()
			Wait(10 * 60 * 1000)
			onRun[identifier] = nil
		end)
	end
end

RegisterServerEvent('md-drugs:server:givemethingridients', function()
	local src = source
	local amount = math.random(1,5)
	if not onRun[ps.getIdentifier(src)] then return ps.notify(src, Lang.lean.err, "error") end
	onRun[ps.getIdentifier(src)] = onRun[ps.getIdentifier(src)] + 1
	if math.random(1,100) <= 50 then
		ps.addItem(src, "ephedrine", amount)
	else
		ps.addItem(src, "acetone", amount)
	end
	if onRun[ps.getIdentifier(src)] >= 4 then
		onRun[ps.getIdentifier(src)] = nil
	end
end)
RegisterServerEvent('md-drugs:server:startcook', function(num)
  	local src = source
	if not GetRecipe(source, 'meth', 'cook', 'heat') then return end
	ps.notify(src, "Adding Things To The Mix", "success")
end)

RegisterServerEvent('md-drugs:server:getmeth', function(num)
  	local src = source
	if not ps.checkDistance(src, GlobalState.MDDrugsLocs.BagMeth[num].loc, 2.5) then return end
	if not GetRecipe(src, 'meth', 'bag', 'bags') then return end
end)

RegisterServerEvent('md-drugs:server:geteph', function(num)
	local src = source
	if not checkLoc(src, 'MethEph', num) then return end
	if AddItem(src, 'ephedrine', 1) then
		ps.notify(src, 'Got Ephedrine!', "success")
	end
end)
	
RegisterServerEvent('md-drugs:server:getace', function(num)
	local src = source
	if not checkLoc(src, 'Methace', num) then return end
	if AddItem(src, 'acetone', 1) then
		--Log(GetName(src) .. ' Got ' .. 1 .. 'Of Acetone', 'Meth')
	end
end)

ps.registerCallback('md-drugs:server:startcook', function(source, num)
	local src = source
	if not ps.checkDistance(src, GlobalState.MDDrugsLocs.CookMeth[num].loc, 2.5) then return false end
	local recipe = GetRecipe(src, 'meth', 'cook', 'heat')
	ps.debug(recipe)
	return recipe
end)