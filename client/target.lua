local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
if Config.oxtarget then
	coketelein = exports.ox_target:addBoxZone({
	coords = Config.CokeTeleIn,
	size = vec(1,1,3),
	rotation = 0,
	debug = false,
	options = {
		{
			name = 'teleout',
			icon = "fas fa-sign-in-alt",
			label = "Enter Building",
			distance = 5,
			onSelect = function()
				 DoScreenFadeOut(500)
				Wait(1000)
				SetEntityCoords(PlayerPedId(),Config.CokeTeleOut.x, Config.CokeTeleOut.y, Config.CokeTeleOut.z)
				 Wait(1000)
				 DoScreenFadeIn(500)
			end,

		},
	},
})
	coketeleout = exports.ox_target:addBoxZone({
	coords = Config.CokeTeleOut,
	size = vec(1,1,3),
	rotation = 0,
	debug = false,
	options = {
			{
				name = 'teleout',
				icon = "fas fa-sign-in-alt",
				label = "Exit Building",
				distance = 5,
				onSelect = function()
					DoScreenFadeOut(500)
					Wait(500)
					SetEntityCoords(PlayerPedId(),Config.CokeTeleIn)
					Wait(500)
						DoScreenFadeIn(500)
				end,

			},
		},
	})
	 exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = vector3(1087.16, -3195.46, -38.99),
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:makepowder",
				icon = "fas fa-sign-in-alt",
				label = "chop it up",

			},
		},
	})
	
	------------- lsd
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.lysergicacid,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:getlysergic",
				icon = "fas fa-sign-in-alt",
				label = "stealing",
			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.diethylamide,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:getdiethylamide",
				icon = "fas fa-sign-in-alt",
				label = "stealing",
			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.gettabs,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:buytabs",
				icon = "fas fa-sign-in-alt",
				label = "Buy Tabs",

			},
		},
	})
	------ heroin
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.dryplant,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:dryplant",
				icon = "fas fa-sign-in-alt",
				label = "Dry out",

			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.cutheroinone,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:cutheroin",
				icon = "fas fa-sign-in-alt",
				label = "Cut Heroin",

			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.fillneedle,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:fillneedle",
				icon = "fas fa-sign-in-alt",
				label = "Fill Needles",

			},
		},
	})
	------- crack
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.makecrack,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:makecrackone",
				icon = "fas fa-sign-in-alt",
				label = "cook some crack",
			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.bagcrack,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:bagcrack",
				icon = "fas fa-sign-in-alt",
				label = "bag some crack",

			},
		},
	})
	------- pharma
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.FillPrescription,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:fillprescription",
				icon = "fas fa-sign-in-alt",
				label = "Fill Prescription",
			},
		},
	})
	-------- oxy runs
	exports.ox_target:addBoxZone({
		coords = Config.Payfortruck,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				event = "md-drugs:client:getoxytruck",
				icon = "fas fa-sign-in-alt",
				label = "Pay For Truck",
			},
		}
	})
	------------ mescaline
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.DryOut,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:drymescaline",
				icon = "fas fa-sign-in-alt",
				label = "Dry Out",

			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.isosafrole,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
			type = "client",
			event = "md-drugs:client:stealisosafrole",
			icon = 'fas fa-sign-in-alt',
			label = 'Steal Isosafrole',
			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.mdp2p,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:stealmdp2p",
				icon = 'fas fa-eye',
				label = 'Steal mdp2p',
			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.rawxtcloc,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:makingrawxtc",
				icon = 'fas fa-eye',
				label = 'Make Raw XTC',
			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.buypress,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:buypress",
				icon = 'fas fa-eye',
				label = 'Buy Press',
			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.stamp,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:stampwhite",
				icon = 'fas fa-eye',
				label = 'Make White Stamped Pills',
			},
			{
				type = "client",
				event = "md-drugs:client:stampred",
				icon = 'fas fa-eye',
				label = 'Make Red Stamped Pills',
			},
			{
				type = "client",
				event = "md-drugs:client:stamporange",
				icon = 'fas fa-eye',
				label = 'Make Orange Stamped Pills',
			},
			{
				type = "client",
				event = "md-drugs:client:stampblue",
				icon = 'fas fa-eye',
				label = 'Make Blue Stamped Pills',
			},
		},
	})
		--------------------------------------- XTC
else

	exports['qb-target']:AddBoxZone("coketelein",Config.CokeTeleIn,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "coketelein",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.CokeTeleIn.z-2,
		maxZ = Config.CokeTeleIn.z+2,
	}, {
		options = {
			{
				name = 'teleout',
				icon = "fas fa-sign-in-alt",
				label = "Enter Building",
				action = function()
					 DoScreenFadeOut(500)
					Wait(500)
					SetEntityCoords(PlayerPedId(),Config.CokeTeleOut)
					 Wait(500)
					 DoScreenFadeIn(500)
				end,
	
			},
		},
	})
	exports['qb-target']:AddBoxZone("CokeTeleOut",Config.CokeTeleOut,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "CokeTeleOut",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.CokeTeleOut.z-2,
	maxZ = Config.CokeTeleOut.z+2,
}, {
		options = {
				{
					name = 'teleout',
					icon = "fas fa-sign-in-alt",
					label = "Exit Building",
					action = function()
						DoScreenFadeOut(500)
						Wait(500)
						SetEntityCoords(PlayerPedId(),Config.CokeTeleIn)
						Wait(500)
							DoScreenFadeIn(500)
					end,
	
				},
			},
		})
		exports['qb-target']:AddBoxZone("makepowder",Config.MakePowder,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "makepowder",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.MakePowder.z-2,
	maxZ = Config.MakePowder.z+2,
}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:makepowder",
				icon = "fas fa-sign-in-alt",
				label = "chop it up",

			},
		},
	})
	----- LSD 
	exports['qb-target']:AddBoxZone("getlysergic",Config.lysergicacid,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "getlysergic",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.lysergicacid.z-2,
		maxZ = Config.lysergicacid.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:getlysergic",
				icon = "fas fa-sign-in-alt",
				label = "stealing",
			},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("getdiethylamide",Config.diethylamide,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "getdiethylamide",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.diethylamide.z-2,
		maxZ = Config.diethylamide.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:getdiethylamide",
				icon = "fas fa-sign-in-alt",
				label = "stealing",
			},
		},
		distance = 2.5
	})
		exports['qb-target']:AddBoxZone("buylabkit2",Config.gettabs,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "buylabkit2",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.gettabs.z-2,
		maxZ = Config.gettabs.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:buytabs",
				icon = "fas fa-sign-in-alt",
				label = "Buy Tabs",

			},
		},
		distance = 2.5
	})
		exports['qb-target']:AddBoxZone("dryplant",Config.dryplant,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "dryplant",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.dryplant.z-2,
		maxZ = Config.dryplant.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:dryplant",
				icon = "fas fa-sign-in-alt",
				label = "Dry out",

			},
		},
		distance = 2.5
	})
			exports['qb-target']:AddBoxZone("cutheroin",Config.cutheroinone,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "cutheroin",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.cutheroinone.z-2,
		maxZ = Config.cutheroinone.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:cutheroin",
				icon = "fas fa-sign-in-alt",
				label = "Cut Heroin",

			},
		},
		distance = 2.5
	})

			exports['qb-target']:AddBoxZone("fillneedle",Config.fillneedle,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "fillneedle",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.fillneedle.z-2,
		maxZ = Config.fillneedle.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:fillneedle",
				icon = "fas fa-sign-in-alt",
				label = "Fill Needles",

			},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("crackmakeone",Config.makecrack,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "crackmakeone",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.makecrack.z-2,
		maxZ = Config.makecrack.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:makecrackone",
				icon = "fas fa-sign-in-alt",
				label = "cook some crack",

			},
		},
		distance = 2.5
	})
		exports['qb-target']:AddBoxZone("bagcrack",Config.bagcrack,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "bagcrack",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.bagcrack.z-2,
		maxZ = Config.bagcrack.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:bagcrack",
				icon = "fas fa-sign-in-alt",
				label = "Bag some crack",

			},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("pharmapresc",Config.FillPrescription,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "pharmapresc",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.FillPrescription.z-2,
		maxZ = Config.FillPrescription.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:fillprescription",
				icon = "fas fa-sign-in-alt",
				label = "Fill Prescription",

			},
		},
		distance = 2.5
	})
	----------------------------------------- mescaline
	exports['qb-target']:AddBoxZone("drymescaline",Config.DryOut,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "drymescaline",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.DryOut.z-2,
		maxZ = Config.DryOut.z+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:drymescaline",
				icon = "fas fa-sign-in-alt",
				label = "Dry Out",

			},
		},
		distance = 2.5
	})
	-------------- oxy run
	exports['qb-target']:AddBoxZone("getoxytruck",Config.Payfortruck,1.5, 1.75, { -- 963.37, .z-2122.95, 31.47
	name = "getoxytruck",
	heading = 11.0,
	debugPoly = false,
	minZ = Config.Payfortruck.z-2,
	maxZ = Config.Payfortruck.z+2,
	}, {
	options = {
			{
				event = "md-drugs:client:getoxytruck",
				icon = "fas fa-sign-in-alt",
				label = "Pay For Truck",
			},
		}
	})
		--------------------------------------- XTC
		exports['qb-target']:AddBoxZone("stealisosafrole2",Config.isosafrole,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "stealisosafrole2",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.isosafrole.z-2,
		maxZ = Config.isosafrole.z+2,
	}, {
		options = {
		{
			type = "client",
			event = "md-drugs:client:stealisosafrole",
			icon = 'fas fa-sign-in-alt',
			label = 'Steal Isosafrole',
			},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("stealmdp2p",Config.mdp2p,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "stealmdp2p",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.mdp2p.z-2,
		maxZ = Config.mdp2p.z+2,
	}, {
		options = {
		{
		type = "client",
		event = "md-drugs:client:stealmdp2p",
		icon = 'fas fa-eye',
		label = 'Steal mdp2p',
		},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("makerawxtc",Config.rawxtcloc,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "makerawxtc",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.rawxtcloc.z-2,
		maxZ = Config.rawxtcloc.z+2,
	}, {
		options = {
			{
			type = "client",
			event = "md-drugs:client:makingrawxtc",
			icon = 'fas fa-eye',
			label = 'Make Raw XTC',
			},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("buypress",Config.buypress,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "buypress",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.buypress.z-2,
		maxZ = Config.buypress.z+2,
	}, {
		options = {
		{
		type = "client",
		event = "md-drugs:client:buypress",
		icon = 'fas fa-eye',
		label = 'Buy Press',
			},
		},
		distance = 2.5
	})

		exports['qb-target']:AddBoxZone("stampwhite",Config.stamp,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "stampwhite",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.stamp.z-2,
		maxZ = Config.stamp.z+2,
	}, {
	options = {
		{
		type = "client",
		event = "md-drugs:client:stampwhite",
		icon = 'fas fa-eye',
		label = 'Make White Stamped Pills',
		},
		{
		type = "client",
		event = "md-drugs:client:stampred",
		icon = 'fas fa-eye',
		label = 'Make Red Stamped Pills',
		},
		{
		type = "client",
		event = "md-drugs:client:stamporange",
		icon = 'fas fa-eye',
		label = 'Make Orange Stamped Pills',
		},
		{
		type = "client",
		event = "md-drugs:client:stampblue",
		icon = 'fas fa-eye',
		label = 'Make Blue Stamped Pills',
		},
	},
		distance = 2.5
	})
end
end)
