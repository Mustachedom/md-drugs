local carryPackage = nil

RegisterNetEvent("md-drugs:client:GetOxyCar", function()
	lib.requestModel("burrito3", Config.RequestModelTime)
	local paid = lib.callback.await('md-drugs:server:payfortruck', false)
	if not paid then return end
	local loca = lib.callback.await('md-drugs:server:getLocs', false)
	local loc = loca.singleSpot.truckspawn
	local oxycar = CreateVehicle("burrito3",loc.x, loc.y,loc.z, loc.w, true, false)
    exports[Config.Fuel]:SetFuel(oxycar, 100.0)
    TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(oxycar))
	Notify(Lang.oxy.truck, 'success')
	TriggerEvent("md-drugs:client:getoxylocationroute")
	AddSingleModel(oxycar,  { event = "md-drugs:client:getfromtrunk", icon = "fa-solid fa-box", label = Lang.targets.oxy.pack}, nil )
end)

RegisterNetEvent("md-drugs:client:getoxylocationroute", function()
	local config = lib.callback.await('md-drugs:server:getLocs', false)
    local loc = config.oxylocations[math.random(#config.oxylocations)]
	if loc ~= nil then
    	SetNewWaypoint(loc.x, loc.y)
		local current = "g_m_y_famdnf_01"
		lib.requestModel(current, Config.RequestModelTime)
    	local oxybuyer = CreatePed(0, current,loc.x,loc.y,loc.z-1, loc.w, false, false)
		Freeze(oxybuyer, true, loc.w)
		repeat
			Wait(1000)
		until #(GetEntityCoords(PlayerPedId()) - vector3(loc.x,loc.y,loc.z)) < 5.0
		PoliceCall(Config.PoliceAlertOxy)
		AddSingleModel(oxybuyer,  { type = "client", label = Lang.targets.oxy.talk, icon = "fa-solid fa-dollar-sign", 
		action = function()
			if carryPackage then
				if not progressbar(Lang.oxy.hand, 4000, 'uncuff') then return end
				TriggerServerEvent("md-drugs:server:giveoxybox")
				DeleteEntity(oxybuyer)
				DetachEntity(carryPackage, true, true)
				DeleteObject(carryPackage)
				carryPackage = nil
			else
				Notify(Lang.oxy.empty, "error")
			end
		end}, oxybuyer)
	end
end)


RegisterNetEvent("md-drugs:client:getfromtrunk", function() 
	if carryPackage then
		Notify(Lang.oxy.cantcarry, "error")
	else
		local pos = GetEntityCoords(PlayerPedId(), true)
		lib.requestAnimDict('anim@heists@box_carry@')
		TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
		lib.RequestModel("hei_prop_drug_statue_box_big")
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

