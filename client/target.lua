local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
if Config.oxtarget then
	 exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.makecokepowder,
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
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.cutcokeone,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:cutcokeone",
				icon = "fas fa-sign-in-alt",
				label = "cut up",
				
			},
		},
	})
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.bagcoke,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:bagcoke",
				icon = "fas fa-sign-in-alt",
				label = "bagging",
				
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
		coords = Config.buylsdlabkit,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:buylabkit",
				icon = "fas fa-sign-in-alt",
				label = "Buy A Kit",
				
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
	exports.ox_target:addBoxZone({ -- 963.37, -2122.95, 31.47
		coords = Config.buyheroinlabkit,
		size = vec3(2,2,2),
		debugPoly = false,
		rotation = 45,
		options = {
			{
				type = "client",
				event = "md-drugs:client:buyheroinlabkit",
				icon = "fas fa-sign-in-alt",
				label = "Buy A Kit",
				
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
	exports['qb-target']:AddBoxZone("makepowdercoke",Config.makecokepowder,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "makepowdercoke",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.makecokepowder-2,
		maxZ = Config.makecokepowder+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:makepowder",
				icon = "fas fa-sign-in-alt",
				label = "chop it up",
				
			},
		},
		distance = 2.5
	})
	
	exports['qb-target']:AddBoxZone("cutcokepowder",Config.cutcokeone,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "cutcokepowder",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.cutcokeone-2,
		maxZ = Config.cutcokeone+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:cutcokeone",
				icon = "fas fa-sign-in-alt",
				label = "cut up",
				
			},
		},
		distance = 2.5
	})
	
	exports['qb-target']:AddBoxZone("bagcokepowder",Config.bagcoke,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "bagcokepowder",
		heading = 11.0,
		debugPoly = false,
		minZ = Config.bagcoke-2,
		maxZ = Config.bagcoke+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:bagcoke",
				icon = "fas fa-sign-in-alt",
				label = "bagging",
				
			},
		},
		distance = 2.5
	})
	
	
	----- LSD 
	exports['qb-target']:AddBoxZone("getlysergic",Config.lysergicacid,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "getlysergic",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.lysergicacid-2,
		maxZ = Config.lysergicacid+2,
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
		minZ = Config.diethylamide-2,
		maxZ = Config.diethylamide+2,
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
	
		exports['qb-target']:AddBoxZone("buylabkit",Config.buylsdlabkit,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "buylabkit",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.buylsdlabkit-2,
		maxZ = Config.buylsdlabkit+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:buylabkit",
				icon = "fas fa-sign-in-alt",
				label = "Buy A Kit",
				
			},
		},
		distance = 2.5
	})
		exports['qb-target']:AddBoxZone("dryplant",Config.dryplant,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "dryplant",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.dryplant-2,
		maxZ = Config.dryplant+2,
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
		minZ = Config.cutheroinone-2,
		maxZ = Config.cutheroinone+2,
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
		minZ = Config.fillneedle-2,
		maxZ = Config.fillneedle+2,
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
	
		exports['qb-target']:AddBoxZone("buyheroinlabkit",Config.buyheroinlabkit,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "buyheroinlabkit",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.buyheroinlabkit-2,
		maxZ = Config.buyheroinlabkit+2,
	}, {
		options = {
			{
				type = "client",
				event = "md-drugs:client:buyheroinlabkit",
				icon = "fas fa-sign-in-alt",
				label = "Buy A Kit",
				
			},
		},
		distance = 2.5
	})
	exports['qb-target']:AddBoxZone("crackmakeone",Config.makecrack,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "crackmakeone",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.makecrack-2,
		maxZ = Config.makecrack+2,
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
		minZ = Config.bagcrack-2,
		maxZ = Config.bagcrack+2,
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
		minZ = Config.FillPrescription-2,
		maxZ = Config.FillPrescription+2,
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
		minZ = Config.DryOut-2,
		maxZ = Config.DryOut+2,
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
		--------------------------------------- XTC
		exports['qb-target']:AddBoxZone("stealisosafrole2",Config.isosafrole,1.5, 1.75, { -- 963.37, -2122.95, 31.47
		name = "stealisosafrole2",
		heading = 156.0,
		debugPoly = false,
		minZ = Config.isosafrole-2,
		maxZ = Config.isosafrole+2,
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
		minZ = Config.mdp2p-2,
		maxZ = Config.mdp2p+2,
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
		minZ = Config.rawxtcloc-2,
		maxZ = Config.rawxtcloc+2,
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
		minZ = Config.buypress-2,
		maxZ = Config.buypress+2,
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
		minZ = Config.stamp-2,
		maxZ = Config.stamp+2,
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
