local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	AddBoxZoneMulti('makepowder', Config.MakePowder, {	type = "client",	event = "md-drugs:client:makepowder",	icon = "fas fa-sign-in-alt",	label = "chop it up"}) -- coke
	AddBoxZoneSingle('telecokein', Config.CokeTeleIn, {name = 'teleout',icon = "fas fa-sign-in-alt",label = "Enter Building",action = function()	 tele(Config.CokeTeleOut) end,}) -- coke
	AddBoxZoneSingle('telecokeout', Config.CokeTeleOut, {name = 'teleout',icon = "fas fa-sign-in-alt",label = "Exit Building",action = function()	 tele(Config.CokeTeleIn) end,}) -- coke
	AddBoxZoneMulti('steallysergic', Config.lysergicacid, {	type = "client",	event = "md-drugs:client:getlysergic",	icon = "fas fa-sign-in-alt",	label = "stealing Lysergic"}) -- lsd
	AddBoxZoneMulti('stealdiethylamide', Config.diethylamide, {type = "client",	event = "md-drugs:client:getdiethylamide",	icon = "fas fa-sign-in-alt",	label = "stealing Diethylamide"}) -- lsd
	AddBoxZoneMulti('gettabs', Config.gettabs, {type = "client",	event = "md-drugs:client:buytabs",	icon = "fas fa-sign-in-alt",	label = "Buy Tabs"}) -- lsd
	AddBoxZoneMulti('dryheroin', Config.dryplant, {type = "client",event = "md-drugs:client:dryplant",	icon = "fas fa-sign-in-alt",	label = "Dry Poppies"}) -- heroin
	AddBoxZoneMulti('cutheroin', Config.cutheroinone, {type = "client", event = "md-drugs:client:cutheroin",	icon = "fas fa-sign-in-alt",	label = "Cut Heroin"}) -- heroin
	AddBoxZoneMulti('fillneedle', Config.fillneedle, {type = "client", event = "md-drugs:client:fillneedle",	icon = "fas fa-sign-in-alt",	label = "Fill Needles"}) -- heroin
	AddBoxZoneMulti('makecrack', Config.makecrack, {type = "client", event = "md-drugs:client:makecrackone",	icon = "fas fa-sign-in-alt",	label = "Cook Crack"}) -- crack
	AddBoxZoneMulti('bagcrack', Config.bagcrack, {type = "client", event = "md-drugs:client:bagcrack",	icon = "fas fa-sign-in-alt",	label = "Bag Crack"}) -- crack
	AddBoxZoneMulti('fillprescription', Config.FillPrescription, {type = "client", event = "md-drugs:client:fillprescription",	icon = "fas fa-sign-in-alt",	label = "Fill Prescription"}) -- pharma
	AddBoxZoneSingle('payfortruck', Config.Payfortruck, {	event = "md-drugs:client:GetOxyCar",	icon = "fas fa-sign-in-alt",	label = "Pay For Truck"}) -- oxy runs
	AddBoxZoneSingle('drymescaline', Config.DryOut, {	type = "client",	event = "md-drugs:client:drymescaline",	icon = "fas fa-sign-in-alt",	label = "Dry Out"}) -- mescaline
	AddBoxZoneMulti('stealisosafrole', Config.isosafrole, {type = "client", event = "md-drugs:client:stealisosafrole",	icon = "fas fa-sign-in-alt",	label = "Steal Isosafrole"}) -- xtc
	AddBoxZoneMulti('stealmdp2p', Config.mdp2p, {type = "client", event = "md-drugs:client:stealmdp2p",	icon = "fas fa-sign-in-alt",	label = "Steal MDP2P"}) -- xtc
	AddBoxZoneMulti('rawxtcloc', Config.rawxtcloc, {type = "client", event = "md-drugs:client:makingrawxtc",	icon = "fas fa-sign-in-alt",	label = "Make Raw XTC"}) -- xtc
	AddBoxZoneSingle('buypress', Config.buypress, {	type = "client",event = "md-drugs:client:buypress",	icon = 'fas fa-eye',	label = 'Buy Press'}) -- xtc
	AddBoxZoneMulti('stamp', Config.stamp, {type = "client", event = "md-drugs:client:stampwhite",   icon = 'fas fa-eye',    label = 'Stamp Pills'}) -- xtc
end)
