local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function() 
 	local current = "g_m_y_famdnf_01"
	lib.requestModel(current, Config.RequestModelTime)
	local num = lib.callback.await('md-drugs:server:GetMerchant', false)
	local CurrentLocation = Config.Travellingmerchant[num]
	local travellingmerchant = CreatePed(0, current,CurrentLocation.x,CurrentLocation.y,CurrentLocation.z-1, CurrentLocation.w, false, false)
	Freeze(travellingmerchant, true, CurrentLocation.w)
	AddSingleModel(travellingmerchant, { label = Lang.targets.travel.travel, icon = "fas fa-eye",
	action = function()
		makeMenu('travellingMerchant')
		lib.showContext('travellingMerchant')
	end}, nil)
end)
