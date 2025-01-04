local QBCore = exports['qb-core']:GetCoreObject()



CreateThread(function()
    local config = lib.callback.await('md-drugs:server:getLocs', false)
    local model = {"g_m_y_famdnf_01", 's_m_m_doctor_01', 'u_m_m_jesus_01'}
    for k, v in pairs (model) do
        lib.requestModel(v, Config.RequestModelTime)
    end
    local tabdealer = CreatePed(0, 'g_m_y_famdnf_01',config.singleSpot.buylsdlabkit.x,config.singleSpot.buylsdlabkit.y,config.singleSpot.buylsdlabkit.z-1,config.singleSpot.buylsdlabkit.w, false, false)
    local heroinkitdealer = CreatePed(0,"g_m_y_famdnf_01",config.singleSpot.buyheroinlabkit.x, config.singleSpot.buyheroinlabkit.y, config.singleSpot.buyheroinlabkit.z-1, config.singleSpot.buyheroinlabkit.w, false, false)
    local SyrupLocation = CreatePed(0, 's_m_m_doctor_01', config.singleSpot.SyrupVendor.x,config.singleSpot.SyrupVendor.y,config.singleSpot.SyrupVendor.z-1, config.singleSpot.SyrupVendor.w, false, false)
    local WeedGuy = CreatePed(0,'u_m_m_jesus_01',config.singleSpot.WeedSaleman.x,config.singleSpot.WeedSaleman.y,config.singleSpot.WeedSaleman.z-1, config.singleSpot.WeedSaleman.w, false, false)
    Freeze(tabdealer, true,config.singleSpot.buylsdlabkit.w)
    Freeze(SyrupLocation, true, config.singleSpot.SyrupVendor.w)
    Freeze(heroinkitdealer, true, config.singleSpot.buyheroinlabkit.w)
    Freeze(WeedGuy, true, config.singleSpot.WeedSaleman.w)
    AddSingleModel(tabdealer,{ type = "client", label = Lang.targets.lsd.buy, icon = "fa-solid fa-money-bill", event = "md-drugs:client:buylabkit", distance = 2.0}, tabdealer )
    AddSingleModel(heroinkitdealer, { label = Lang.targets.heroin.kit, icon = "fa-solid fa-money-bill", event = "md-drugs:client:buyheroinlabkit", distance = 2.0}, nil )
    AddSingleModel(SyrupLocation, { type = "client", label = Lang.targets.lean.git, icon = "fa-solid fa-circle-info", event = "md-drugs:client:getsyruplocationtobuy", distance = 2.0}, nil )    
    AddSingleModel(WeedGuy, {label = "Weed Shop",icon = "fas fa-eye", action = function() makeMenu('WeedShop') lib.showContext('WeedShop')end}, nil)
end)