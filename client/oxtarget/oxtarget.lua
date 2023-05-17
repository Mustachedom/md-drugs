


CreateThread(function()
exports.ox_target:addBoxZone({
    coords = Config.makecokepowder,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'makepowdercoke',
            event = "md-drugs:client:makepowder",
            icon = 'fas fa-sign-in-alt',
            label = 'Chop It Up',
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.cutcokeone,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'cutcokepowder',
            event = "md-drugs:client:cutcokeone",
            icon = 'fas fa-sign-in-alt',
            label = 'Cut Up',
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.cutcoke2,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'cutcokepowdertwo',
            event = "md-drugs:client:cutcoketwo",
            icon = 'fas fa-sign-in-alt',
            label = 'Cut Up',
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.cutcoke3,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'cutcokepowderthree',
            event = "md-drugs:client:cutcokethree",
            icon = 'fas fa-sign-in-alt',
            label = 'Cut Up',
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.bagcoke,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'bagcoke',
            event = "md-drugs:client:bagcoke",
            icon = 'fas fa-sign-in-alt',
            label = 'bagging',
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.bagcoke2,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'bagcoketwo',
            event = "md-drugs:client:bagcoketwo",
            icon = 'fas fa-sign-in-alt',
            label = 'bagging',
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.bagcoke3,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'bagcokethree',
            event = "md-drugs:client:bagcokethree",
            icon = 'fas fa-sign-in-alt',
            label = 'bagging',
        }
    }
})
------------------------LSD
exports.ox_target:addBoxZone({
    coords = Config.lysergicacid,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'getlysergic',
            event = "md-drugs:client:getlysergic",
            icon = 'fas fa-sign-in-alt',
            label = 'stealing',
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.getdiethylamide,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'getdiethylamide',
            event = "md-drugs:client:getdiethylamide",
            icon = 'fas fa-sign-in-alt',
            label = 'stealing',
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.acidrefine,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'refinequalityacid',
            event = "md-drugs:client:refinequalityacid",
            icon = 'fas fa-sign-in-alt',
            label = 'stealing',
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.maketabs1,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'maketabpaperone',
            event = "md-drugs:client:maketabpaperone",
            icon = 'fas fa-sign-in-alt',
            label = 'Make Tabs',
			Item = "lsd_one_vial",
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.maketabs2,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'maketabpapertwo',
            event = "md-drugs:client:maketabpapertwo",
            icon = 'fas fa-sign-in-alt',
            label = 'Make Tabs',
			Item = "lsd_vial_two",
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.maketabs3,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'maketabpaperthree',
            event = "md-drugs:client:maketabpaperthree",
            icon = 'fas fa-sign-in-alt',
            label = 'Make Tabs',
			Item = "lsd_vial_three",
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.maketabs4,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'maketabpaperfour',
            event = "md-drugs:client:maketabpaperfour",
            icon = 'fas fa-sign-in-alt',
            label = 'Make Tabs',
			Item = "lsd_vial_four",
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.maketabs5,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'maketabpaperfive',
            event = "md-drugs:client:maketabpaperfive",
            icon = 'fas fa-sign-in-alt',
            label = 'Make Tabs',
			Item = "lsd_vial_five",
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.maketabs6,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'maketabpapersix',
            event = "md-drugs:client:maketabpapersix",
            icon = 'fas fa-sign-in-alt',
            label = 'Make Tabs',
			Item = "lsd_vial_six",
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.gettabs,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'gettabpaper',
            event = "md-drugs:client:buytabs",
            icon = 'fas fa-sign-in-alt',
            label = 'Buy Tabs',		
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.buylsdlabkit,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'buylabkit',
            event = "md-drugs:client:buylabkit",
            icon = 'fas fa-sign-in-alt',
            label = 'Buy Kit',		
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.dryplant,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'dryplant',
            event = "md-drugs:client:dryplant",
            icon = 'fas fa-sign-in-alt',
            label = 'Dry Out',		
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.cutheroinone,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'cutheroinone',
            event = "md-drugs:client:cutheroin",
            icon = 'fas fa-sign-in-alt',
            label = 'Cut Heroin',		
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.fillneedle,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'fillneedle',
            event = "md-drugs:client:fillneedle",
            icon = 'fas fa-sign-in-alt',
            label = 'Fill Needles',		
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.buyheroinlabkit,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'buyheroinlabkit',
            event = "md-drugs:client:buyheroinlabkit",
            icon = 'fas fa-sign-in-alt',
            label = 'Fill Needles',		
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.makecrack,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'crackmakeone',
            event = "md-drugs:client:makecrackone",
            icon = 'fas fa-sign-in-alt',
            label = 'Cook Crack',		
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.bagcrack,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'bagcrack',
            event = "md-drugs:client:bagcrack",
            icon = 'fas fa-sign-in-alt',
            label = 'Bag Crack',		
        }
    }
})

--------------
exports.ox_target:addBoxZone({
    coords = Config.isosafrole,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'stealisosafrole',
            event = "md-drugs:client:stealisosafrole",
            icon = 'fas fa-sign-in-alt',
            label = 'Steal Isosafrole',		
        }
    }
})
exports.ox_target:addBoxZone({
    coords = Config.mdp2p,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'stealmdp2p',
            event = "md-drugs:client:stealmdp2p",
            icon = 'fas fa-sign-in-alt',
            label = 'Steal mdp2p',		
        }
    }
})
 exports.ox_target:addBoxZone({
    coords = Config.rawxtcloc,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
            name = 'makingrawxtc',
            event = "md-drugs:client:makingrawxtc",
            icon = 'fas fa-sign-in-alt',
            label = 'Make Raw XTC',		
        }
    }
})
 exports.ox_target:addBoxZone({
    coords = Config.makeunstampedwhite,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
			num = 1,
            name = 'makingrawxtc',
            event = "md-drugs:client:makextcsingle",
            icon = 'fas fa-sign-in-alt',
            label = 'Make White Single Stack',		
			item = "singlepress",
        },
		{ 
			num = 2,
			name = "makeunstampedwhite2",
			event = "md-drugs:client:makextcdual",
			icon = 'fas fa-eye',
			label = 'Make White dual Stack', 
			targeticon = 'fas fa-eye', 
			item = "dualpress",
		},
		{ 
			num = 3,
			name = "makeunstampedwhite3",
			event = "md-drugs:client:makextctriple",
			icon = 'fas fa-eye',
			label = 'Make White Triple Stack', 
			targeticon = 'fas fa-eye', 
			item = "triplepress",
		},
		{ 
			num = 4,
			name = "makeunstampedwhite4",
			event = "md-drugs:client:makextcquad",
			icon = 'fas fa-eye',
			label = 'Make White Quad Stack', 
			targeticon = 'fas fa-eye', 
			item = "quadpress",
		},
		
		
    }
})

 exports.ox_target:addBoxZone({
    coords = Config.makeunstampedred,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
			num = 1,
            name = 'makeunstampedred1',
            event = "md-drugs:client:makeredxtcsingle",
            icon = 'fas fa-sign-in-alt',
            label = 'Make Red Single Stack',		
			item = "singlepress",
        },
		{ 
			num = 2,
			name = "makeunstampedred2",
			event = "md-drugs:client:makeredxtcdual",
			icon = 'fas fa-eye',
			label = 'Make Red dual Stack', 
			targeticon = 'fas fa-eye', 
			item = "dualpress",
		},
		{ 
			num = 3,
			name = "makeunstampedred3",
			event = "md-drugs:client:makeredxtctriple",
			icon = 'fas fa-eye',
			label = 'Make Red Triple Stack', 
			targeticon = 'fas fa-eye', 
			item = "triplepress",
		},
		{ 
			num = 4,
			name = "makeunstampedred4",
			event = "md-drugs:client:makeredxtcquad",
			icon = 'fas fa-eye',
			label = 'Make Red Quad Stack', 
			targeticon = 'fas fa-eye', 
			item = "quadpress",
		},
		
		
    }
})
 exports.ox_target:addBoxZone({
    coords = Config.makeunstampedorange,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
			num = 1,
            name = 'makeunstampedorange1',
            event = "md-drugs:client:makeorangextcsingle",
            icon = 'fas fa-sign-in-alt',
            label = 'Make Orange Single Stack',		
			item = "singlepress",
        },
		{ 
			num = 2,
			name = "makeunstampedorange2",
			event = "md-drugs:client:makeorangextcdual",
			icon = 'fas fa-eye',
			label = 'Make Orange dual Stack', 
			targeticon = 'fas fa-eye', 
			item = "dualpress",
		},
		{ 
			num = 3,
			name = "makeunstampedorange3",
			event = "md-drugs:client:makeredorangetriple",
			icon = 'fas fa-eye',
			label = 'Make Orange Triple Stack', 
			targeticon = 'fas fa-eye', 
			item = "triplepress",
		},
		{ 
			num = 4,
			name = "makeunstampedorange4",
			event = "md-drugs:client:makeredorangequad",
			icon = 'fas fa-eye',
			label = 'Make Orange Quad Stack', 
			targeticon = 'fas fa-eye', 
			item = "quadpress",
		},
		
		
    }
})
 exports.ox_target:addBoxZone({
    coords = Config.makeunstampedblue,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
			num = 1,
            name = 'makeunstampedblue1',
            event = "md-drugs:client:makebluextcsingle",
            icon = 'fas fa-sign-in-alt',
            label = 'Make blue Single Stack',		
			item = "singlepress",
        },
		{ 
			num = 2,
			name = "makeunstampedblue2",
			event = "md-drugs:client:makebluextcdual",
			icon = 'fas fa-eye',
			label = 'Make blue dual Stack', 
			targeticon = 'fas fa-eye', 
			item = "dualpress",
		},
		{ 
			num = 3,
			name = "makeunstampedblue3",
			event = "md-drugs:client:makeredbluetriple",
			icon = 'fas fa-eye',
			label = 'Make blue Triple Stack', 
			targeticon = 'fas fa-eye', 
			item = "triplepress",
		},
		{ 
			num = 4,
			name = "makeunstampedblue4",
			event = "md-drugs:client:makeredbluequad",
			icon = 'fas fa-eye',
			label = 'Make blue Quad Stack', 
			targeticon = 'fas fa-eye', 
			item = "quadpress",
		},
		
		
    }
})

 exports.ox_target:addBoxZone({
    coords = Config.stamp,
    size  = vec3(2, 2, 2),
	rotation = 45,
    options = {
        {
			num = 1,
            name = 'stampwhite',
            event = "md-drugs:client:stampwhite",
            icon = 'fas fa-sign-in-alt',
            label = 'Stamp White',		
			
        },
		{ 
			num = 2,
			name = "StampRed",
			event = "md-drugs:client:stampred",
			icon = 'fas fa-eye',
			label = 'Stamp Red', 
			targeticon = 'fas fa-eye', 
			
		},
		{ 
			num = 3,
			name = "StampBlue",
			event = "md-drugs:client:stampblue",
			icon = 'fas fa-eye',
			label = 'Stamp Blue', 
			targeticon = 'fas fa-eye', 
			
		},
		{ 
			num = 4,
			name = "stamporange",
			event = "md-drugs:client:stamporange",
			icon = 'fas fa-eye',
			label = 'Stamp Orange', 
			targeticon = 'fas fa-eye', 
			
		},
		
		
    }
})

end)


