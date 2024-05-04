local QBCore = exports['qb-core']:GetCoreObject()
local xtcpress = false


RegisterNetEvent("md-drugs:client:setpress", function(type)
    
    if xtcpress then 
        Notify(Lang.xtc.out, 'error')
    else
        local PedCoords = GetEntityCoords(PlayerPedId())
        xtcpress = true
	    progressbar('Setting Press On The Ground', 4000, 'uncuff')
	    local press = CreateObject("bkr_prop_coke_press_01aa", PedCoords.x+1, PedCoords.y+1, PedCoords.z-1, true, false)
	    PlaceObjectOnGroundProperly(press)
	
        local options = {
            {   
                icon = "fas fa-eye",
                label = "Make XTC",
                action = function() 
                    TriggerEvent("md-drugs:client:XTCMenu", type) 
                end,   
                canInteract = function()
                    if xtcpress then return true end end
            },
            {     
                icon = "fas fa-eye",    
                label = "Pick Up",   
                action = function()  
                    TriggerEvent("md-drugs:client:GetPressBack", type, press) 
                end,  
                canInteract = function()        
                    if xtcpress then return true end end 
            },
        }
        local optionsox = {
            {   
                icon = "fas fa-eye",
                label = "Make XTC",
                onSelect = function() 
                    TriggerEvent("md-drugs:client:XTCMenu", type) 
                end,   
                canInteract = function()
                    if xtcpress then return true end end
            },
            {     
                icon = "fas fa-eye",    
                label = "Pick Up",   
                onSelect = function()  
                    TriggerEvent("md-drugs:client:GetPressBack", type, press) 
                end,  
                canInteract = function()        
                    if xtcpress then return true end end 
            },
        }
        if Config.oxtarget then
            exports.ox_target:addLocalEntity(press,  optionsox)
        else
            exports['qb-target']:AddTargetEntity(press, { options = options})
        end
    end
end)    

RegisterNetEvent("md-drugs:client:XTCMenu", function(type)
    lib.registerContext({
        id = 'XTCmenu',
        title = 'XTC Menu',
        options = {
          {
            icon = 'nui://'..Config.imagelink..QBCore.Shared.Items['white_xtc'].image,
            title = 'White XTC',
            description = '1 X Raw XTC',
            event = "md-drugs:client:MakeXTC",
            args = { data = type, color = 'white'}
          },
          {
            icon = 'nui://'..Config.imagelink..QBCore.Shared.Items['red_xtc'].image,
            title = 'Red XTC',
            description = '1 X Raw XTC and 1 X Loose Coke',
            event = "md-drugs:client:MakeXTC",
            args = { data = type, color = 'red'}
          },
          {
            icon = 'nui://'..Config.imagelink..QBCore.Shared.Items['orange_xtc'].image,
            title = 'Orange XTC',
            description = '1 X Raw XTC and 1 X Heroin Vial',
            event = "md-drugs:client:MakeXTC",
            args = { data = type, color = 'orange'}
          },
          {
            icon = 'nui://'..Config.imagelink..QBCore.Shared.Items['blue_xtc'].image,
            title = 'Blue XTC',
            description = '1 X Raw XTC and 1 X Crack Rock',
            event = "md-drugs:client:MakeXTC",
            args = { data = type, color = 'blue'}
          },
          
        }
      }) 
      lib.showContext('XTCmenu')
end)

RegisterNetEvent("md-drugs:client:GetPressBack", function(type, press)
    if not progressbar('Packing Up The Press', 5000, 'uncuff') then return end
    DeleteObject(press)
    xtcpress = false
    TriggerServerEvent("md-drugs:server:getpressback", type)
end)

RegisterNetEvent("md-drugs:client:stealisosafrole", function(data) 
    if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
    if not progressbar(Lang.xtc.iso, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:stealisosafrole",data.data)
end)


RegisterNetEvent("md-drugs:client:stealmdp2p", function(data) 
    if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
    if not progressbar(Lang.xtc.mdp2p, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:stealmdp2p", data.data)   
end)


RegisterNetEvent("md-drugs:client:makingrawxtc", function(data) 
    if not ItemCheck('isosafrole') then return end 
    if not ItemCheck('mdp2p') then return end
    if not progressbar(Lang.xtc.raw, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:makingrawxtc",data.data)
end)

RegisterNetEvent("md-drugs:client:MakeXTC", function(data) 
    if not ItemCheck('raw_xtc') then return end
    if not progressbar(Lang.xtc.pressing, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:makextc",data)
end)

------------------------------------------------------------------ Stamping

RegisterNetEvent("md-drugs:client:stampwhite", function(data) 
    lib.registerContext({
    id = 'stampxtc',
    title = 'Stamp XTC Menu',
    options = {
      {
        icon = 'nui://'..Config.imagelink..QBCore.Shared.Items['white_xtc'].image,
        title = 'White XTC',
        onSelect = function()
            if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
            if not progressbar('Stamping White Pills', 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:stampwhite",data.data)
        end      
      },
      {
        icon = 'nui://'..Config.imagelink..QBCore.Shared.Items['red_xtc'].image,
        title = 'Red XTC',
        onSelect = function()
            if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
            if not progressbar('Stamping Red Pills', 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:stampred", data.data)
        end
      },
      {
        icon = 'nui://'..Config.imagelink..QBCore.Shared.Items['orange_xtc'].image,
        title = 'Orange XTC',
        onSelect = function()
            if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
            if not progressbar('Stamping Orange Pills', 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:stamporange", data.data)
        end,
      },
      {
        icon = 'nui://'..Config.imagelink..QBCore.Shared.Items['blue_xtc'].image,
        title = 'Blue XTC',
        onSelect = function()
            if not minigame(2, 8) then Notify(Lang.xtc.fail, "error") return end
            if not progressbar('Stamping Blue Pills', 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:stampblue", data.data)
        end
      },
      
    }
  }) 
  lib.showContext('stampxtc')
end)


RegisterNetEvent("md-drugs:client:getsinglepress", function() 
    if not progressbar('Buying Press', 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:buypress")
end)


RegisterNetEvent("md-drugs:client:exchangepresses", function(data) 
   if not progressbar('Buying Press', 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:upgradepress", data.data)
end)

RegisterNetEvent("md-drugs:client:buypress", function() 
    local img = 'nui://' .. Config.imagelink .. QBCore.Shared.Items['singlepress'].image
     lib.registerContext({
	 id = 'buypresses',
	 title = 'Purchase Presses',
	 options = {
        {    title  = 'Single Press',                description  = 'Buy a single press for 20k',                                       icon = img,    event = 'md-drugs:client:getsinglepress'},
        {    title  = 'Exchange Single For Dual',    description  = '20 of each unstamped single stack pill and your single press ',    icon = img,    event = 'md-drugs:client:exchangepresses', args = {data = 'dual'}},
        {    title  = 'Exchange Dual For Triple',    description  = '50 of each unstamped dual stack pill and your dual press ',        icon = img,    event = 'md-drugs:client:exchangepresses', args = {data = 'triple'}},
        {    title  = 'Exchange Triple For Quad',    description  = '150 of each unstamped Triple stack pill and your triple press ',   icon = img,    event = 'md-drugs:client:exchangepresses', args = {data = 'quad'}} 
	}	
    })
  lib.showContext('buypresses')	
end)

