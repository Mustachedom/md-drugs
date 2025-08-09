local miss = false
local function SetUpPeds()
	AddRelationshipGroup('setups')
	local ped = GetEntityCoords(PlayerPedId())
	local peds = {
		{x = ped.x+3, y = ped.y-5,  z = ped.z-1, },
		{x = ped.x+6, y = ped.y-10, z =  ped.z-1,},
		{x = ped.x+-2,y =  ped.y+5, z =  ped.z-1,},
		{x = ped.x+8, y = ped.y-12, z =  ped.z-1,},
		{x = ped.x+5, y = ped.y-2,  z = ped.z-1, },
		{x = ped.x+2, y = ped.y-20, z =  ped.z-1,},
		{x = ped.x+1, y = ped.y-10, z =  ped.z-1,},
	}
	for i = 1, #peds do 
		local k = peds[i] 
		i = CreatePed(0, "g_m_y_famdnf_01", k.x, k.y, k.z, 90.0, true, true)
		SetPedRelationshipGroupHash(i, 'setups')
		GiveWeaponToPed(i, "weapon_pistol", 1, false, true)
		TaskCombatPed(i, PlayerPedId(), 0, 16)
		SetPedCombatAttributes(i, 46, true)
	end
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
       ps.requestModel("g_m_y_famdnf_01", Config.RequestModelTime)
       local drugdealer = CreatePed(0, "g_m_y_famdnf_01",loc.x,loc.y,loc.z-1, 90.0, false, false)
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
                    ps.notify(ps.lang('wholesale.uhoh'), 'error')
                    SetUpPeds()
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
       end
    end
end)


