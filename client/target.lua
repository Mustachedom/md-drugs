local QBCore = exports['qb-core']:GetCoreObject()
local icon = "fa solid fa-eye"

CreateThread(function()
	local config = lib.callback.await('md-drugs:server:getLocs', false) 
	if not config then return end
	AddBoxZoneSingle('telecokein', 	     config.singleSpot.CokeTeleIn, 	{action = function()tele(config.singelSpot.CokeTeleOut)end,  icon = 'fa-solid fa-door-open', label = Lang.targets.coke.enter}) -- coke
	AddBoxZoneSingle('telecokeout', 	 config.singleSpot.CokeTeleOut, {action = function()tele(config.singelSpot.CokeTeleIn) end,  icon = "fa-solid fa-door-closed", label = Lang.targets.coke.exit}) -- coke
	AddBoxZoneMulti('makepowder', 		 config.MakePowder, 	        {event = "md-drugs:client:makepowder",			  icon = "fa-solid fa-scissors", label = Lang.targets.coke.chop}) -- coke
	AddBoxZoneMulti('steallysergic', 	 config.lysergicacid, 	        {event = "md-drugs:client:getlysergic",			  icon = icon, label = Lang.targets.lsd.lys}) -- lsd
	AddBoxZoneMulti('stealdiethylamide', config.diethylamide, 	        {event = "md-drugs:client:getdiethylamide",		  icon = icon, label = Lang.targets.lsd.die}) -- lsd
	AddBoxZoneMulti('gettabs', 			 config.gettabs, 	            {event = "md-drugs:client:buytabs",				  icon = icon, label = Lang.targets.lsd.buyt}) -- lsd
	AddBoxZoneMulti('dryheroin', 		 config.dryplant, 		        {event = "md-drugs:client:dryplant",			  icon = icon, label = Lang.targets.heroin.dry}) -- heroin
	AddBoxZoneMulti('cutheroin', 		 config.cutheroinone, 	        {event = "md-drugs:client:cutheroin",			  icon = icon, label = Lang.targets.heroin.cut}) -- heroin
	AddBoxZoneMulti('fillneedle', 		 config.fillneedle, 	        {event = "md-drugs:client:fillneedle",			  icon = icon, label = Lang.targets.heroin.fill}) -- heroin
	AddBoxZoneMulti('makecrack', 		 config.makecrack, 		        {event = "md-drugs:client:makecrackone",		  icon = icon, label = Lang.targets.crack.cook}) -- crack
	AddBoxZoneMulti('bagcrack', 		 config.bagcrack, 		        {event = "md-drugs:client:bagcrack",			  icon = icon, label = Lang.targets.crack.bag}) -- crack
	AddBoxZoneMulti('fillprescription',  config.FillPrescription,       {event = "md-drugs:client:fillprescription",	  icon = icon, label = Lang.targets.pha.fill}) -- pharma
	AddBoxZoneSingle('payfortruck', 	 config.singleSpot.Payfortruck, {event = "md-drugs:client:GetOxyCar",			  icon = icon, label = Lang.targets.oxy.pay}) -- oxy runs
	AddBoxZoneSingle('drymescaline', 	 config.singleSpot.DryOut, 		{event = "md-drugs:client:drymescaline",		  icon = icon, label = Lang.targets.mescaline.dry}) -- mescaline
	AddBoxZoneMulti('stealisosafrole', 	 config.isosafrole, 	        {event = "md-drugs:client:stealisosafrole",		  icon = icon, label = Lang.targets.xtc.iso}) -- xtc
	AddBoxZoneMulti('stealmdp2p', 	     config.mdp2p, 			        {event = "md-drugs:client:stealmdp2p",			  icon = icon, label = Lang.targets.xtc.mdp}) -- xtc
	AddBoxZoneMulti('rawxtcloc', 		 config.rawxtcloc, 		        {event = "md-drugs:client:makingrawxtc",		  icon = icon, label = Lang.targets.xtc.raw}) -- xtc
	AddBoxZoneSingle('buypress', 		 config.singleSpot.buypress,    {event = "md-drugs:client:buypress",			  icon = icon, label = Lang.targets.xtc.press}) -- xtc
	AddBoxZoneMulti('stamp', 			 config.stamp, 	          		{event = "md-drugs:client:stampwhite",   		  icon = icon, label = Lang.targets.xtc.stamp}) -- xtc
end)
