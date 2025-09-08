
local onRun = {}
local cool = {}

local methLocs = {
	CookMeth = {
        {loc = vector3(1006.09, -3200.59, -38.52), l = 1.0, w = 1.0, rot = 45.0, offset = vec3(4.79, 2.13, -0.41), rotation = vector3(0,0,0.0), gang = ""},
    },
    MethDials = {
        {loc = vector3(1007.89, -3201.17, -38.99),l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    MethSmash = {
        {loc = vector3(1012.04, -3194.96, -38.99), bucket = vector4(1012.86, -3194.13, -39.20, 90.00), l = 1.0, w = 1.0, rot = 45.0, offset = vec3(-3.143311, -1.666748, -1.010128), rotation = vector3(0,0,0.0), gang = ""},
    },
    BagMeth = {
        {loc = vector3(1014.25, -3194.93, -38.99), l = 1.0, w = 1.0, rot = 45.0, offset = vec3(-4.9, -1.70, -1.01), rotation = vector3(0,0,0.0), gang = ""},
    },
    MethEph = { -- get ephedrine
        {loc = vector3(3559.86, 3673.9, 28.13), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    MethAce = { -- get acetone
        {loc = vector3(3535.41, 3661.05, 28.12), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
    },
    MethHeist = {
        {loc = vector4(-1520.84, 827.72, 181.66, 184.13), ped = 'a_m_m_farmer_01', gang = ""},
    },
    StartLoc = { -- where truck spawns for lean and meth missions
        vector3(-2307.22, 434.77, 174.47),
        vector3(614.75, 1786.26, 199.39),
        vector3(-224.89, 6388.32, 31.59)
    },
	MethTele = {
		{inside = vector3(996.91, -3200.83, -36.39), outside = vector3(-2222.04, 303.99, 174.6), l = 1.0, w = 1.0, rot = 45.0, gang = ""},
	}
}

local methRecipes = {
	cook = {
		heat = {take = {ephedrine = 1, acetone = 1}, give = {}} --Missing item
	},
	bag = {
		bags = {take = {empty_weed_bag = 5}, give = {methbags = 5} }
	}
}

ps.registerCallback('md-drugs:server:GetMethLocs', function(source)
	return methLocs
end)

local function setTimeout(identifier)
	if onRun[identifier] then
		CreateThread(function()
			Wait(10 * 60 * 1000)
			onRun[identifier] = nil
		end)
	end
end

local function coolDown(identifier)
	if cool[identifier] then
		return false
	else
		cool[identifier] = true
		CreateThread(function()
			Wait(3500)
			cool[identifier] = nil
		end)
		return true
	end
end

RegisterServerEvent('md-drugs:server:givemethingridients', function()
	local src = source
	local amount = math.random(1,5)
	if not onRun[ps.getIdentifier(src)] then return ps.notify(src, ps.lang('meth.notOnRun'), "error") end
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


RegisterServerEvent('md-drugs:server:getmeth', function(num)
  	local src = source
	if timeOut(src, 'md-drugs:server:getmeth') then return end
	if not ps.checkDistance(src, methLocs.BagMeth[num].loc, 2.5) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return
	end
	if not ps.craftItem(src, methRecipes.bag.bags) then
		verifyHas(src, methRecipes.bag.bags.take)
		return
	end
end)

RegisterServerEvent('md-drugs:server:geteph', function(num)
	local src = source
	if not ps.checkDistance(src, methLocs.MethEph[num].loc, 2.5) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return
	end
	if timeOut(src, 'md-drugs:server:geteph') then return end
	ps.addItem(src, 'ephedrine', 1)
end)

RegisterServerEvent('md-drugs:server:getace', function(num)
	local src = source
	if not ps.checkDistance(src, methLocs.MethAce[num].loc, 2.5) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return
	end
	if timeOut(src, 'md-drugs:server:getace') then return end
	ps.addItem(src, 'acetone', 1)
end)

ps.registerCallback('md-drugs:server:startcook', function(source, num)
	local src = source
	if not ps.checkDistance(src, methLocs.CookMeth[num].loc, 2.5) then
		ps.notify(src, ps.lang('Catches.notIn'), "error")
		return false
	end
	local recipe = ps.craftItem(src, methRecipes.cook.heat)
	if not recipe then
		verifyHas(src, methRecipes.cook.heat.take)
		return false
	end
	return true
end)

ps.registerCallback('md-drugs:server:registerMeth', function(source)
	local identifier = ps.getIdentifier(source)
	if not identifier then return false end
	if onRun[identifier] then
		return false
	else
		onRun[identifier] = 0
		setTimeout(identifier)
		return true
	end
end)



