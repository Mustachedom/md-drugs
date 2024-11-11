local QBCore = exports['qb-core']:GetCoreObject()
local xtcpress = false

RegisterNetEvent("md-drugs:client:setpress", function(type)
    if xtcpress then 
        Notify(Lang.xtc.out, 'error')
    else
      local coords, head = StartRay2()
      xtcpress = true
	    progressbar('Setting Press On The Ground', 4000, 'uncuff')
	    local press = CreateObject("bkr_prop_coke_press_01aa", coords.x, coords.y, coords.z, true, false, false)
	    PlaceObjectOnGroundProperly(press)
      SetEntityHeading(press, head)
        local options = {
            { icon = "fas fa-eye", label = Lang.targets.xtc.make, distance = 2.0, action = function()  TriggerEvent("md-drugs:client:XTCMenu", type) end, 
            canInteract = function() if xtcpress then return true end end
            },
            {icon = "fas fa-eye", label = Lang.targets.xtc.pick, action = function() TriggerEvent("md-drugs:client:GetPressBack", type, press) end, distance = 2.0,
              canInteract = function() if xtcpress then return true end end
            },
        }
        AddMultiModel(press, options, nil)
    end
end)

RegisterNetEvent("md-drugs:client:XTCMenu", function(type)
  local event =  "md-drugs:client:MakeXTC"
    lib.registerContext({
        id = 'XTCmenu',
        title = 'XTC Menu',
        options = {
          {icon = GetImage('white_xtc'),   title = 'White XTC',  description = '1 X Raw XTC',  event = event,  args = { data = type, color = 'white'}},
          {icon = GetImage('red_xtc'),     title = 'Red XTC',    description = '1 X Raw XTC and 1 X Loose Coke',  event = event,  args = { data = type, color = 'red'}},
          {icon = GetImage('orange_xtc'),  title = 'Orange XTC', description = '1 X Raw XTC and 1 X Heroin Vial',  event = event,  args = { data = type, color = 'orange'}},
          {icon = GetImage('blue_xtc'),    title = 'Blue XTC',   description = '1 X Raw XTC and 1 X Crack Rock',  event = event,  args = { data = type, color = 'blue'}},
        }
      }) 
    lib.showContext('XTCmenu')
end)

RegisterNetEvent("md-drugs:client:GetPressBack", function(type, press)
    if not progressbar(Lang.xtc.pickup, 5000, 'uncuff') then return end
    DeleteObject(press)
    xtcpress = false
    TriggerServerEvent("md-drugs:server:getpressback", type)
end)

RegisterNetEvent("md-drugs:client:stealisosafrole", function(data) 
    if not minigame() then Notify(Lang.xtc.fail, "error") return end
    if not progressbar(Lang.xtc.iso, 4000, 'uncuff') then return end
    TriggerServerEvent("md-drugs:server:stealisosafrole",data.data)
end)


RegisterNetEvent("md-drugs:client:stealmdp2p", function(data) 
    if not minigame() then Notify(Lang.xtc.fail, "error") return end
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
    lib.registerContext({ id = 'stampxtc', title = 'Stamp XTC Menu',
    options = {
      { icon = GetImage('white_xtc'), title = 'White XTC',
        onSelect = function()
            if not minigame() then Notify(Lang.xtc.fail, "error") return end
            if not progressbar(string.format(Lang.xtc.stamp, 'White'), 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:stampwhite",data.data)
        end   
      },
      { icon = GetImage('red_xtc'), title = 'Red XTC',
        onSelect = function()
            if not minigame() then Notify(Lang.xtc.fail, "error") return end
            if not progressbar(string.format(Lang.xtc.stamp, 'Red'), 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:stampred", data.data)
        end
      },
      { icon = GetImage('orange_xtc'), title = 'Orange XTC',
        onSelect = function()
            if not minigame() then Notify(Lang.xtc.fail, "error") return end
            if not progressbar(string.format(Lang.xtc.stamp, 'Orange'), 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:stamporange", data.data)
        end,
      },
      { icon = GetImage('blue_xtc'), title = 'Blue XTC',
        onSelect = function()
            if not minigame() then Notify(Lang.xtc.fail, "error") return end
            if not progressbar(string.format(Lang.xtc.stamp, 'Blue'), 4000, 'uncuff') then return end
            TriggerServerEvent("md-drugs:server:stampblue", data.data)
        end
      },
    }
  })
  lib.showContext('stampxtc')
end)


RegisterNetEvent("md-drugs:client:getsinglepress", function() 
    if not progressbar(Lang.xtc.buyp, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:buypress")
end)


RegisterNetEvent("md-drugs:client:exchangepresses", function(data) 
   if not progressbar(Lang.xtc.buyp, 4000, 'uncuff') then return end
	TriggerServerEvent("md-drugs:server:upgradepress", data.data)
end)

RegisterNetEvent("md-drugs:client:buypress", function() 
    local img = GetImage('singlepress')
     lib.registerContext({
	    id = 'buypresses',
	    title = 'Purchase Presses',
	    options = {
        {title  = Lang.xtc.press.title.single,  description  = Lang.xtc.press.des.single,   icon = img,    event = 'md-drugs:client:getsinglepress'},
        {title  = Lang.xtc.press.title.dual,    description  = Lang.xtc.press.des.dual,     icon = img,    event = 'md-drugs:client:exchangepresses', args = {data = 'dual'}},
        {title  = Lang.xtc.press.title.triple,  description  = Lang.xtc.press.des.triple,   icon = img,    event = 'md-drugs:client:exchangepresses', args = {data = 'triple'}},
        {title  = Lang.xtc.press.title.quad,    description  = Lang.xtc.press.des.quad,     icon = img,    event = 'md-drugs:client:exchangepresses', args = {data = 'quad'}} 
	    }	
    })
  lib.showContext('buypresses')	
end)

