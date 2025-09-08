
local minigametype = Config.minigametype
local dispatch = Config.Dispatch

function minigame()
	local time = 0
	local game = Config.Minigames
	if minigametype == 'ps_circle' then
		local check = exports['ps-ui']:Circle(false, game['ps_circle'].amount, game['ps_circle'].speed)
		return check
	elseif minigametype == 'ps_maze' then
	   local check = exports['ps-ui']:Maze(false, game['ps_maze'].timelimit)
	   return check
   elseif minigametype == 'ps_scrambler' then
	   local check = exports['ps-ui']:Scrambler(false, game['ps_scrambler'].type,  game['ps_scrambler'].time, game['ps_scrambler'].mirrored)
	   return check
   elseif minigametype == 'ps_var' then
	   local check = exports['ps-ui']:VarHack(false, game['ps_var'].numBlocks,  game['ps_var'].time)
	   return check
   elseif minigametype == 'ps_thermite' then
	   local check = exports['ps-ui']:Thermite(false, game['ps_thermite'].time,  game['ps_thermite'].gridsize, game['ps_thermite'].incorrect)
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

function GetRep()
	local rep = ps.callback('md-drugs:server:GetRep')
	return rep
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
	local amount = ps.callback('md-drugs:server:GetCoppers')
	if amount >= number then return true else ps.notify('You Need '.. number - amount .. ' More Cops To Do This', 'error')  end
end

function Freeze(entity, toggle, head)
	SetEntityInvincible(entity, toggle)
	SetEntityAsMissionEntity(entity, toggle, toggle)
    FreezeEntityPosition(entity, toggle)
    SetEntityHeading(entity, head)
	SetBlockingOfNonTemporaryEvents(entity, toggle)
end

local created = false
local heading = 180.0
function StartRay()
    local run = true
	local pedcoord = GetEntityCoords(PlayerPedId())
	ps.requestModel('v_ret_ml_tablea', 30000)
	local table = CreateObject('v_ret_ml_tablea', pedcoord.x, pedcoord.y, pedcoord.z+1, heading, false, false)
    repeat
        local hit, endCoords, surfaceNormal, entityHit = ps.raycast()
		if not created then 
			created = true
			ps.drawText([[[E] To Place   
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
            ps.hideText()
            run = false
			DeleteObject(table)
			created = false
            return endCoords, heading
        end

        if IsControlPressed(0, 178) then
            ps.hideText()
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
	ps.requestModel('bkr_prop_coke_press_01aa', 30000)
	local table = CreateObject('bkr_prop_coke_press_01aa', pedcoord.x, pedcoord.y, pedcoord.z+1, heading, false, false)
    repeat
        local hit, endCoords, surfaceNormal, entityHit = ps.raycast()
		if not created then 
			created = true
			ps.drawText([[[E] To Place   
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
            ps.hideText()
            run = false
			DeleteObject(table)
			created = false
            return endCoords, heading
        end

        if IsControlPressed(0, 178) then
            ps.hideText()
            run = false
			created = false
			DeleteObject(table)
            return nil, nil
		end
        Wait(0)
    until run == false
end

ps.registerCallback('md-drugs:client:uncuff', function(data)
	if not ps.progressbar(data, 4000, 'uncuff') then return end
	return true
end)

RegisterCommand('DrugRep', function()
	if not Config.TierSystem then return end
	local rep = ps.callback('md-drugs:server:GetRep', false)
	ps.menu('Drug Rep', 'Drug Rep', {
		{icon = "fa-solid fa-face-flushed", title = 'Cocaine: '..rep.coke},
		{icon = "fa-solid fa-syringe", 	  title = 'Heroin: '..rep.heroin},
		{icon = "fa-solid fa-vial",		  title = 'LSD: '..rep.lsd},
		{icon = "fa-solid fa-plug", 		  title = 'Dealer: '..rep.dealerrep},
		{icon = "fa-solid fa-money-bill",   title = 'Corner Selling: ' .. rep.cornerselling.rep, description = 'Rank: ' .. rep.cornerselling.label }
	})
end, false)

function handleGang(gang)
	if gang == nil or gang == '' or gang == "" then return true end
	if ps.getGangName() == gang or gang == 1 then return true end
	return false
end