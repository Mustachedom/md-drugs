QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
	if Config.Crafting then
	for k, v in pairs (Config.Craftinglocation) do 
		if v.job == "" or v.job == '' or v.job == nil then 
			v.job = 1
		end
		if v.gang == "" or v.gang == '' or v.gang == nil then 
			v.gang = 1
		end
		if v.targetlabel == '' or v.targetlabel == "" or v.targetlabel == nil then
			v.targetlabel = 'Craft'
		end
		if v.icon == '' or v.icon == "" or v.icon == nil then
			v.icon = "fa-solid fa-hammer"
		end	
		exports['qb-target']:AddBoxZone("mdcraft" .. k,v.location,1.5, 1.75, { 
		name = "mdcraft"..k,
		heading = 156.0,
		debugPoly = false,
		minZ = v.location.z-2,
		maxZ = v.location.z+2,
	}, {
		options = {
			{
				icon = v.icon,
				label = v.targetlabel,
				event = 'md-drugs:client:craftingmenu',
				craft = v.Craftstation,
				canInteract = function()
					if QBCore.Functions.GetPlayerData().job.name == v.job or v.job == 1 and QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1  then 
						return true end
					end,	
	
			},
			
		},
	})
end
end
end)

RegisterNetEvent("md-drugs:client:craftingmenu", function(data) 
	local craftingmenu = {}
	local text = ""
	local headertext = ""
	local desc = ""
	if Config.Oxmenu then
		for k, v in pairs (data.craft) do 
			if v.requireditem == '' or v.requireditem == "" or v.requireditem == nil then 
				text = v.ingredienttext
			else
				text = v.ingredienttext .. " Needs: " .. v.requireditem .. ""
			end
			if v.amount == '' or v.amount == "" or v.amount == nil then 
				headertext = QBCore.Shared.Items[k].label
			else
				headertext = QBCore.Shared.Items[k].label .. " X " .. v.amount
			end	
			Wait(0)
			craftingmenu[#craftingmenu + 1] = {
			icon = "nui://".."ps-inventory/html/images/"..QBCore.Shared.Items[k].image,
			header = k,
			title = headertext,
			description = text,
			event = "md-drugs:client:craft",
			args = {
				table = data.craft,
				item = k,
				skillxp = v.skillxp,
				xp = v.xp,
				recipe = v.recipe,
				text = v.ingredienttext,
				max = v.max,
				success = v.successchance,
				skill = v.skill,
				emote = v.emote,
				lvlreq = v.lvlreq,
				animtime = v.animtime,
				requireditem = v.requireditem,
				amount = v.amount,
				progressbar = v.progressbar,

				}
			}	
			lib.registerContext({id = 'craftingmenu',title = "Mining Crafting", options = craftingmenu})
			lib.showContext('craftingmenu')
			
		end
	else
		for k, v in pairs (data.craft) do 
			if v.requireditem == '' or v.requireditem == "" or v.requireditem == nil then 
				text = v.ingredienttext
			else
				text = v.ingredienttext .. " Needs: " .. v.requireditem .. ""
			end
			if v.amount == '' or v.amount == "" or v.amount == nil then 
				headertext = QBCore.Shared.Items[k].label
			else
				headertext = QBCore.Shared.Items[k].label .. " X " .. v.amount
			end	
    		craftingmenu[#craftingmenu + 1] = {
			icon = "nui://".."ps-inventory/html/images/"..QBCore.Shared.Items[k].image,
			header = headertext,
			txt =  text,
			params = {
				event = "md-drugs:client:craft",
				args = {
					table = data.craft,
					item = k,
					skillxp = v.skillxp,
  		          	xp = v.xp,
					recipe = v.recipe,
					text = v.ingredienttext,
					max = v.max,
					success = v.successchance,
					skill = v.skill,
					emote = v.emote,
					lvlreq = v.lvlreq,
					animtime = v.animtime,
					requireditem = v.requireditem,
					amount = v.amount,
					progressbar = v.progressbar,
					}
				}
			}	
		end
		exports['qb-menu']:openMenu(craftingmenu)
	end	
	
end)	

RegisterNetEvent("md-drugs:client:craft", function(data)
if data.lvlreq == nil then data.lvlreq = 0 end
if data.max == nil then data.max = 1 end
if data.animtime == nil then data.animtime = 4000 end
if data.skill == nil then data.skill = 'drugprocessing' end
if data.skillxp == nil then data.skillxp = 'drugprocessingxp' end
if data.xp == nil then data.xp = Config.defaultxp end
if data.success == nil then data.success = 100 end
if data.amount == nil then data.amount = 1 end
if data.progressbar == nil then data.progressbar = "Crafting" end
local progressbarlabel = data.progressbar
local lvl = QBCore.Functions.GetPlayerData().metadata[data.skill]
if QBCore.Functions.GetPlayerData().items == data.requireditem or data.requireditem == nil then
if lvl >= data.lvlreq then	
	if Config.Oxmenu then 
		local dialog = exports.ox_lib:inputDialog(QBCore.Shared.Items[data.item].label .."!",   {
			{ type = 'number', label = data.text,  min = 0, max = data.max, default = 1 },
			})
			if data.emote == nil then 
				TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"}) 
			else	
				TriggerEvent('animations:client:EmoteCommandStart', {data.emote}) 
			end	
			QBCore.Functions.Progressbar("pick_cane"," ".. progressbarlabel.. "!", data.animatime, false, true, {
				disableMovement = true, 
				disableCarMovement = true, 
				disableMouse = false, 
				disableCombat = true, 
				 },{},{}, {}, function()
				ClearPedTasks(PlayerPedId())
				TriggerServerEvent("md-drugs:server:crafting2", dialog[1], data.item, data.xp, data.success, data.table, data.skillxp, data.skill, data.amount)
			end)
	else		
		local dialog = exports['qb-input']:ShowInput({
				header = QBCore.Shared.Items[data.item].label,
				submitText = "Amount To Make",
				inputs = {
				{
					text = "Max Of " .. data.max,
	                name = "number",
	                type = "number",
	                isRequired = true,
					min = 0,
					max = data.max,
				}
			}
			})
			if tonumber(dialog.number) > data.max then 
				dialog.number = data.max
			end	
			if data.emote == nil then 
				TriggerEvent('animations:client:EmoteCommandStart', {"uncuff"}) 
			else	
				TriggerEvent('animations:client:EmoteCommandStart', {data.emote}) 
			end	
			QBCore.Functions.Progressbar("pick_cane", " ".. progressbarlabel.. "!", data.animtime, false, true, {
				disableMovement = true, 
				disableCarMovement = true, 
				disableMouse = false, 
				disableCombat = true, 
				 },{},{}, {}, function()
				ClearPedTasks(PlayerPedId())
				TriggerServerEvent("md-drugs:server:crafting2", tonumber(dialog.number), data.item, data.xp, data.success, data.table, data.skillxp, data.skill, data.amount  )
			end)
		end
	else
		QBCore.Functions.Notify("You Need To Be Level " .. data.lvlreq .. " In " .. data.skill .. " To Craft This")
	end
end	
end)