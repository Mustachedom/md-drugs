local QBCore = exports['qb-core']:GetCoreObject()
local deliveryBlip = nil
local carryPackage = nil


RegisterNetEvent("md-drugs:client:getoxytruck", function() 
if TriggerServerEvent('md-drugs:server:payfortruck') then
end
end)


RegisterNetEvent("md-drugs:Client:getoxylocation", function()
	local coords = Config.truckspawn
	local ModelHash = "burrito3" -- Use Compile-time hashes to get the hash of this model
	lib.requestModel(ModelHash, Config.RequestModelTime)
	local oxycar = CreateVehicle(ModelHash,Config.truckspawn.x, Config.truckspawn.y,Config.truckspawn.z, Config.truckspawn.h, true, false)
    SetEntityHeading(oxycar, coords.w)
    exports[Config.Fuel]:SetFuel(oxycar, 100.0)
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(oxycar))
	Notify(Lang.oxy.truck, 'success')
	TriggerEvent("md-drugs:client:getoxylocationroute")
    SetVehicleEngineOn(oxycar, true, true)
    local options = {
        { event = "md-drugs:client:getfromtrunk", icon = "fas fa-box-circle-check", label = "Get Package"},
    }
	if Config.oxtarget then
		exports.ox_target:addLocalEntity(oxycar, options)
	else 
		exports['qb-target']:AddTargetEntity(oxycar, {options = options, distance = 2.0})
	end  
	
end)



RegisterNetEvent("md-drugs:client:getoxylocationroute", function() 
	Wait(100)
	local unlucky = math.random(1,100)
    local CurrentLocation = Config.oxylocations[math.random(#Config.oxylocations)]
	local unluck =  math.random(1,100)
    if deliveryBlip ~= nil then
        RemoveBlip(deliveryBlip)
    end
	if CurrentLocation ~= nil then
    	deliveryBlip = AddBlipForCoord(CurrentLocation)
    	SetBlipSprite(deliveryBlip, 1)
    	SetBlipDisplay(deliveryBlip, 2)
    	SetBlipScale(deliveryBlip, 1.0)
    	SetBlipAsShortRange(deliveryBlip, false)
    	SetBlipColour(deliveryBlip, 27)
    	BeginTextCommandSetBlipName("STRING")
    	AddTextComponentSubstringPlayerName("drug Meet")
    	EndTextCommandSetBlipName(deliveryBlip)
    	SetBlipRoute(deliveryBlip, true)
		local current = "g_m_y_famdnf_01"
		lib.requestModel(current, Config.RequestModelTime)
    	local oxybuyer = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, CurrentLocation.w, false, false)
		SetEntityHeading(oxybuyer, 180)
    	FreezeEntityPosition(oxybuyer, true)
    	SetEntityInvincible(oxybuyer, true)
	repeat
		Wait(1000)
	until #(GetEntityCoords(PlayerPedId()) - vector3(CurrentLocation.x,CurrentLocation.y,CurrentLocation.z)) < 5.0
		RemoveBlip(deliveryBlip)
		PoliceCall(Config.PoliceAlertOxy)
		local options = {
    	        { type = "client", label = "Talk To Buyer", icon = "fas fa-eye", event = "md-drugs:client:giveoxybox", ped = oxybuyer},
    	    }
		if Config.oxtarget then
			exports.ox_target:addLocalEntity(oxybuyer, options)
		else 
			exports['qb-target']:AddTargetEntity(oxybuyer, {options = options, distance = 2.0})
		end   
	end
end)


RegisterNetEvent("md-drugs:client:getfromtrunk", function() 
	if carryPackage then
		Notify(Lang.oxy.cantcarry, "error")
	else	
		local pos = GetEntityCoords(PlayerPedId(), true)
		RequestAnimDict('anim@heists@box_carry@')
		while (not HasAnimDictLoaded('anim@heists@box_carry@')) do
			Wait(7)
		end
		TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
		RequestModel("hei_prop_drug_statue_box_big")
		while not HasModelLoaded("hei_prop_drug_statue_box_big") do
			Wait(0)
		end
		local object = CreateObject("hei_prop_drug_statue_box_big", pos.x, pos.y, pos.z, true, true, true)
		AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
		carryPackage = object
	end	
end)


RegisterNetEvent("md-drugs:client:giveoxybox", function(data) 
	if carryPackage then
		if not progressbar(Lang.oxy.hand, 4000, 'uncuff') then return end
		TriggerServerEvent("md-drugs:server:giveoxybox")
		DeleteEntity(data.ped)
		DetachEntity(carryPackage, true, true)
		DeleteObject(carryPackage)
	    carryPackage = nil
	else
		Notify(Lang.oxy.empty, "error")
	end
end)

