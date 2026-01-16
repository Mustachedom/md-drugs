
local minigametype = Config.minigametype
local dispatch = Config.Dispatch

function requestModel(ped, timeout)
	timeout = timeout or 15000
    local startTime = GetGameTimer()
    RequestModel(ped)
    while not HasModelLoaded(ped) do
		Wait(0)
        if GetGameTimer() - startTime > timeout then
            Bridge.Prints.Debug('requestModel timed out', ped, GetGameTimer() - startTime)
            return false
        end
    end
	return true
end

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
		Bridge.Dispatch.SendAlert({
		    message = "Suspisous Handoff",
		    code = "10-31",
		    coords = GetEntityCoords(PlayerPedId()),
		    jobs = {"police"},
		    blipData = {
		        sprite = 161,
		        color = 1,
		        scale = 1.0
		    },
		    time = 300000,
		    icon = "fas fa-exclamation-triangle"
		})
	else
		return
	end
end

function GetCops(number)
	if number == 0 then return true end
	local amount = ps.callback('md-drugs:server:GetCoppers')
	if amount >= number then return true else Bridge.Notify.SendNotify('You Need '.. number - amount .. ' More Cops To Do This', 'error')  end
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

if Bridge.Framework.GetResourceName() == 'es_extended' then
	function handleGang(gang)
		return true
	end
else
	function handleGang(gang)
		if not gang then 
			return true
		end
		if #gang == 0 then
			return true
		end
		local data = Bridge.Framework.GetPlayerData()
		if not data.gang then
			return false
		end
		return data.gang.name == gang
	end
end

if Config.Emotes == 'rp' then
	function playEmote(emote)
		return exports["rpemotes"]:EmoteCommandStart(emote)
	end
	function stopEmote()
		return exports["rpemotes"]:EmoteCancel()
	end
end

if Config.Emotes == 'dp' then
	function playEmote(emote)
		TriggerEvent('animations:client:EmoteCommandStart', {emote})
	end
	function stopEmote()
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
	end
end

if Config.Emotes == 'scully' then
	function playEmote(emote)
		exports.scully_emotemenu:playEmoteByCommand(emote)
	end
	function stopEmote()
		exports.scully_emotemenu:cancelEmote()
	end
end

if Config.Emotes == 'custom' then
	function playEmote(emote)
		TriggerEvent('animations:client:EmoteCommandStart', {emote})
	end
	function stopEmote()
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
	end
end

function progressbar(text, time, emote, cancel)
	playEmote(emote)
	if not cancel then
		cancel =  {
			move = true,
			car = true,
			combat = true
		}
	end
	local success = Bridge.ProgressBar.Open({
		duration = time,
		label = text,
		canCancel = true,
		disable = cancel,
	})
	stopEmote()
	return success
end