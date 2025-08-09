
local onRun = {}
local leanLocs = {
	MakeLean = {
        {
            loc = vector3(2635.81, 4240.57, 45.32),
            checks = { -- these can be arrays like {'police', 'ambulance'} or just a single string like 'police'
                --gang = {},
                --item = {},
                --job = {},
                --citizenid = {}
            }
        },
    },
	SyrupVendor = {
        {ped = 'a_m_m_farmer_01', loc = vector4(365.21, -578.77, 39.30, 347.23), l = 1.0, w = 1.0, rot = 347.23, gang = ""},
    },
	StartLoc = { -- where truck spawns for lean and meth missions
        vector3(-2307.22, 434.77, 174.47),
        vector3(614.75, 1786.26, 199.39),
        vector3(-224.89, 6388.32, 31.59)
    },
}

ps.registerCallback('md-drugs:server:GetLeanLocs', function(source)
	return leanLocs
end)

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
	if not onRun[ps.getIdentifier(src)] then return ps.notify(src, ps.lang('lean.notOnRun'), "error") end
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
    loc = leanLocs.MakeLean,
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