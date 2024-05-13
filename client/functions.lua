local QBCore = exports['qb-core']:GetCoreObject()

local progressbartype = Config.progressbartype 
local minigametype = Config.minigametype
local notifytype = Config.Notify 
local dispatch = Config.Dispatch

 function progressbar(text, time, anim)
	
	TriggerEvent('animations:client:EmoteCommandStart', {anim}) 
	if progressbartype == 'oxbar' then 
	  if lib.progressBar({ duration = time, label = text, useWhileDead = false, canCancel = true, disable = { car = true, move = true},}) then 
		TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		return true
	  end	 
	elseif progressbartype == 'oxcir' then
	  if lib.progressCircle({ duration = time, label = text, useWhileDead = false, canCancel = true, position = 'bottom', disable = { car = true,move = true},}) then 
		TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
		return true
	  end
	elseif progressbartype == 'qb' then
		local test = false
	  QBCore.Functions.Progressbar("drink_something", text, time, false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, disableInventory = true,
	  }, {}, {}, {}, function()-- Done
		test = true
		TriggerEvent('animations:client:EmoteCommandStart', {"c"}) 
	  end)
	  Wait(time + 200)
	  if test then return true else Wait(400) if test then return true end end 
	else
		print"dude, it literally tells you what you need to set it as in the config"
	end	  
  end

function minigame(num1, num2)
    local check
	if minigametype == 'ps' then
    	exports['ps-ui']:Circle(function(success)
        	check = success
    	end, num1, num2) 
    	return check
	elseif minigametype == 'ox' then
		num1 = 'easy'
		if num2 <= 6 then num2 = 'hard' elseif num2 >= 7 and num2 <= 12 then num2 = 'medium' else num2 = 'easy' end
		local success = lib.skillCheck({num1, num2}, {'1', '2', '3', '4'})
		return success 
    elseif minigametype == 'none' then
		return true
	else	
		
        print"dude, it literally tells you what you need to set it as in the config"
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
       print"dude, it literally tells you what you need to set it as in the config"
    end   
  end

function ItemCheck(item)
local success 
if QBCore.Shared.Items[item] == nil then print("There Is No " .. item .. " In Your QB Items.lua") return end
if QBCore.Functions.HasItem(item) then success = item return success else Notify('You Need ' .. QBCore.Shared.Items[item].label .. " !", 'error') end
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
				blip = {
					sprite = 431, 
					scale = 1.2, 
					colour = 3,
					flashes = false, 
					text = '420-69 Drug Sale',
					time = 5,
					radius = 0,
				}
			})
		elseif	dispatch == 'core' then
			exports['core_dispatch']:addCall("420-69", "Drugs Are Being Sold", {
				{icon="fa-ruler", info="4.5 MILES"},
				}, {GetEntityCoords(PlayerPedId())}, "police", 3000, 11, 5 )
		elseif dispatch == 'aty' then 
			exports["aty_dispatch"]:SendDispatch('Drug Sale', '420-69', 40, {'police'})
		else
			print('Congrats, You Choose 0 of the options :)')	
		end
	else
	end
end

function GetCops(number)
	if number == 0 then return true end
	QBCore.Functions.TriggerCallback('md-drugs:server:GetCoppers', function(amount)
		
		if amount >= number then return amount == true else Notify('You Need '.. number - amount .. ' More Cops To Do This', 'error') end
	end)
end


