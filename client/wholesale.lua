local miss = false
local settings = ps.callback('md-drugs:server:GetWSsettings')

function SetUpPeds(drugCount)
    local attackerCount = settings.WholesaleAmbushBase
    if settings.WholesaleAmbushScale then
        if drugCount > settings.WholesaleAmbushTier1 then
            attackerCount = 3
        end
        if drugCount > settings.WholesaleAmbushTier2 then
            attackerCount = 4
        end
        if drugCount > settings.WholesaleAmbushTier3 then
            attackerCount = 5
        end
    end
    local weaponTier = settings.WholesaleWeaponsTier1
    if settings.WholesaleWeaponTiers then
        if drugCount > settings.WholesaleAmbushTier3 then
            weaponTier = settings.WholesaleWeaponsTier4
        elseif drugCount > settings.WholesaleAmbushTier2 then
            weaponTier = settings.WholesaleWeaponsTier3
        elseif drugCount > settings.WholesaleAmbushTier1 then
            weaponTier = settings.WholesaleWeaponsTier2
        end
    end
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed, false)
    local models = {"g_m_y_ballasout_01", "g_m_y_famdnf_01", "g_m_y_famca_01", "g_m_y_mexgoon_01", "g_m_y_salvagoon_01"}
    for i = 1, attackerCount do
        local angle = (360 / attackerCount) * i
        local x = playerCoords.x + math.cos(math.rad(angle)) * 15
        local y = playerCoords.y + math.sin(math.rad(angle)) * 15
        local z = playerCoords.z
        local modelHash = GetHashKey(models[math.random(1, #models)])
        ps.requestModel(modelHash)
        local ped = CreatePed(4, modelHash, x, y, z, 0.0, true, false)
        local weapon = weaponTier[math.random(1, #weaponTier)]
        SetPedRelationshipGroupHash(ped, GetHashKey("HATES_PLAYER"))
        SetPedCombatAttributes(ped, 46, true)
        SetPedCombatAttributes(ped, 0, true)
        SetPedCombatAttributes(ped, 5, true)
        SetPedCombatAttributes(ped, 2, true)
        local healthMultiplier = 1.0
        if drugCount > settings.WholesaleAmbushTier3 then
            healthMultiplier = 1.5
        elseif drugCount > settings.WholesaleAmbushTier2 then
            healthMultiplier = 1.3
        elseif drugCount > settings.WholesaleAmbushTier1 then
            healthMultiplier = 1.2
        end
        local baseHealth = GetEntityHealth(ped)
        SetEntityHealth(ped, math.floor(baseHealth * healthMultiplier))
        GiveWeaponToPed(ped, GetHashKey(weapon), 500, false, true)
        TaskCombatPed(ped, playerPed, 0, 16)
        local blip = AddBlipForEntity(ped)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 1)
        SetBlipScale(blip, 0.7)
        SetEntityAsNoLongerNeeded(ped)
    end
    local tierName = "Basic"
    if drugCount > settings.WholesaleAmbushTier3 then
        tierName = "Elite"
    elseif drugCount > settings.WholesaleAmbushTier2 then
        tierName = "Advanced"
    elseif drugCount > settings.WholesaleAmbushTier1 then
        tierName = "Medium"
    end
    ps.notify(string.format(ps.lang('wholesale.ambush'), attackerCount, tierName), 'error')
end

RegisterNetEvent("md-drugs:client:GetLocation", function(drug)
    if not GetCops(settings.PoliceCount) then return end
    if miss then
       ps.notify(ps.lang('wholesale.alreadyWholesale'), 'error')
    else
       local loc = drug.location
       local timer = 0
       miss = true
       SetNewWaypoint(loc.x, loc.y)
       if settings.WholesaleShowEstimates and drug.count > 0 then
           local bonusTiers = math.floor(drug.count / 10)
           local potentialBonus = math.min(bonusTiers * settings.WholesaleQuantityBonus, settings.WholesaleMaxBonus)
           local bonusPercent = math.floor(potentialBonus * 100)
           local minPayout = math.floor(drug.price.min * (1 + potentialBonus))
           local maxPayout = math.floor(drug.price.max * (1 + potentialBonus))
           local totalMinPayout = drug.count * minPayout
           local totalMaxPayout = drug.count * maxPayout
           ps.notify(string.format(ps.lang('wholesale.count'), drug.count), 'info')
           if bonusPercent > 0 then
               ps.notify(string.format(ps.lang('wholesale.bonus'), bonusPercent), 'info')
           end
           ps.notify(string.format(ps.lang('wholesale.estimate'), totalMinPayout, totalMaxPayout), 'info')
       elseif drug.count <= 0 then
           ps.notify(ps.lang('wholesale.no_drugs'), 'error')
       end
       ps.requestModel("g_m_y_famdnf_01", settings.RequestModelTime)
       local current = "g_m_y_famdnf_01"
       local drugdealer = CreatePed(0, current,loc.x,loc.y,loc.z-1, 90.0, false, false)
       FreezeEntityPosition(drugdealer, true)
       SetEntityInvincible(drugdealer, true)
       ps.entityTarget(drugdealer, {{
           label = ps.lang('wholesale.targetBuyer'),
           icon = "fas fa-eye",
           action = function()
                local luck = math.random(1,100)
                if luck <= settings.SuccessfulChance then
                    if not ps.progressbar(ps.lang('wholesale.wholesaling'), 4000, 'uncuff') then return end
                    TriggerServerEvent("md-drugs:server:SuccessSale", drug)
                else
                    ps.progressbar("Deal Going Bad", 4000, 'uncuff')
                    if settings.WholesaleAmbushEnabled then
                        SetUpPeds(drug.count)
                    end
                    if settings.WholesaleFailPoliceAlert > 0 then
                        local alertChance = math.random(1, 100)
                        if alertChance <= settings.WholesaleFailPoliceAlert then
                            PoliceCall(100)
                        end
                    end
                    TriggerServerEvent('md-drugs:server:CleanupWholesale')
                end
                Wait(3000)
                DeleteEntity(drugdealer)
                miss = false
            end
       }},drugdealer )
    	repeat
           Wait(1000)
           timer = timer + 1
       until #(GetEntityCoords(PlayerPedId()) - vector3(loc.x, loc.y, loc.z) ) < 4.0 or timer == settings.WholesaleTimeout + 1
       PoliceCall(settings.AlertPoliceWholesale)
       if timer <= settings.WholesaleTimeout or #(GetEntityCoords(PlayerPedId()) - vector3(loc.x, loc.y, loc.z) ) < 4.0  then
           timer = 0
       else
           ps.notify(ps.lang('wholesale.tooLong'), 'error')
           DeleteEntity(drugdealer)
           TriggerServerEvent('md-drugs:server:CleanupWholesale')
           if settings.WholesaleResetOnTimeout then
               miss = false
           end
       end
    end
end)

RegisterNetEvent('md-drugs:client:WholesaleComplete', function(data)
    local bonusText = ""
    if data.bonus > 0 then
        bonusText = " (+" .. data.bonus .. "% quantity bonus)"
    end
    ps.notify(string.format(ps.lang('wholesale.complete'), data.quantity, data.payout, bonusText), 'success')
end)