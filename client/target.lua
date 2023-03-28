local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
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
 exports['qb-target']:AddBoxZone("cutcokepowdertwo",Config.cutcoke2,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "cutcokepowdertwo",
	heading = 11.0,
	debugPoly = false,
	minZ = Config.cutcoke2-2,
	maxZ = Config.cutcoke2+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:cutcoketwo",
			icon = "fas fa-sign-in-alt",
			label = "cut up",
			
		},
	},
	distance = 2.5
 })
 exports['qb-target']:AddBoxZone("cutcokepowderthree",Config.cutcoke3,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "cutcokepowderthree",
	heading = 11.0,
	debugPoly = false,
	minZ = Config.cutcoke3-2,
	maxZ = Config.cutcoke3+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:cutcokethree",
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
 exports['qb-target']:AddBoxZone("bagcoketwo",Config.bagcoke2,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "bagcoketwo",
	heading = 11.0,
	debugPoly = false,
	minZ = Config.bagcoke2-2,
	maxZ = Config.bagcoke2+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:bagcoketwo",
			icon = "fas fa-sign-in-alt",
			label = "bagging",
			
		},
	},
	distance = 2.5
 })
 exports['qb-target']:AddBoxZone("bagcokethree",Config.bagcoke3,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "bagcokethree",
	heading = 11.0,
	debugPoly = false,
	minZ = Config.bagcoke3-2,
	maxZ = Config.bagcoke3+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:bagcokethree",
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
    exports['qb-target']:AddBoxZone("refinequalityacid", Config.acidrefine,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "refinequalityacid",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.acidrefine-2,
	maxZ = Config.acidrefine+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:refinequalityacid",
			icon = "fas fa-sign-in-alt",
			label = "Refine",
			item = "lsd_one_vial"
		},
	},
	distance = 2.5
 })
    exports['qb-target']:AddBoxZone("maketabpaperone",Config.maketabs1,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "maketabpaperone",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.maketabs1-2,
	maxZ = Config.maketabs1+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:maketabpaperone",
			icon = "fas fa-sign-in-alt",
			label = "Make Tabs",
			item = "lsd_one_vial",
		},
	},
	distance = 2.5
 })
     exports['qb-target']:AddBoxZone("maketabpapertwo",Config.maketabs2 ,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "maketabpapertwo",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.maketabs2-2,
	maxZ = Config.maketabs2+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:maketabpapertwo",
			icon = "fas fa-sign-in-alt",
			label = "Make Tabs",
			item = "lsd_vial_two",
		},
	},
	distance = 2.5
 })
      exports['qb-target']:AddBoxZone("maketabpaperthree",Config.maketabs3,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "maketabpaperthree",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.maketabs3-2,
	maxZ = Config.maketabs3+3,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:maketabpaperthree",
			icon = "fas fa-sign-in-alt",
			label = "Make Tabs",
			item = "lsd_vial_three",
		},
	},
	distance = 2.5
 })
       exports['qb-target']:AddBoxZone("maketabpaperfour",Config.maketabs4,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "maketabpaperfour",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.maketabs4-2,
	maxZ = Config.maketabs4+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:maketabpaperfour",
			icon = "fas fa-sign-in-alt",
			label = "Make Tabs",
			item = "lsd_vial_four",
		},
	},
	distance = 2.5
 })
        exports['qb-target']:AddBoxZone("maketabpaperfive",Config.maketabs5,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "maketabpaperfive",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.maketabs5-2,
	maxZ = Config.maketabs5+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:maketabpaperfive",
			icon = "fas fa-sign-in-alt",
			label = "Make Tabs",
			item = "lsd_vial_five",
		},
	},
	distance = 2.5
 })
         exports['qb-target']:AddBoxZone("maketabpapersix",Config.maketabs6,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "maketabpapersix",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.maketabs6-2,
	maxZ = Config.maketabs6+2,
}, {
	options = {
		{
            type = "client",
            event = "md-drugs:client:maketabpapersix",
			icon = "fas fa-sign-in-alt",
			label = "Make Tabs",
			item = "lsd_vial_six",
		},
	},
	distance = 2.5
 })
     exports['qb-target']:AddBoxZone("gettabpaper",Config.gettabs,1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "gettabpaper",
	heading = 156.0,
	debugPoly = false,
	minZ = Config.gettabs-2,
	maxZ = Config.gettabs+2,
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
			label = "cook some crack",
			
		},
	},
	distance = 2.5
 })
 exports['qb-target']:AddBoxZone("pharmapresc",vector3(-491.57, -341.0, 42.32),1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "pharmapresc",
	heading = 156.0,
	debugPoly = false,
	minZ = 40,
	maxZ = 44,
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
  
end)
