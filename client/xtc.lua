local xtcpress = false
local locations = ps.callback('md-drugs:server:GetXtcLocs')

local function getRecipeList(tbl)
  local rec = {}
  for m, d in pairs(tbl) do table.insert(rec, ps.getLabel(m) .. ' X ' .. d) end
  return table.concat(rec, ', ')
end

ps.registerCallback('md-drugs:client:setpress', function(xtcData)
    if xtcpress then
        ps.notify(ps.lang('xtc.alreadyOut'), 'error')
        return
    end
    local coords, head = StartRay2()
    xtcpress = true
	if not ps.progressbar(ps.lang('xtc.settingDown'), 4000, 'uncuff') then return end
	local press = CreateObject("bkr_prop_coke_press_01aa", coords.x, coords.y, coords.z, true, false, false)
	PlaceObjectOnGroundProperly(press)
    Freeze(press, true, head)
      local options = {
          {
            icon = "fas fa-eye",
            label = ps.lang('xtc.targetMake'),
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
                            if not ps.progressbar(ps.lang('xtc.making', ps.getLabel(k)), 4000, 'uncuff') then return end
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
            label = ps.lang('xtc.targetPickup'),
            action = function()
               if not ps.progressbar(ps.lang('xtc.picking'), 5000, 'uncuff') then return end
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
    return coords
end)

for k, v in pairs(locations.mdp2p) do
    ps.boxTarget('mdp2p'..k, v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-flask',
            label = ps.lang('xtc.targetStealMDP2P'),
            action = function()
                if not minigame() then ps.notify(ps.lang('xtc.fail'), "error") return end
                if not ps.progressbar(ps.lang('xtc.stealingMDP2P'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:stealmdp2p", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end
for k, v in pairs(locations.isosafrole) do
    ps.boxTarget('isosafrole'..k, v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-flask',
            label = ps.lang('xtc.targetStealIsosafrole'),
            action = function()
                if not minigame() then ps.notify(ps.lang('xtc.fail'), "error") return end
                if not ps.progressbar(ps.lang('xtc.stealingIsosafrole'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:stealisosafrole", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
            end
        }
    })
end

for k, v in pairs(locations.rawxtcloc) do
    ps.boxTarget('xtcraw'..k, v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-flask',
            label = ps.lang('xtc.targetRaw'),
            action = function()
                if not minigame() then ps.notify(ps.lang('xtc.fail'), "error") return end
                if not ps.progressbar(ps.lang('xtc.makingRaw'), 4000, 'uncuff') then return end
                TriggerServerEvent("md-drugs:server:makingrawxtc", k)
            end,
            canInteract = function()
                return handleGang(v.gang)
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
            label = ps.lang('xtc.getPress'),
            action = function()
                local options = {}
                local recipeList = ps.callback('md-drugs:server:getpressrecipes')
                for m, d in pairs(recipeList) do
                    if m == 'singlepress' then
                        options[#options + 1] = {
                          icon = ps.getImage(m),
                          title = ps.getLabel(m),
                          description = ps.lang('xtc.buySingle', d.cash),
                          action = function()
                            if not ps.progressbar(ps.lang('xtc.buyp'), 4000, 'uncuff') then return end
                            TriggerServerEvent('md-drugs:server:buypress',k, m)
                          end,
                        }
                    else
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
            end,
             canInteract = function() return handleGang(v.gang) end
        }
    })
end

for k, v in pairs (locations.stamp) do
    ps.boxTarget('xtcstamp'..k, v.loc, {length = v.l, width = v.w, heading = v.rot}, {
        {
            icon = 'fa-solid fa-flask',
            label = ps.lang('xtc.targetStamp'),
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
                            if not ps.progressbar(ps.lang('xtc.stamping', d.label), 4000, 'uncuff') then return end
                            TriggerServerEvent("md-drugs:server:stamp", k, d.color)
                        end,
                        distance = 2.0
                    }
                end
                ps.menu('Stamp Pills', 'Stamp Pills', options)
            end,
            canInteract = function() return handleGang(v.gang) end
        }
    })
end
