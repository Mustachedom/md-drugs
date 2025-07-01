local QBCore = exports['qb-core']:GetCoreObject()

local progressbartype = Config.progressbartype 
local minigametype = Config.minigametype
local notifytype = Config.Notify 
local dispatch = Config.Dispatch

function getJobType()
	return QBCore.Functions.GetPlayerData().job.type
end

function getJobName()
	return QBCore.Functions.GetPlayerData().job.name
end

function progressbar(text, time, anim)
	TriggerEvent('animations:client:EmoteCommandStart', {anim}) 
	if progressbartype == 'oxbar' then 
	  if lib.progressBar({ duration = time, label = text, useWhileDead = false, canCancel = true, disable = { car = true, move = true},}) then 
		if GetResourceState('scully_emotemenu') == 'started' then
			exports.scully_emotemenu:cancelEmote()
		else
			TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		end
		return true
	  end	 
	elseif progressbartype == 'oxcir' then
	  if lib.progressCircle({ duration = time, label = text, useWhileDead = false, canCancel = true, position = 'bottom', disable = { car = true,move = true},}) then 
		if GetResourceState('scully_emotemenu') == 'started' then
			exports.scully_emotemenu:cancelEmote()
		else
			TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		end
		return true
	  end
	elseif progressbartype == 'qb' then
	local test = false
		local cancelled = false
	  QBCore.Functions.Progressbar("drink_something", text, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, disableInventory = true,
	  }, {}, {}, {}, function()-- Done
		test = true
		if GetResourceState('scully_emotemenu') == 'started' then
			exports.scully_emotemenu:cancelEmote()
		else
			TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		end
	  end, function()
		cancelled = true
		if GetResourceState('scully_emotemenu') == 'started' then
			exports.scully_emotemenu:cancelEmote()
		else
			TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		end
	end)
	  repeat 
		Wait(100)
	  until cancelled or test
	  if test then return true end
	else
			print"^1 SCRIPT ERROR: Md-DRUGS set your progressbar with one of the options!"
	end	  
  end

function loadParticle(dict)
    if not HasNamedPtfxAssetLoaded(dict) then
        RequestNamedPtfxAsset(dict)
    end
    while not HasNamedPtfxAssetLoaded(dict) do
        Wait(0)
    end
    SetPtfxAssetNextCall(dict)
end

function LoadModel(hash)
	RequestModel(hash)
	while not HasModelLoaded(hash)  do
		Wait(0)
	end
end

function minigame()
	local time = 0
	local game = Config.Minigames
	if minigametype == 'ps_circle' then
		local check 
		exports['ps-ui']:Circle(function(success)
			check = success
		end, game['ps_circle'].amount, game['ps_circle'].speed) 
		return check
	elseif minigametype == 'ps_maze' then
	   local check 
	   exports['ps-ui']:Maze(function(success)
		   check = success
	   end, game['ps_maze'].timelimit)
	   repeat Wait(10) until check ~= nil
	   return check
   elseif minigametype == 'ps_scrambler' then
	   local check 
	   exports['ps-ui']:Scrambler(function(success)
		   check = success
	   end, game['ps_scrambler'].type,  game['ps_scrambler'].time, game['ps_scrambler'].mirrored)
	   repeat Wait(10) until check ~= nil
	   return check
   elseif minigametype == 'ps_var' then
	   local check 
	   exports['ps-ui']:VarHack(function(success)
		   check = success
	   end, game['ps_var'].numBlocks,  game['ps_var'].time)
	   repeat Wait(10) until check ~= nil
	   return check
   elseif minigametype == 'ps_thermite' then
	   local check 
	   exports['ps-ui']:Thermite(function(success)
		   check = success
	   end, game['ps_thermite'].time,  game['ps_thermite'].gridsize, game['ps_thermite'].incorrect)
	   repeat Wait(10) until check ~= nil
	   return check
	elseif minigametype == 'ox' then
		local success = lib.skillCheck(game['ox'], {'1', '2', '3', '4'})
		return success 
	elseif minigametype == 'blcirprog' then
		local success = exports.bl_ui:CircleProgress(game['blcirprog'].amount, game['blcirprog'].speed)
		return success
	elseif minigametype == 'blprog' then
		local success = exports.bl_ui:Progress(game['blprog'].amount, game['blprog'].speed)
		return success
	elseif minigametype == 'blkeyspam' then
		local success = exports.bl_ui:KeySpam(game['blkeyspam'].amount, game['blprog'].difficulty)
		return success
	elseif minigametype == 'blkeycircle' then
		local success = exports.bl_ui:KeyCircle(game['blkeycircle'].amount, game['blkeycircle'].difficulty, game['blkeycircle'].keynumbers)
		return success	
	elseif minigametype == 'blnumberslide' then
		local success = exports.bl_ui:NumberSlide(game['blnumberslide'].amount, game['blnumberslide'].difficulty, game['blnumberslide'].keynumbers)
		return success	
	elseif minigametype == 'blrapidlines' then
		local success = exports.bl_ui:RapidLines(game['blrapidlines'].amount, game['blrapidlines'].difficulty, game['blrapidlines'].numberofline)
		return success	
	elseif minigametype == 'blcircleshake' then
		local success = exports.bl_ui:CircleShake(game['blcircleshake'].amount, game['blcircleshake'].difficulty, game['blcircleshake'].stages)
		return success	
	elseif minigametype == 'glpath' then 
		local settings = {gridSize = game['glpath'].gridSize, lives = game['glpath'].lives, timeLimit = game['glpath'].timelimit}
		local successes = false
		 exports["glow_minigames"]:StartMinigame(function(success)
			 if success then successes = true else successes = false  end
		 end, "path", settings)
		 repeat
			Wait(1000)
			time = time + 1
		 until successes or time == 100
		 if successes then return true end
	elseif minigametype == 'glspot' then
		local settings = {gridSize = game['glspot'].gridSize, timeLimit = game['glspot'].gridSize, charSet =  game['glspot'].charSet, required = game['glspot'].required}
		local successes = false
		exports["glow_minigames"]:StartMinigame(function(success)
		   if success then successes = true else successes = false  end
		end, "spot", settings)
		repeat
		   Wait(1000)
		   time = time + 1
		until successes or time == 100
	elseif minigametype == 'glmath' then
		local settings = {timeLimit  = game['glmath'].timeLimit}
		local successes = false
		exports["glow_minigames"]:StartMinigame(function(success)
		   if success then successes = true else successes = false  end
		end, "math", settings)
		repeat
		   Wait(1000)
		   time = time + 1
		until successes or time == 100
	elseif minigametype == 'none' then 
		return true			
	else
		print"^1 SCRIPT ERROR: Md-Drugs set your minigame with one of the options!"
	end
 end

 function Notify(text, type)
	if notifytype =='ox' then
	  lib.notify({title = text, type = type})
        elseif notifytype == 'qb' then
	  QBCore.Functions.Notify(text, type)
	elseif notifytype == 'okok' then
	  exports['okokNotify']:Alert('', text, 4000, type, false)
	else
       	print"^1 SCRIPT ERROR: Md-DRUGS set your notification with one of the options!"
    end
  end

function GetImage(img)
    if GetResourceState('ox_inventory') == 'started' then
        local Items = exports['ox_inventory']:Items()
		if not Items[img] then print(' You Are Missing: ' .. img .. ' From Your ox items.lua') return end
        local itemClient = Items[img] and Items[img]['client']
        if itemClient and itemClient['image'] then
            return itemClient['image']
        else
            return "nui://ox_inventory/web/images/" .. img .. '.png'
        end
    end
    local invs = {
        ['ps-inventory'] = "nui://ps-inventory/html/images/",
        ['lj-inventory'] = "nui://lj-inventory/html/images/",
        ['qb-inventory'] = "nui://qb-inventory/html/images/",
        ['qs-inventory'] = "nui://qs-inventory/html/imgages/",
        ['origen_inventory'] = "nui://origen_inventory/html/img/",
        ['core_inventory'] = "nui://core_inventory/html/img/"
    }
    for k, v in pairs(invs) do
		if not QBCore.Shared.Items[img] then print(' You Are Missing: ' .. img .. ' From Your QB items.lua') return end
        if GetResourceState(k) == 'started' then
            return v .. QBCore.Shared.Items[img].image
        end
    end
end

function GetLabel(label)
	if GetResourceState('ox_inventory') == 'started' then
		local Items = exports['ox_inventory']:Items()
		if not Items[label] then print(' You Are Missing: ' .. label .. ' From Your ox items.lua') return end
		return Items[label]['label']
	else
		if QBCore.Shared.Items[label] == nil then print("There Is No " .. label .. " In Your QB Items.lua") return end
		return QBCore.Shared.Items[label]['label']
	end
end

function GetRep()
	local rep = lib.callback.await('md-drugs:server:GetRep', false)
	return rep
end


function sorter(sorting, value) 
	table.sort(sorting, function(a, b) return a[value] < b[value] end)
end

function makeMenu(name, rep)
	local menu = {}
	local data = lib.callback.await('md-drugs:server:menu', false, name)
	for k, v in pairs (data.table) do
		local allow = false
		if rep == nil then 
			allow = true
		else
			if rep.dealerrep >= v.minrep then allow = true end
		end
		if allow then 
			menu[#menu + 1] = {
				icon =  GetImage(v.name),
				description = '$'.. v.price,
				title = GetLabel(v.name),
				onSelect = function()
					local settext = "Cost: $"..v.price
					local dialog = exports.ox_lib:inputDialog(v.name .."!",   {
						{ type = 'select', label = "Payment Type", default = "cash", options = {	{ value = "cash"},	{ value = "bank"},}},
						{ type = 'number', label = "Amount to buy", description = settext, min = 0, max = v.amount, default = 1 },
					})
					if not dialog[1] then return end
					TriggerServerEvent("md-drugs:server:purchaseGoods", dialog[2], dialog[1], v.name, v.price, data.table, k)
				end,
			}
		end
	end
	sorter(menu, 'title')
	lib.registerContext({id = data.id, title = data.title, options = menu})
end


function ItemCheck(item)
	if GetResourceState('ox_inventory') == 'started' then
	    if exports.ox_inventory:GetItemCount(item) >= 1 then return true else Notify('You Need ' .. GetLabel(item) .. " !", 'error') return false end
	else
	    if QBCore.Shared.Items[item] == nil then print("There Is No " .. item .. " In Your QB Items.lua") return end
	    if QBCore.Functions.HasItem(item) then return true else Notify('You Need ' .. QBCore.Shared.Items[item].label .. " !", 'error') return false end
	end
end

function hasItem(item)
	if GetResourceState('ox_inventory') == 'started' then
		if exports.ox_inventory:GetItemCount(item) >= 1 then return true else return false end
	else
		if QBCore.Shared.Items[item] == nil then print("There Is No " .. item .. " In Your QB Items.lua") return end
		if QBCore.Functions.HasItem(item) then return true else return false end
	end
end

function ItemCheckMulti(item)
	local need = 0
	local has = 0
	for k,v in pairs (item) do 
		need = need + 1
		if GetResourceState('ox_inventory') == 'started' then
			if exports.ox_inventory:GetItemCount(v) >= 1 then has = has + 1 else Notify('You Need ' .. GetLabel(v) .. " !", 'error') end
		else
			if QBCore.Shared.Items[v] == nil then print("There Is No " .. item .. " In Your QB Items.lua") return end
			if QBCore.Functions.HasItem(v) then has = has + 1  else Notify('You Need ' .. QBCore.Shared.Items[v].label .. " !", 'error') end
		end
	end
	if need == has then 
		return true
	else
		return false
	end
end

function Email(sender, subject, message)
	if Config.Phone == 'yflip' then
		local receiver = GetPlayerServerId(PlayerId())
		local insertId, received = exports["yflip-phone"]:SendMail({
			title = subject,
			sender = sender,
			senderDisplayName = sender,
			content = message,
		}, 'phoneNumber', receiver)
	elseif Config.Phone == 'qs' then
		TriggerServerEvent('qs-smartphone:server:sendNewMail', {
   		sender = sender,
   		subject = subject,
    		message = message,
    		button = {}
		})
	else
		TriggerServerEvent('qb-phone:server:sendNewMail', {
			sender = sender,
			subject = subject,
			message = message,
		})
	end
end

function PoliceCall(chance)
	local math = math.random(1,100)
	if math <= chance then
		if dispatch == 'ps' then 
			exports['ps-dispatch']:DrugSale()
		elseif dispatch == 'cd' then
			local data = exports['cd_dispatch']:GetPlayerInfo()
			TriggerServerEvent('cd_dispatch:AddNotification', {
				job_table = {'police', }, 
				coords = data.coords,
				title = '420-69 Drug Sale',
				message = 'A '..data.sex..' robbing a store at '..data.street, 
				flash = 0,
				unique_id = data.unique_id,
				sound = 1,
				blip = { sprite = 431,  scale = 1.2,  colour = 3, flashes = false,  text = '420-69 Drug Sale', time = 5, radius = 0,}
			})
		elseif	dispatch == 'core' then
			exports['core_dispatch']:addCall("420-69", "Drugs Are Being Sold", {
				{icon="fa-ruler", info="4.5 MILES"},
				}, {GetEntityCoords(PlayerPedId())}, "police", 3000, 11, 5 )
		elseif dispatch == 'aty' then 
			exports["aty_dispatch"]:SendDispatch('Drug Sale', '420-69', 40, {'police'})
		elseif dispatch == 'qs' then
			exports['qs-dispatch']:DrugSale()
		elseif dispatch == 'codem' then
			local Data = {
				type = 'Drug Sale',
				header = 'Someone Selling Drugs',
				text = 'Hurry up and save the community',
				code = '420-69',
			}
			exports['codem-dispatch']:CustomDispatch(Data)
		else
			print('Congrats, You Choose 0 of the options :)')	
		end
	else
		return
	end
end

function GetCops(number)
	if number == 0 then return true end
	local amount = lib.callback.await('md-drugs:server:GetCoppers', false)
	if amount >= number then return true else Notify('You Need '.. number - amount .. ' More Cops To Do This', 'error')  end
end


function Freeze(entity, toggle, head)
	SetEntityInvincible(entity, toggle)
	SetEntityAsMissionEntity(entity, toggle, toggle)
    FreezeEntityPosition(entity, toggle)
    SetEntityHeading(entity, head)
	SetBlockingOfNonTemporaryEvents(entity, toggle)
end

function tele(coords) 
	DoScreenFadeOut(500)
	Wait(1000)
	SetEntityCoords(PlayerPedId(),coords.x, coords.y, coords.z)
	Wait(1000)
	DoScreenFadeIn(500)
end


function AddBoxZoneSingle(name, loc, data)
	if Config.Target == 'qb' then
		exports['qb-target']:AddBoxZone(name, loc, 1.5, 1.75, {name = name, minZ = loc.z-1,maxZ = loc.z +1}, 
		{ options = {
			{
			  type = data.type or nil, 
			  event = data.event or nil,
			  action = data.action or nil,
			  icon = data.icon or "fa-solid fa-eye", 
			  label = data.label,
			  data = data.data,
			  canInteract = data.canInteract,
			}
		},
		distance = 2.0
	 })
	elseif Config.Target == 'ox' then
		exports.ox_target:addBoxZone({coords = loc, size = vec3(1,1,1), options = {
			{
			  type = data.type or nil, 
			  event = data.event or nil,
			  onSelect = data.action or nil,
			  distance = 2.5,
			  icon = data.icon or "fa-solid fa-eye", 
			  label = data.label,
			  data = data.data,
			  canInteract = data.canInteract,
			}
		}, })
	elseif Config.Target == 'interact' then
		exports.interact:AddInteraction({
			coords = vector3(loc.x, loc.y, loc.z),
			distance = 2.5,
			interactDst = 2,
			id = name,
			options = {
				{
					type = data.type or nil, 
					event = data.event or nil,
					onSelect = data.action or nil,
					distance = 2.5,
					label = data.label,
					data = data.data,
					canInteract = data.canInteract,
				},
			}
		})
	end
end

function AddBoxZoneMulti(name, table, data)
	for k, v in pairs (table) do
		if v.gang == nil or v.gang == '' or v.gang == "" then v.gang = 1 end
		if Config.Target == 'qb' then
			exports['qb-target']:AddBoxZone(name .. k, v.loc, 1.5, 1.75, {name = name..k, minZ = v.loc.z-1.50,maxZ = v.loc.z +1.5}, 
			{ options = {
				{
				  type = data.type or nil, 
				  event = data.event or nil,
				  action = data.action or nil,
				  icon = data.icon or "fa-solid fa-eye", 
				  label = data.label,
				  data = k,
				  canInteract = data.canInteract or function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
				}
			}, 
			distance = 2.5
		 })
		elseif Config.Target == 'ox' then
			exports.ox_target:addBoxZone({coords = v.loc, size = vec3(1,1,1), options = {
				{
				  type = data.type or nil, 
				  event = data.event or nil,
				  onSelect = data.action or nil,
				  icon = data.icon or "fa-solid fa-eye", 
				  label = data.label,
				  data = k,
				  distance = 2.5,
				  canInteract = data.canInteract or function()
					if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
				}
			}, })
		elseif Config.Target == 'interact' then
			exports.interact:AddInteraction({
				coords = vector3(v.loc.x, v.loc.y, v.loc.z),
				distance = 2.5,
				interactDst = 2,
				id = name,
				options = {
					{
						type = data.type or nil, 
						event = data.event or nil,
						action = data.action or nil,
						distance = 2.5,
						label = data.label or "fa-solid fa-eye", 
						data = k,
						canInteract = data.canInteract or function()
							if QBCore.Functions.GetPlayerData().gang.name == v.gang or v.gang == 1 then return true end end
					},
				}
			})
		end
	end
end

function AddBoxZoneMultiOptions(name, loc, data) 
	local options = {}
	for k, v in pairs (data) do
		table.insert(options, {
			icon = v.icon or "fa-solid fa-eye", label = v.label, event = v.event or nil, action = v.action or nil,
			onSelect = v.action,data = v.data,canInteract = v.canInteract or nil, distance = 2.0,
		})
	end
	if Config.Target == 'qb' then
		exports['qb-target']:AddBoxZone(name , loc, 1.5, 1.75, {name = name, minZ = loc.z-1.50,maxZ = loc.z +1.5}, 
		{ options = options, distance = 2.5})
	elseif Config.Target == 'ox' then
		exports.ox_target:addBoxZone({coords = loc, size = vec3(1,1,1), options = options })
	elseif Config.Target == 'interact' then
		exports.interact:AddInteraction({coords = vector3(loc.x, loc.y, loc.z),distance = 2.5,interactDst = 2,id = name,options = options})
	end
end


function AddSingleModel(model, data, num)
	if Config.Target == 'qb' then
		exports['qb-target']:AddTargetEntity(model, {options = {
			{icon = data.icon or "fa-solid fa-eye", label = data.label, event = data.event or nil, action = data.action or nil, data = num }
		}, distance = 2.5})
	elseif Config.Target == 'ox' then
		exports.ox_target:addLocalEntity(model, {icon = data.icon, label = data.label, event = data.event or nil, onSelect = data.action or nil, data = num, distance = 2.5 })
	elseif Config.Target == 'interact' then
		exports.interact:AddLocalEntityInteraction({entity = model,offset = vec3(0.0, 0.0, 1.0),id = 'mddrugs'..model,distance = 2.5,interactDst = 2.5, options = {label = data.label, event = data.event or nil, action = data.action or nil, data = num, distance = 2.5 }})
	end
end

function AddMultiModel(model, data, num)
	local options = {}
	for k, v in pairs (data) do 
		table.insert(options, {
			icon = v.icon or "fa-solid fa-eye",  label = v.label, event = v.event or nil, action = v.action or nil,
			onSelect = v.action,data = v.data,canInteract = v.canInteract or nil, distance = 2.0,
		})
	end
	if Config.Target == 'qb' then
		exports['qb-target']:AddTargetEntity(model, {options = options, distance = 2.5})
	elseif Config.Target == 'ox' then
		exports.ox_target:addLocalEntity(model, options)
	elseif Config.Target == 'interact' then
		local loc = GetEntityCoords(model)
		exports.interact:AddLocalEntityInteraction({entity = model,offset = vec3(0.0, 0.0, 1.0),id = 'mddrugss'..model,distance = 2.5,interactDst = 2.5, options = data})
	end
end

local created = false
local heading = 180.0
function StartRay()
    local run = true
	local pedcoord = GetEntityCoords(PlayerPedId())
	lib.requestModel('v_ret_ml_tablea', 30000)
	local table = CreateObject('v_ret_ml_tablea', pedcoord.x, pedcoord.y, pedcoord.z+1, heading, false, false)
    repeat
        local hit, entityHit, endCoords, surfaceNormal, matHash = lib.raycast.cam(511, 4, 10)
		if not created then 
			created = true
			lib.showTextUI([[[E] To Place   
			[DEL] To Cancel  
			[<-] To Move Left  
			[->] To Move Right]])
		else
			SetEntityCoords(table, endCoords.x, endCoords.y, endCoords.z+1)
			SetEntityHeading(table, heading)
			SetEntityCollision(table, false, false)
			SetEntityAlpha(table, 100)
		end
		if IsControlPressed(0, 174) then
            heading = heading - 2
        end
		if IsControlPressed(0, 175) then
            heading = heading + 2
        end
        if IsControlPressed(0, 38) then
            lib.hideTextUI()
            run = false
			DeleteObject(table)
			created = false
            return endCoords, heading
        end

        if IsControlPressed(0, 178) then
            lib.hideTextUI()
            run = false
			created = false
			DeleteObject(table)
            return nil, nil
		end
        Wait(0)
    until run == false
end

function StartRay2()
    local run = true
	local pedcoord = GetEntityCoords(PlayerPedId())
	lib.requestModel('bkr_prop_coke_press_01aa', 30000)
	local table = CreateObject('bkr_prop_coke_press_01aa', pedcoord.x, pedcoord.y, pedcoord.z+1, heading, false, false)
    repeat
        local hit, entityHit, endCoords, surfaceNormal, matHash = lib.raycast.cam(511, 4, 10)
		if not created then 
			created = true
			lib.showTextUI([[[E] To Place   
			[DEL] To Cancel  
			[<-] To Move Left  
			[->] To Move Right]])
		else
			SetEntityCoords(table, endCoords.x, endCoords.y, endCoords.z+1)
			SetEntityHeading(table, heading)
			SetEntityCollision(table, false, false)
			SetEntityAlpha(table, 100)
		end
		if IsControlPressed(0, 174) then
            heading = heading - 2
        end
		if IsControlPressed(0, 175) then
            heading = heading + 2
        end
        if IsControlPressed(0, 38) then
            lib.hideTextUI()
            run = false
			DeleteObject(table)
			created = false
            return endCoords, heading
        end

        if IsControlPressed(0, 178) then
            lib.hideTextUI()
            run = false
			created = false
			DeleteObject(table)
            return nil, nil
		end
        Wait(0)
    until run == false
end

CreateThread(function()
	LoadModel('prop_plant_01b')
	LoadModel('prop_plant_01a')
	LoadModel('prop_cactus_03')
	LoadModel('prop_weed_01')
	TriggerEvent('weed:init')
	TriggerEvent('heroin:init')
	TriggerEvent('coke:init')
	TriggerEvent('Mescaline:init')
	TriggerEvent('shrooms:init')
	TriggerEvent('weed:init')
end)

lib.callback.register('md-drugs:client:uncuff', function(data)
	if not progressbar(data, 4000, 'uncuff') then return end
	return true
end)

RegisterCommand('DrugRep', function()
	if not Config.TierSystem then return end
	local rep = lib.callback.await('md-drugs:server:GetRep', false)
	lib.registerContext({
		id = 'DrugRep',
		title = 'Drug Reputation',
		options = {
		  {icon = "fa-solid fa-face-flushed", title = 'Cocaine: '..rep.coke},
		  {icon = "fa-solid fa-syringe", 	  title = 'Heroin: '..rep.heroin},
		  {icon = "fa-solid fa-vial",		  title = 'LSD: '..rep.lsd},
		  {icon = "fa-solid fa-plug", 		  title = 'Dealer: '..rep.dealerrep},
		  {icon = "fa-solid fa-money-bill",   title = 'Corner Selling: ' .. rep.cornerselling.rep, description = 'Rank: ' .. rep.cornerselling.label }
		}
	  })
	  lib.showContext('DrugRep')
end, false)

function handleGang(gang)
	if gang == nil or gang == '' or gang == "" then return true end
	if ps.getGangName() == gang or gang == 1 then return true end
	return false
end