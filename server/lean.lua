
local onRun = {}

local function setTimeout(identifier)
	if onRun[identifier] then
		CreateThread(function()
			Wait(10 * 60 * 1000)
			onRun[identifier] = nil
		end)
	end
end
RegisterServerEvent('md-drugs:server:givelean', function()
	local src = source
	local amount = math.random(1,5)
	if not onRun[ps.getIdentifier(src)] then return ps.notify(src, Lang.lean.err, "error") end
	onRun[ps.getIdentifier(src)] = onRun[ps.getIdentifier(src)] + 1
	if math.random(1,100) <= 50 then
		ps.addItem(src, "mdlean", amount)
	else
		ps.addItem(src, "mdreddextro", amount)
	end
	if onRun[ps.getIdentifier(src)] >= 4 then
		onRun[ps.getIdentifier(src)] = nil
	end
end)

exports.ps_lib:registerCrafter({
    loc = GlobalState.MDDrugsLocs.MakeLean,
    recipes = {
		cupoflean = {
			amount = 1,
			time = 5000,
			anim = 'uncuff',
			recipe = {
				leancup = 1,
				mdlean = 1,
				sprunk = 1
			}
		},
		cupofdextro = {
			amount = 1,
			time = 5000,
			anim = 'uncuff',
			recipe = {
				leancup = 1,
				mdreddextro = 1,
				sprunk = 1
			}
		}
	},
	targetData = {
		size = {height = 1.0, width = 1.0, length = 1.0, rotation = 180.0},
		label = 'Make Lean',
		icon = 'fa-solid fa-mug-saucer',
	},
})

ps.registerCallback('md-drugs:server:RegisterLean', function(source)
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