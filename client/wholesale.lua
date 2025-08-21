local miss = false
-- Enhanced SetUpPeds function with difficulty based on drug quantity
    function SetUpPeds(drugCount)
        -- Calculate number of attackers based on drug quantity
        local attackerCount = Config.WholesaleAmbushBase -- Base number
        
        -- Scale attackers based on drug quantity if enabled
        if Config.WholesaleAmbushScale then
            if drugCount > Config.WholesaleAmbushTier1 then
                attackerCount = 3
            end
            if drugCount > Config.WholesaleAmbushTier2 then
                attackerCount = 4
            end
            if drugCount > Config.WholesaleAmbushTier3 then
                attackerCount = 5
            end
        end
        
        -- Select weapon tier based on drug quantity
        local weaponTier = Config.WholesaleWeaponsTier1 -- Default to tier 1 weapons
        
        if Config.WholesaleWeaponTiers then
            if drugCount > Config.WholesaleAmbushTier3 then
                weaponTier = Config.WholesaleWeaponsTier4 -- Elite weapons
            elseif drugCount > Config.WholesaleAmbushTier2 then
                weaponTier = Config.WholesaleWeaponsTier3 -- Advanced weapons
            elseif drugCount > Config.WholesaleAmbushTier1 then
                weaponTier = Config.WholesaleWeaponsTier2 -- Medium weapons
            end
        end
        
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed, false)
        local models = {"g_m_y_ballasout_01", "g_m_y_famdnf_01", "g_m_y_famca_01", "g_m_y_mexgoon_01", "g_m_y_salvagoon_01"}
        
        -- Spawn hostile NPCs in a circle around the player
        for i = 1, attackerCount do
            local angle = (360 / attackerCount) * i
            local x = playerCoords.x + math.cos(math.rad(angle)) * 15
            local y = playerCoords.y + math.sin(math.rad(angle)) * 15
            local z = playerCoords.z
            
            local modelHash = GetHashKey(models[math.random(1, #models)])
            RequestModel(modelHash)
            while not HasModelLoaded(modelHash) do
                Citizen.Wait(1)
            end
            
            local ped = CreatePed(4, modelHash, x, y, z, 0.0, true, false)
            local weapon = weaponTier[math.random(1, #weaponTier)]
            
            -- Set ped attributes
            SetPedRelationshipGroupHash(ped, GetHashKey("HATES_PLAYER"))
            SetPedCombatAttributes(ped, 46, true)
            SetPedCombatAttributes(ped, 0, true)
            SetPedCombatAttributes(ped, 5, true)
            SetPedCombatAttributes(ped, 2, true)
            
            -- Set health based on tier
            local healthMultiplier = 1.0
            if drugCount > Config.WholesaleAmbushTier3 then
                healthMultiplier = 1.5 -- 50% more health for tier 4
            elseif drugCount > Config.WholesaleAmbushTier2 then
                healthMultiplier = 1.3 -- 30% more health for tier 3
            elseif drugCount > Config.WholesaleAmbushTier1 then
                healthMultiplier = 1.2 -- 20% more health for tier 2
            end
            
            -- Apply health multiplier
            local baseHealth = GetEntityHealth(ped)
            SetEntityHealth(ped, math.floor(baseHealth * healthMultiplier))
            
            -- Give weapon and make hostile
            GiveWeaponToPed(ped, GetHashKey(weapon), 500, false, true)
            TaskCombatPed(ped, playerPed, 0, 16)
            
            -- Set blip for enemy
            local blip = AddBlipForEntity(ped)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, 1)
            SetBlipScale(blip, 0.7)
            
            -- Clean up ped after 5 minutes
            SetEntityAsNoLongerNeeded(ped)
        end
        
        -- Get weapon tier name for notification
        local tierName = "Basic"
        if drugCount > Config.WholesaleAmbushTier3 then
            tierName = "Elite"
        elseif drugCount > Config.WholesaleAmbushTier2 then
            tierName = "Advanced"
        elseif drugCount > Config.WholesaleAmbushTier1 then
            tierName = "Medium"
        end
        
        -- Notify player of ambush with tier information
        ps.notify(string.format(ps.lang('wholesale.ambush'), attackerCount, tierName), 'error')
    end
RegisterNetEvent("md-drugs:client:GetLocation", function(drug)
    if not GetCops(Config.PoliceCount) then return end
    if miss then
       ps.notify(ps.lang('wholesale.alreadyWholesale'), 'error')
    else
       local loc = drug.location
       local timer = 0
       miss = true
       SetNewWaypoint(loc.x, loc.y)
       
       -- Display drug quantity information if enabled
       if Config.WholesaleShowEstimates and drug.count > 0 then
           -- Calculate potential bonus
           local bonusTiers = math.floor(drug.count / 10)
           local potentialBonus = math.min(bonusTiers * Config.WholesaleQuantityBonus, Config.WholesaleMaxBonus)
           local bonusPercent = math.floor(potentialBonus * 100)
           
           -- Calculate potential payout range
           local minPayout = math.floor(drug.price.min * (1 + potentialBonus))
           local maxPayout = math.floor(drug.price.max * (1 + potentialBonus))
           local totalMinPayout = drug.count * minPayout
           local totalMaxPayout = drug.count * maxPayout
           
           -- Display information
           ps.notify(string.format(ps.lang('wholesale.count'), drug.count), 'info')
           if bonusPercent > 0 then
               ps.notify(string.format(ps.lang('wholesale.bonus'), bonusPercent), 'info')
           end
           ps.notify(string.format(ps.lang('wholesale.estimate'), totalMinPayout, totalMaxPayout), 'info')
       elseif drug.count <= 0 then
           ps.notify(ps.lang('wholesale.no_drugs'), 'error')
       end
       
       ps.requestModel("g_m_y_famdnf_01", Config.RequestModelTime)
    	local current = "g_m_y_famdnf_01"
       local drugdealer = CreatePed(0, current,loc.x,loc.y,loc.z-1, 90.0, false, false)
       FreezeEntityPosition(drugdealer, true)
       SetEntityInvincible(drugdealer, true)
       ps.entityTarget(drugdealer, {{
           label = ps.lang('wholesale.targetBuyer'),
           icon = "fas fa-eye",
           action = function()
                local luck = math.random(1,100)
                if luck <= Config.SuccessfulChance then
                    if not ps.progressbar(ps.lang('wholesale.wholesaling'), 4000, 'uncuff') then return end
                    TriggerServerEvent("md-drugs:server:SuccessSale", drug)
                else
                    ps.progressbar("Deal Going Bad", 4000, 'uncuff')
                    
                    -- Handle ambush if enabled
                    if Config.WholesaleAmbushEnabled then
                        SetUpPeds(drug.count)
                    end
                    
                    -- Alert police with configured chance on failed deals
                    if Config.WholesaleFailPoliceAlert > 0 then
                        local alertChance = math.random(1, 100)
                        if alertChance <= Config.WholesaleFailPoliceAlert then
                            PoliceCall(100) -- Force police alert on failed deals
                        end
                    end
                    
                    -- Clean up failed deal on server
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
       until #(GetEntityCoords(PlayerPedId()) - vector3(loc.x, loc.y, loc.z) ) < 4.0 or timer == Config.WholesaleTimeout + 1
       PoliceCall(Config.AlertPoliceWholesale)
       if timer <= Config.WholesaleTimeout or #(GetEntityCoords(PlayerPedId()) - vector3(loc.x, loc.y, loc.z) ) < 4.0  then
           timer = 0
       else
           ps.notify(ps.lang('wholesale.tooLong'), 'error')
           DeleteEntity(drugdealer)
           -- Clean up timeout deal on server
           TriggerServerEvent('md-drugs:server:CleanupWholesale')
           -- Reset wholesale flag based on config
           if Config.WholesaleResetOnTimeout then
               miss = false
           end
       end
    end
end)



-- Handle wholesale completion notification
RegisterNetEvent('md-drugs:client:WholesaleComplete', function(data)
    local bonusText = ""
    if data.bonus > 0 then
        bonusText = " (+" .. data.bonus .. "% quantity bonus)"
    end
    
    ps.notify(string.format(ps.lang('wholesale.complete'), data.quantity, data.payout, bonusText), 'success')
end)
