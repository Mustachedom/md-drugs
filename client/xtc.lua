local xtcpress = false
repeat Wait(100) until GlobalState.MDDrugsLocations.XTC ~= nil
local locations = GlobalState.MDDrugsLocations.XTC

local function getRecipeList(tbl, type)
    local rec
  if type == 'presses' then
    rec = {'XTC FROM THE PREVIOUS TIER REQUIRED TO UPGRADE  \n  '}
  else
    rec = {'REQUIRED INGREDIENTS:  \n  '}
  end

  for m, d in pairs(tbl) do table.insert(rec, Bridge.Inventory.GetItemInfo(m).label .. ' X ' .. d .. '  \n  ') end
  return table.concat(rec, ' ')
end

Bridge.Callback.Register('md-drugs:client:setpress', function(xtcData)
    if xtcpress then
        Bridge.Notify.SendNotify(Bridge.Language.Locale('xtc.alreadyOut'), 'error')
        return
    end
    local coords, head = StartRay2()
    xtcpress = true
	if not progressbar(Bridge.Language.Locale('xtc.settingDown')) then return end
	local press = CreateObject("bkr_prop_coke_press_01aa", coords.x, coords.y, coords.z, true, false, false)
	PlaceObjectOnGroundProperly(press)
    Freeze(press, true, head)
      local options = {
          {
            icon = Bridge.Language.Locale('xtc.pressIcon'),
            label = Bridge.Language.Locale('xtc.targetMake'),
            distance = 2.0,
            action = function()
                local options = {}
                for k, v in pairs(xtcData.recipes) do
                  local descript = getRecipeList(v.take)
                  local itemInfo = Bridge.Inventory.GetItemInfo(k)
                    options[#options + 1] = {
                        icon = itemInfo.image,
                        title = Bridge.Language.Locale(k),
                        description = descript,
                        onSelect = function()
                            if not minigame() then return end
                            if not progressbar(Bridge.Language.Locale('xtc.making', Bridge.Language.Locale(k))) then return end
                            TriggerServerEvent("md-drugs:server:makextc", k)
                        end,
                        distance = 2.0
                    }
                end
                Bridge.Menu.Open({
                    id = 'XTC Recipes', 
                    title = 'XTC Recipes',
                    options = options
                })
            end,
            canInteract = function()
              if xtcpress then return true end
            end
          },
          {
            icon = Bridge.Language.Locale('xtc.pressIcon'),
            label = Bridge.Language.Locale('xtc.targetPickup'),
            action = function()
               if not progressbar(Bridge.Language.Locale('xtc.picking')) then return end
               DeleteObject(press)
               xtcpress = false
               TriggerServerEvent("md-drugs:server:getpressback")
            end,
            canInteract = function()
               if xtcpress then return true end
            end
          },
      }
    Bridge.Target.AddLocalEntity(press, options)
    return coords
end)

for k, v in pairs(locations.mdp2p) do
    Bridge.Target.AddBoxZone('mdp2p'..k, v.loc, v.size, v.rot or 180.0, {
        {
            icon = Bridge.Language.Locale('xtc.mdp2pIcon'),
            label = Bridge.Language.Locale('xtc.targetStealMDP2P'),
            action = function()
                if not minigame() then  return end
                if not progressbar(Bridge.Language.Locale('xtc.stealingMDP2P')) then return end
                TriggerServerEvent("md-drugs:server:stealmdp2p", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end
for k, v in pairs(locations.isosafrole) do
    Bridge.Target.AddBoxZone('isosafrole'..k, v.loc, v.size, v.rot or 180.0, {
        {
            icon = Bridge.Language.Locale('xtc.isosafroleIcon'),
            label = Bridge.Language.Locale('xtc.targetStealIsosafrole'),
            action = function()
                if not minigame() then  return end
                if not progressbar(Bridge.Language.Locale('xtc.stealingIsosafrole')) then return end
                TriggerServerEvent("md-drugs:server:stealisosafrole", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

for k, v in pairs(locations.rawxtcloc) do
    Bridge.Target.AddBoxZone('xtcraw'..k, v.loc, v.size, v.rot or 180.0, {
        {
            icon = Bridge.Language.Locale('xtc.rawIcon'),
            label = Bridge.Language.Locale('xtc.targetRaw'),
            action = function()
                if not minigame() then  return end
                if not progressbar(Bridge.Language.Locale('xtc.makingRaw')) then return end
                TriggerServerEvent("md-drugs:server:makingrawxtc", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

for k, v in pairs(locations.xtcpress) do
    requestModel(v.ped)
    local ped = CreatePed(0, v.ped, v.loc, false, false)
    Freeze(ped, true, v.loc.w)
    Bridge.Target.AddLocalEntity(ped, {
        {
            icon = Bridge.Language.Locale('xtc.pressIcon'),
            label = Bridge.Language.Locale('xtc.getPress'),
            onSelect = function()
                local options = {}
                local recipeList = GlobalState.MDDrugsRecipes.XTC.presses
                for m, d in pairs(recipeList) do
                    if m == 'singlepress' then
                        local itemInfo = Bridge.Inventory.GetItemInfo(m)
                        options[#options + 1] = {
                          icon = itemInfo.image,
                          title = itemInfo.label,
                          description = Bridge.Language.Locale('xtc.buySingle', d.cash),
                          type = d.type,
                          onSelect = function()
                            if not progressbar(Bridge.Language.Locale('xtc.buyp')) then return end
                            TriggerServerEvent('md-drugs:server:buypress',k, m)
                          end,
                        }
                    else
                        local itemInfo = Bridge.Inventory.GetItemInfo(m)
                        local descript = getRecipeList(d.take, 'presses')
                        options[#options + 1] = {
                            icon = itemInfo.image,
                            title = itemInfo.label,
                            description = descript,
                            type = d.type,
                            onSelect = function()
                                 if not progressbar(Bridge.Language.Locale('xtc.buyp')) then return end
                                TriggerServerEvent("md-drugs:server:upgradepress", k, m)
                            end,
                            distance = 2.0
                        }
                    end
                end
                table.sort(options, function(a, b) return a.type < b.type end)
                Bridge.Menu.Open({
                    id = 'XTC Presses', 
                    title = 'XTC Presses',
                    options = options
                })
            end,
             canInteract = function() return handleGang(v.gang) end
        }
    })
end

for k, v in pairs (locations.stamp) do
    Bridge.Target.AddBoxZone('xtcstamp'..k, v.loc, v.size, v.rot or 180.0, {
        {
            icon = Bridge.Language.Locale('xtc.stampIcon'),
            label = Bridge.Language.Locale('xtc.targetStamp'),
            onSelect = function()
                local item = {
                    {item = 'white_xtc', label = Bridge.Inventory.GetItemInfo('white_xtc').label, color = 'white'},
                    {item = 'red_xtc', label = Bridge.Inventory.GetItemInfo('red_xtc').label, color = 'red'},
                    {item = 'orange_xtc', label = Bridge.Inventory.GetItemInfo('orange_xtc').label, color = 'orange'},
                    {item = 'blue_xtc', label = Bridge.Inventory.GetItemInfo('blue_xtc').label, color = 'blue'},
                }
                local options = {}
                for m, d in pairs (item) do
                    options[#options + 1] = {
                        icon = Bridge.Inventory.GetItemInfo(d.item).image,
                        title = d.label,
                        description = Bridge.Language.Locale('xtc.stamp_desc', d.color),
                        action = function()
                            if not minigame() then  return end
                            if not progressbar(Bridge.Language.Locale('xtc.stamping', d.label)) then return end
                            TriggerServerEvent("md-drugs:server:stamp", k, d.color)
                        end,
                        distance = 2.0
                    }
                end
                Bridge.Menu.Open({
                    id = 'XTC Stamp', 
                    title = 'XTC Stamp',
                    options = options
                })
            end,
            canInteract = function() return handleGang(v.gang) end
        }
    })
end
