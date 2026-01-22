local active = false
local active, ped, peds = false, nil, {}

local function loop(wholesaleData)
    local timeout = 600 -- 10 minutes
    while active do
        Wait(1000)
        local dist = #(GetEntityCoords(PlayerPedId()) - vector3(wholesaleData.location.x, wholesaleData.location.y, wholesaleData.location.z))
        if dist < 100.0 then
            if IsEntityDead(PlayerPedId()) then
                active = false
                Bridge.Point.Remove('md-drugs:wholesaleZone'..Bridge.Framework.GetPlayerIdentifier())
                TriggerServerEvent('md-drugs:server:getkilledFuckingNoob')
                for k, v in pairs (peds) do
                    DeleteEntity(v)
                end
                peds = {}
                break
            end
        end
        timeout = timeout - 1
        if timeout <= 0 then
            break
        end
    end
end

function SetUpPeds(attackerCount, location)
    local models = {"g_m_y_ballasout_01", "g_m_y_famdnf_01", "g_m_y_famca_01", "g_m_y_mexgoon_01", "g_m_y_salvagoon_01"}
    for i = 1, attackerCount do
        local angle = (360 / attackerCount) * i
        local x = location.x + math.cos(math.rad(angle)) * 15
        local y = location.y + math.sin(math.rad(angle)) * 15
        local z = location.z
        local modelHash = GetHashKey(models[math.random(1, #models)])
        requestModel(modelHash)
        peds[#peds+1] = CreatePed(4, modelHash, x, y, z, 0.0, true, true)
        local weapon = math.random(1, 2) == 1 and "WEAPON_PISTOL" or "WEAPON_BAT"
        SetPedRelationshipGroupHash(peds[#peds], GetHashKey("HATES_PLAYER"))
        SetPedCombatAttributes(peds[#peds], 46, true)
        SetPedCombatAttributes(peds[#peds], 0, true)
        SetPedCombatAttributes(peds[#peds], 5, true)
        SetPedCombatAttributes(peds[#peds], 2, true)
        GiveWeaponToPed(peds[#peds], GetHashKey(weapon), 500, false, true)
        TaskCombatPed(peds[#peds], PlayerPedId(), 0, 16)
    end
end

RegisterNetEvent("md-drugs:client:GetLocation", function(wholesaleData)
    if active then return end
    if not wholesaleData then return end
    active = true
    SetNewWaypoint(wholesaleData.location.x, wholesaleData.location.y)
    Bridge.Notify.SendNotify(Bridge.Language.Locale('wholesale.go_location'), 'success')
    Bridge.Point.Register(
    'md-drugs:wholesaleZone'..Bridge.Framework.GetPlayerIdentifier(),
    vector3(wholesaleData.location.x, wholesaleData.location.y, wholesaleData.location.z),
    50.0,
    nil,
    function(point, data)
        if wholesaleData.ambush then
            SetUpPeds(wholesaleData.attackerCount, wholesaleData.location)
            loop(wholesaleData)
        end
        requestModel(GetHashKey("s_m_m_ammucountry"))
        ped = CreatePed(4, GetHashKey("s_m_m_ammucountry"), wholesaleData.location.x, wholesaleData.location.y, wholesaleData.location.z, wholesaleData.location.w, false, true)
        FreezeEntityPosition(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
        Bridge.Notify.SendNotify(Bridge.Language.Locale('wholesale.meet_dealer'), 'info')
        Bridge.Target.AddLocalEntity(ped, {
            {
                label = Bridge.Language.Locale('wholesale.sell_drugs'),
                icon = Bridge.Language.Locale('wholesale.sell_drugs_icon'),
                action = function()
                    if not progressbar(Bridge.Language.Locale('wholesale.selling_drugs'), 15000) then return end
                    TriggerServerEvent('md-drugs:server:SuccessSale')
                    DeleteEntity(ped)
                    active = false
                    Bridge.Point.Remove('md-drugs:wholesaleZone'.. Bridge.Framework.GetPlayerIdentifier())
                end
            }
        })
    end,
    function(point, data)
        Bridge.Point.Remove('md-drugs:wholesaleZone'.. Bridge.Framework.GetPlayerIdentifier())
        return data
    end)
end)


RegisterNetEvent('md-drugs:client:MarkLocation', function(data)
    SetNewWaypoint(data.x, data.y)
    Bridge.Notify.SendNotify(Bridge.Language.Locale('wholesale.go_location'), 'success')
end)