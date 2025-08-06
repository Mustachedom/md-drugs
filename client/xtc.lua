local xtcpress = false
local locations = ps.callback('md-drugs:server:GetXtcLocs')

local function getRecipeList(tbl)
  local rec = {}
  for m, d in pairs(tbl) do table.insert(rec, ps.getLabel(m) .. ' X ' .. d) end
  return table.concat(rec, ', ')
end

ps.registerCallback('md-drugs:client:setpress', function(xtcData)
    if xtcpress then
        ps.notify(Lang.xtc.out, 'error')
        return
    end
    local coords, head = StartRay2()
    xtcpress = true
	if not ps.progressbar('Setting Press On The Ground', 4000, 'uncuff') then return end
	local press = CreateObject("bkr_prop_coke_press_01aa", coords.x, coords.y, coords.z, true, false, false)
	PlaceObjectOnGroundProperly(press)
    Freeze(press, true, head)
      local options = {
          {
            icon = "fas fa-eye",
            label = ps.lang('targets.xtc.make'),
            distance = 2.0,
            action = function()
                local options = {}
                for k, v in pairs(xtcData.recipes) do
                  local descript = getRecipeList(v.take)
                    options[#options + 1] = {
                        icon = ps.getImage(k),
                        title = ps.getLabel(k),
                        description = descript,
                        action = function()
                            if not minigame() then ps.notify(ps.lang('xtc.fail'), "error") return end
                            if not ps.progressbar(string.format(ps.lang('xtc.make'), ps.getLabel(k)), 4000, 'uncuff') then return end
                            TriggerServerEvent("md-drugs:server:makextc", k)
                        end,
                        distance = 2.0
                    }
                end
                ps.menu('XTC Recipes', 'XTC Recipes', options)
            end,
            canInteract = function()
              if xtcpress then return true end
            end
          },
          {
            icon = "fas fa-eye",
            label = ps.lang('targets.xtc.pick'),
            action = function()
               if not ps.progressbar(ps.lang('xtc.pickup'), 5000, 'uncuff') then return end
               DeleteObject(press)
               xtcpress = false
               TriggerServerEvent("md-drugs:server:getpressback")
            end,
            canInteract = function()
               if xtcpress then return true end
            end
          },
      }
    ps.entityTarget(press, options)
    return true
end)

for k, v in pairs(locations.mdp2p) do
    ps.boxTarget('mdp2p'..k, v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-flask',
            label = ps.lang('targets.xtc.mdp2p'),
            action = function()
                if not minigame() then ps.notify(ps.lang('xtc.fail'), "error") return end
                if not ps.progressbar(ps.lang('xtc.mdp2p'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:stealmdp2p", k)
            end
        }
    })
end
for k, v in pairs(locations.isosafrole) do
    ps.boxTarget('isosafrole'..k, v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-flask',
            label = ps.lang('targets.xtc.isosafrole'),
            action = function()
                if not minigame() then ps.notify(ps.lang('xtc.fail'), "error") return end
                if not ps.progressbar(ps.lang('xtc.isosafrole'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:stealisosafrole", k)
            end
        }
    })
end

for k, v in pairs(locations.rawxtcloc) do
    ps.boxTarget('xtc'..k, v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-flask',
            label = ps.lang('targets.xtc.raw'),
            action = function()
                if not minigame() then ps.notify(ps.lang('xtc.fail'), "error") return end
                if not ps.progressbar(ps.lang('xtc.raw'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:makingrawxtc", k)
            end
        }
    })
end

for k, v in pairs(locations.xtcpress) do
    ps.requestModel(v.ped)
    local ped = CreatePed(0, v.ped, v.loc, false, false)
    Freeze(ped, true, v.loc.w)
    ps.entityTarget(ped, {
        {
            icon = 'fa-solid fa-flask',
            label = ps.lang('targets.xtc.press'),
            action = function()
                local options = {}
                local recipeList = ps.callback('md-drugs:server:getpressrecipes')
                for m, d in pairs(recipeList) do
                    if m == 'singlepress' then
                        options[#options + 1] = {
                          icon = ps.getImage(m),
                          title = ps.getLabel(m),
                          description = ps.lang('xtc.press.buysingle', d.cash),
                          action = function()
                            if not ps.progressbar(ps.lang('xtc.buyp'), 4000, 'uncuff') then return end
                            TriggerServerEvent('md-drugs:server:buypress', m)
                          end,
                        }
                    else
                        ps.debug(d.take)
                        local descript = getRecipeList(d.take)
                        options[#options + 1] = {
                            icon = ps.getImage(m),
                            title = ps.getLabel(m),
                            description = descript,
                            action = function()
                                 if not ps.progressbar(ps.lang('xtc.buyp'), 4000, 'uncuff') then return end
                                TriggerServerEvent("md-drugs:server:upgradepress", k, m)
                            end,
                            distance = 2.0
                        }
                    end
                end
                ps.menu('XTC Presses', 'XTC Presses', options)
            end
        }
    })
end

for k, v in pairs (locations.stamp) do
    ps.boxTarget('xtc'..k, v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-flask',
            label = ps.lang('targets.xtc.' .. k),
            action = function()
                local item = {
                    {item = 'white_xtc', label = ps.getLabel('white_xtc'), color = 'white'},
                    {item = 'red_xtc', label = ps.getLabel('red_xtc'), color = 'red'},
                    {item = 'orange_xtc', label = ps.getLabel('orange_xtc'), color = 'orange'},
                    {item = 'blue_xtc', label = ps.getLabel('blue_xtc'), color = 'blue'},
                }
                local options = {}
                for m, d in pairs (item) do
                    options[#options + 1] = {
                        icon = ps.getImage(d.item),
                        title = d.label,
                        description = ps.lang('xtc.stamp_desc', d.color),
                        action = function()
                            if not minigame() then ps.notify(ps.lang('xtc.fail'), "error") return end
                            if not ps.progressbar(string.format(ps.lang('xtc.stamp'), d.label), 4000, 'uncuff') then return end
                            TriggerServerEvent("md-drugs:server:stamp", k, d.color)
                        end,
                        distance = 2.0
                    }
                end
                ps.menu('Stamp Pills', 'Stamp Pills', options)
            end
        }
    })
end
