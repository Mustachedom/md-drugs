local QBCore = exports['qb-core']:GetCoreObject()
local icon = "fa solid fa-eye"
CreateThread(function()
	AddBoxZoneSingle('telecokein', 	     Config.CokeTeleIn, 	  {action = function()tele(Config.CokeTeleOut)end,  icon = 'fa-solid fa-door-open', label = Lang.targets.coke.enter}) -- coke
	AddBoxZoneSingle('telecokeout', 	 Config.CokeTeleOut, 	  {action = function()tele(Config.CokeTeleIn) end,  icon = "fa-solid fa-door-closed", label = Lang.targets.coke.exit}) -- coke
	AddBoxZoneMulti('makepowder', 		 Config.MakePowder, 	  {event = "md-drugs:client:makepowder",			icon = "fa-solid fa-scissors", label = Lang.targets.coke.chop}) -- coke
	AddBoxZoneMulti('steallysergic', 	 Config.lysergicacid, 	  {event = "md-drugs:client:getlysergic",			icon = icon, label = Lang.targets.lsd.lys}) -- lsd
	AddBoxZoneMulti('stealdiethylamide', Config.diethylamide, 	  {event = "md-drugs:client:getdiethylamide",		icon = icon, label = Lang.targets.lsd.die}) -- lsd
	AddBoxZoneMulti('gettabs', 			 Config.gettabs, 	      {event = "md-drugs:client:buytabs",				icon = icon, label = Lang.targets.lsd.buyt}) -- lsd
	AddBoxZoneMulti('dryheroin', 		 Config.dryplant, 		  {event = "md-drugs:client:dryplant",				icon = icon, label = Lang.targets.heroin.dry}) -- heroin
	AddBoxZoneMulti('cutheroin', 		 Config.cutheroinone, 	  {event = "md-drugs:client:cutheroin",				icon = icon, label = Lang.targets.heroin.cut}) -- heroin
	AddBoxZoneMulti('fillneedle', 		 Config.fillneedle, 	  {event = "md-drugs:client:fillneedle",			icon = icon, label = Lang.targets.heroin.fill}) -- heroin
	AddBoxZoneMulti('makecrack', 		 Config.makecrack, 		  {event = "md-drugs:client:makecrackone",			icon = icon, label = Lang.targets.crack.cook}) -- crack
	AddBoxZoneMulti('bagcrack', 		 Config.bagcrack, 		  {event = "md-drugs:client:bagcrack",				icon = icon, label = Lang.targets.crack.bag}) -- crack
	AddBoxZoneMulti('fillprescription',  Config.FillPrescription, {event = "md-drugs:client:fillprescription",		icon = icon, label = Lang.targets.pha.fill}) -- pharma
	AddBoxZoneSingle('payfortruck', 	 Config.Payfortruck, 	  {event = "md-drugs:client:GetOxyCar",				icon = icon, label = Lang.targets.oxy.pay}) -- oxy runs
	AddBoxZoneSingle('drymescaline', 	 Config.DryOut, 		  {event = "md-drugs:client:drymescaline",			icon = icon, label = Lang.targets.mescaline.dry}) -- mescaline
	AddBoxZoneMulti('stealisosafrole', 	 Config.isosafrole, 	  {event = "md-drugs:client:stealisosafrole",		icon = icon, label = Lang.targets.xtc.iso}) -- xtc
	AddBoxZoneMulti('stealmdp2p', 	     Config.mdp2p, 			  {event = "md-drugs:client:stealmdp2p",			icon = icon, label = Lang.targets.xtc.mdp}) -- xtc
	AddBoxZoneMulti('rawxtcloc', 		 Config.rawxtcloc, 		  {event = "md-drugs:client:makingrawxtc",			icon = icon, label = Lang.targets.xtc.raw}) -- xtc
	AddBoxZoneSingle('buypress', 		 Config.buypress, 		  {event = "md-drugs:client:buypress",				icon = icon, label = Lang.targets.xtc.press}) -- xtc
	AddBoxZoneMulti('stamp', 			 Config.stamp, 	          {event = "md-drugs:client:stampwhite",   			icon = icon, label = Lang.targets.xtc.stamp}) -- xtc
end)
