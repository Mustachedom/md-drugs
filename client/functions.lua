
local minigametype = Config.minigametype

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
	local rep = Bridge.Callback.Trigger('md-drugs:server:GetRep')
	return rep
end

function PoliceCall(chance)
	local math = math.random(1,100)
	if math <= chance then
		Bridge.Dispatch.SendAlert({
		    message = Bridge.Language.Locale('Dispatch.header'),
		    code = Bridge.Language.Locale('Dispatch.code'),
		    coords = GetEntityCoords(PlayerPedId()),
		    jobs = {"police"},
		    blipData = {
		        sprite = 161,
		        color = 1,
		        scale = 1.0
		    },
		    time = 300000,
		    icon = Bridge.Language.Locale('Dispatch.icon')
		})
	else
		return
	end
end

function GetCops(number)
	if number == 0 then return true end
	local amount = Bridge.Callback.Trigger('md-drugs:server:GetCoppers')
	if amount >= number then return true else Bridge.Notify.SendNotify(string.format(Bridge.Language.Locale('Catches.YouNeedMoreCops'), number - amount), 'error')  end
end

function Freeze(entity, toggle, head)
	SetEntityInvincible(entity, toggle)
	SetEntityAsMissionEntity(entity, toggle, toggle)
    FreezeEntityPosition(entity, toggle)
    SetEntityHeading(entity, head)
	SetBlockingOfNonTemporaryEvents(entity, toggle)
end

local function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

local function RayCastGamePlayCamera(distance)
    local currentRenderingCam = false
    if not IsGameplayCamRendering() then
        currentRenderingCam = GetRenderingCam()
    end

    local cameraRotation = not currentRenderingCam and GetGameplayCamRot() or GetCamRot(currentRenderingCam, 2)
    local cameraCoord = not currentRenderingCam and GetGameplayCamCoord() or GetCamCoord(currentRenderingCam)
    local direction = RotationToDirection(cameraRotation)
    local destination = {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local _, hit, endCoords, surfaceNormal, entityHit  = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
    return _, hit, endCoords, surfaceNormal, entityHit
end

local function ray()
   local _, hit, endCoords, surfaceNormal, entityHit  = RayCastGamePlayCamera(1000.0)
    return hit, endCoords, surfaceNormal, entityHit
end

local created = false
local heading = 180.0
function StartRay()
    local run = true
	local pedcoord = GetEntityCoords(PlayerPedId())
	requestModel('v_ret_ml_tablea', 30000)
	local table = CreateObject('v_ret_ml_tablea', pedcoord.x, pedcoord.y, pedcoord.z+1, heading, false, false)
    repeat
       	local hit, endCoords, surfaceNormal, entityHit = ray()
		if not created then 
			created = true
			Bridge.HelpText.ShowHelpText([[[E] To Place   
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
            Bridge.HelpText.HideHelpText()
            run = false
			DeleteObject(table)
			created = false
            return endCoords, heading
        end

        if IsControlPressed(0, 178) then
            Bridge.HelpText.HideHelpText()
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
	requestModel('bkr_prop_coke_press_01aa', 30000)
	local table = CreateObject('bkr_prop_coke_press_01aa', pedcoord.x, pedcoord.y, pedcoord.z+1, heading, false, false)
    repeat
        local hit, endCoords, surfaceNormal, entityHit = ray()
		if not created then 
			created = true
			Bridge.HelpText.ShowHelpText([[[E] To Place   
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
            Bridge.HelpText.HideHelpText()
            run = false
			DeleteObject(table)
			created = false
            return endCoords, heading
        end

        if IsControlPressed(0, 178) then
            Bridge.HelpText.HideHelpText()
            run = false
			created = false
			DeleteObject(table)
            return nil, nil
		end
        Wait(0)
    until run == false
end

Bridge.Callback.Register('md-drugs:client:uncuff', function(data)
	if not progressbar(data) then return end
	return true
end)

RegisterCommand('DrugRep', function()
	if not Config.TierSystem then return end
	local rep = GetRep()
	Bridge.Menu.Open({
		id = 'drugrep',
		title = Bridge.Language.Locale('DrugRep.header'),
		description = Bridge.Language.Locale('DrugRep.increased'),
		options = {
			{icon = Bridge.Language.Locale('DrugRep.coke.icon'), title = Bridge.Language.Locale('DrugRep.coke.title', rep.coke)},
			{icon = Bridge.Language.Locale('DrugRep.heroin.icon'), 	  title = Bridge.Language.Locale('DrugRep.heroin.title', rep.heroin)},
			{icon = Bridge.Language.Locale('DrugRep.lsd.icon'),		  title = Bridge.Language.Locale('DrugRep.lsd.title', rep.lsd)},
			{icon = Bridge.Language.Locale('DrugRep.dealerrep.icon'), 		  title = Bridge.Language.Locale('DrugRep.dealerrep.title', rep.dealerrep)},
			{icon = Bridge.Language.Locale('DrugRep.cornerselling.icon'),   title = Bridge.Language.Locale('DrugRep.cornerselling.title', rep.cornerselling.rep), description = Bridge.Language.Locale('DrugRep.cornerselling.description', rep.cornerselling.label) }
		}
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

if Config.Emotes == 'scully' then
    function playEmote(emote)
        exports.scully_emotemenu:playEmoteByCommand(emote, 0)
    end
    function stopEmote()
        exports.scully_emotemenu:cancelEmote()
    end
end

if Config.Emotes == 'dpemotes' then
    function playEmote(emote)
        TriggerEvent('animations:client:EmoteCommandStart', {emote})
    end
    function stopEmote()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end
end

if Config.Emotes == 'rpemotes' then
    function playEmote(emote)
        exports["rpemotes"]:EmoteCommandStart(emote, 0)
    end
    function stopEmote()
        exports["rpemotes"]:EmoteCancel()
    end
end

local animation = nil

function progressbar(text, time, emote, cancel)
	local animData
	if type(emote) == 'string' then
		playEmote(emote)
		animation = emote
	elseif type(emote) == 'table' then
		animData = emote
		if emote.prop and not emote.prop.model then
			emote.prop = nil
		end
	end
	local success = Bridge.ProgressBar.Open({
		duration = time or 5000,
		label = text or 'LAZY AF DEVS',
		canCancel = true,
		disable = cancel or Config.ProgressBar.Disables,
		anim = animData,
		prop = animData and animData.prop or nil
	})
	if animation then
		animation = nil
		stopEmote()
	end
	return success
end

function itemCheck(item)
	if not Bridge.Inventory.HasItem(item) then
        Bridge.Notify.SendNotify(Bridge.Language.Locale('Catches.itemMissings', Bridge.Inventory.GetItemInfo(item).label), 'error')
        return false
    end
	return true
end

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() ~= resourceName then return end
	for k, v in pairs (targets) do
		if type(v) == 'number' then
			Bridge.Target.RemoveLocalEntity(v)
			if DoesEntityExist(v) then
				DeleteEntity(v)
			end
		else
			Bridge.Target.RemoveZone(v)
		end
	end
end)