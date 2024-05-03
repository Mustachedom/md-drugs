local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()

if Config.oxtarget then
	coketelein = exports.ox_target:addBoxZone({ coords = Config.CokeTeleIn, size = vec(1,1,3), rotation = 0, debug = false,
	options = {
		{name = 'teleout',icon = "fas fa-sign-in-alt",label = "Enter Building",distance = 5,
			onSelect = function()
				DoScreenFadeOut(500)
				Wait(1000)
				SetEntityCoords(PlayerPedId(),Config.CokeTeleOut.x, Config.CokeTeleOut.y, Config.CokeTeleOut.z)
				Wait(1000)
				DoScreenFadeIn(500)
			end
		},
	},
	})
	coketeleout = exports.ox_target:addBoxZone({ coords = Config.CokeTeleOut, size = vec(1,1,3), rotation = 0, debug = false,
	options = {
			{name = 'teleout',icon = "fas fa-sign-in-alt",label = "Exit Building",distance = 5,
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
else
	exports['qb-target']:AddBoxZone("coketelein",Config.CokeTeleIn,1.5, 1.75, { name = "coketelein",heading = 156.0,debugPoly = false,minZ = Config.CokeTeleIn.z-2,maxZ = Config.CokeTeleIn.z+2,}, {
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
	exports['qb-target']:AddBoxZone("CokeTeleOut",Config.CokeTeleOut,1.5, 1.75, {name = "CokeTeleOut",heading = 156.0,debugPoly = false,minZ = Config.CokeTeleOut.z-2,maxZ = Config.CokeTeleOut.z+2,}, {
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
end	
	-- cocaine ( Bagging and Cutting is in Cocaine.lua due to globals used :))
	for k, v in pairs (Config.MakePowder) do 
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		 local options = {
			{	type = "client",	event = "md-drugs:client:makepowder",	icon = "fas fa-sign-in-alt",	label = "chop it up", data = k,  distance = 2.0,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			},
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("makepowder"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="makepowder"..k, heading = 156.0,minZ = v.loc.z-1, maxZ = v.loc.z+1, }, {options = options, distance = 1.5})
		end
	end
	------------- lsd
	for k, v in pairs (Config.lysergicacid) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:getlysergic",	icon = "fas fa-sign-in-alt",	label = "stealing", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false, rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("getlysergic"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="getlysergic"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.diethylamide) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:getdiethylamide",	icon = "fas fa-sign-in-alt",	label = "stealing", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("getdiethylamide"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="getdiethylamide"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.gettabs) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:buytabs",	icon = "fas fa-sign-in-alt",	label = "Buy Tabs", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("buytabs"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="buytabs"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	------ heroin
	for k, v in pairs (Config.dryplant) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:dryplant",	icon = "fas fa-sign-in-alt",	label = "Dry Poppies", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("dryplant"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="dryplant"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.cutheroinone) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:cutheroin",	icon = "fas fa-sign-in-alt",	label = "Cut Heroin", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("cutheroin"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="cutheroin"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.fillneedle) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:fillneedle",	icon = "fas fa-sign-in-alt",	label = "Fill Needles", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("fillneedle"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="fillneedle"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	------- crack
	for k, v in pairs (Config.makecrack) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:makecrackone",	icon = "fas fa-sign-in-alt",	label = "Cook Crack", data = k, distance = 2.0,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("makecrackone"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="makecrackone"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.bagcrack) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:bagcrack",	icon = "fas fa-sign-in-alt",	label = "Bag Crack", data = k, distance = 2.0,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("bagcrack"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="bagcrack"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	------- pharma
	for k, v in pairs (Config.FillPrescription) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:fillprescription",	icon = "fas fa-sign-in-alt",	label = "Fill Prescription", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("fillprescription"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="fillprescription"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	-------- oxy runs
	local options2 = {
		{	event = "md-drugs:client:getoxytruck",	icon = "fas fa-sign-in-alt",	label = "Pay For Truck",},
	}
	if Config.oxtarget then
		exports.ox_target:addBoxZone({coords = Config.Payfortruck, size = vec3(1,1,1),debugPoly = false,rotation = 90.0, options = options2,})
	else
		exports['qb-target']:AddBoxZone("payfortruck" ,Config.Payfortruck, 1.0, 1.0, {name ="payfortruck", heading = 156.0,minZ = Config.Payfortruck.z-2, maxZ = Config.Payfortruck.z+2, }, {options = options2, distance = 1.5})	
	end
	------------ mescaline
	local options3 = {
		{	type = "client",	event = "md-drugs:client:drymescaline",	icon = "fas fa-sign-in-alt",	label = "Dry Out"},
	}
	if Config.oxtarget then
		exports.ox_target:addBoxZone({coords = Config.DryOut, size = vec3(1,1,1),debugPoly = false,rotation = 90.0, options = options3,})
	else
		exports['qb-target']:AddBoxZone("DryOut" ,Config.DryOut, 1.0, 1.0, {name ="DryOut", heading = 156.0,minZ = Config.DryOut.z-2, maxZ = Config.DryOut.z+2, }, {options = options3, distance = 1.5})	
	end
	------ XTC
	for k, v in pairs (Config.isosafrole) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:stealisosafrole",	icon = "fas fa-sign-in-alt",	label = "Steal Isosafrole", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("stealisosafrole"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="stealisosafrole"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	for k, v in pairs (Config.mdp2p) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:stealmdp2p",	icon = "fas fa-sign-in-alt",	label = "Steal MDP2P", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("stealmdp2p"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="stealmdp2p"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end

	for k, v in pairs (Config.rawxtcloc) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{	type = "client",	event = "md-drugs:client:makingrawxtc",	icon = "fas fa-sign-in-alt",	label = "Make Raw XTC", data = k,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
			}
		}
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("makingrawxtc"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="makingrawxtc"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end
	local options4 = {
		{	type = "client",	event = "md-drugs:client:buypress",	icon = 'fas fa-eye',	label = 'Buy Press',},
	}
	if Config.oxtarget then
		exports.ox_target:addBoxZone({ coords = Config.buypress, size = vec3(2,2,2), debugPoly = false, rotation = 45, options = options4})
	else
		exports['qb-target']:AddBoxZone("buypress" ,Config.buypress, 1.0, 1.0, {name ="buypress", heading = 156.0,minZ = Config.buypress.z-2, maxZ = Config.buypress.z+2, }, {options = options4, distance = 1.5})	
	end
	for k, v in pairs(Config.stamp) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		local options = {
			{type = "client",   event = "md-drugs:client:stampwhite",   icon = 'fas fa-eye',    label = 'Stamp Pills',	data = k, canInteract = function() if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end },
			
		}
	
		if Config.oxtarget then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1),debugPoly = false,rotation = v.rot, options = options,})
		else
			exports['qb-target']:AddBoxZone("stampxtc"..k ,vector3(v.loc.x, v.loc.y, v.loc.z), v.l, v.w, {name ="stampxtc"..k, heading = 156.0,minZ = v.loc.z-2, maxZ = v.loc.z+2, }, {options = options, distance = 1.5})	
		end
	end	

end)
