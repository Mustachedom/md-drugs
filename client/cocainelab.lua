local inside = false
local peds = {}
local labData = {}
cocaineLab = false
local insideLocation = nil

local function CutCoke(coords, offset, rotation)
    CreateThread(function()
	    local animDict, animName = "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v5_coccutter"
	    ps.requestAnim(animDict, 500)
	    local animDuration = GetAnimDuration(animDict, animName) * 1000
        if not peds['CutCoke'] then
            ps.requestModel('ig_priest', 500)
            peds['CutCoke'] = CreatePed(4, 'ig_priest', coords.x + 1.0, coords.y + 1.0, coords.z - 1.0, 0.0, true, true)
            FreezeEntityPosition(peds['CutCoke'], true)
            SetEntityInvincible(peds['CutCoke'], true)
            SetBlockingOfNonTemporaryEvents(peds['CutCoke'], true)
        end
        local ped = peds['CutCoke']
	    local scenePos, sceneRot = vector3(coords.x + offset.x, coords.y + offset.y,coords.z + offset.z), rotation
	    local scenes = {
	    {
	    	{	hash = "bkr_prop_coke_bakingsoda_o",	animName = "coke_cut_v5_bakingsoda"},
	    	{	hash = "prop_cs_credit_card",	animName = "coke_cut_v5_creditcard"},
	    	{	hash = "prop_cs_credit_card",	animName = "coke_cut_v5_creditcard^1"}
	    },
}   
	    local scenesList, entitiesList = {}, {}
	    for i=1, #scenes, 1 do
	    	local scene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
	    	NetworkAddPedToSynchronisedScene(ped, scene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)
	    	for j=1, #scenes[i], 1 do
	    		local s = scenes[i][j]
	    		RequestModel(s.hash)
	    		while not HasModelLoaded(s.hash) do
	    			Wait(0)
	    		end
	    		local obj = CreateObjectNoOffset(s.hash, coords, true, true, true)
	    		SetModelAsNoLongerNeeded(s.hash)
	    		entitiesList[#entitiesList+1] = obj
	    		NetworkAddEntityToSynchronisedScene(obj, scene, animDict, s.animName, 4.0, -8.0, 1)
	    	end
	    	scenesList[#scenesList+1] = scene
	    end
	    DisableCamCollisionForEntity(ped)
	    FreezeEntityPosition(ped, true)
	    for i=1, #scenesList, 1 do
	    	NetworkStartSynchronisedScene(scenesList[i])
	    end

	    Wait(animDuration-11000)
	    for i=1, #scenesList, 1 do
	    	NetworkStopSynchronisedScene(scenesList[i])
	    end
	    for i=1, #entitiesList, 1 do
	    	DeleteEntity(entitiesList[i])
	    end
	    RemoveAnimDict(animDict)
	    FreezeEntityPosition(ped, false)
        if inside then
            CutCoke(coords, offset, rotation)
        end
    end)
end

local function BagCoke(coords, offset, rotation)
    CreateThread(function()
        local ver = ""
	    local animDict, animName = "anim@amb@business@meth@meth_smash_weight_check@", "break_weigh_"..ver.."char01"
	    ps.requestAnim(animDict, 500)
	    local animDuration = GetAnimDuration(animDict, animName) * 1000
        if not peds['BagCoke'] then
            ps.requestModel('ig_priest', 500)
            peds['BagCoke'] = CreatePed(4, 'ig_priest', coords.x + 1.0, coords.y + 1.0, coords.z - 1.0, 0.0, true, true)
            FreezeEntityPosition(peds['BagCoke'], true)
            SetEntityInvincible(peds['BagCoke'], true)
            SetBlockingOfNonTemporaryEvents(peds['BagCoke'], true)
        end
	    local scenePos, sceneRot = vector3(coords.x + offset.x, coords.y + offset.y,coords.z + offset.z), rotation
	    local scenes = {
        	{
        		{	hash = "bkr_prop_coke_cutblock_01",	animName = "break_weigh_"..ver.."box01"},
        		{	hash = "bkr_prop_coke_fullmetalbowl_02",	animName = "break_weigh_"..ver.."box01^1"},
        		{	hash = "bkr_prop_coke_cutblock_01",	animName = "break_weigh_"..ver.."methbag01"}
        	},
        	{
        		{	hash = "xm3_prop_xm3_bag_coke_01a",	animName = "break_weigh_"..ver.."methbag01^1"},
        		{	hash = "xm3_prop_xm3_bag_coke_01a",	animName = "break_weigh_"..ver.."methbag01^2"},
        		{	hash = "xm3_prop_xm3_bag_coke_01a",	animName = "break_weigh_"..ver.."methbag01^3"}
        	},
        	{
        		{	hash = "bkr_prop_coke_fullscoop_01a",	animName = "break_weigh_"..ver.."scoop"},
        		{	hash = "bkr_prop_coke_scale_01",	animName = "break_weigh_"..ver.."scale"},
        		{	hash = "bkr_prop_fakeid_penclipboard",	animName = "break_weigh_"..ver.."pen"}
        	},
        	{
        		{	hash = "bkr_prop_fakeid_clipboard_01a",	animName = "break_weigh_"..ver.."clipboard"},
        	}
        }
        local scenesList, entitiesList = {}, {}
        for i=1, #scenes, 1 do
        	local scene = NetworkCreateSynchronisedScene(scenePos, sceneRot, 2, false, false, 1065353216, 0, 1.3)
        	NetworkAddPedToSynchronisedScene(peds['BagCoke'], scene, animDict, animName, 1.5, -4.0, 1, 16, 1148846080, 0)
        	for j=1, #scenes[i], 1 do
        		local s = scenes[i][j]
        		RequestModel(s.hash)
        		while not HasModelLoaded(s.hash) do
        		Wait(0)
        		end
        		local obj = CreateObjectNoOffset(s.hash, coords, true, true, true)
        		SetModelAsNoLongerNeeded(s.hash)
        		entitiesList[#entitiesList+1] = obj
        		NetworkAddEntityToSynchronisedScene(obj, scene, animDict, s.animName, 4.0, -8.0, 1)
        	end
        	scenesList[#scenesList+1] = scene
        end
        DisableCamCollisionForEntity(peds['BagCoke'])
        FreezeEntityPosition(peds['BagCoke'], true)
        for i=1, #scenesList, 1 do
        	NetworkStartSynchronisedScene(scenesList[i])
        end

        Wait(animDuration-11000)
        for i=1, #scenesList, 1 do
        	NetworkStopSynchronisedScene(scenesList[i])
        end
        for i=1, #entitiesList, 1 do
        	DeleteEntity(entitiesList[i])
        end
        RemoveAnimDict(animDict)
        FreezeEntityPosition(peds['BagCoke'], false)
        if inside then
            BagCoke(coords, offset, rotation)
        end
    end)
end

RegisterCommand('cocaineMake', function()
    inside = true
    CutCoke(vector3(1095.61, -3195.62, -39.13), vector3(-1.782227, 0.445068, -0.502701), vector3(0,0,0))
    BagCoke(vector3(1093.16, -3195.78, -39.19), vector3(4.515137, 2.542969, -0.814194), vector3(0,0,180.0))
end)

local locs = ps.callback('md-drugs:server:GetCokeLabLocations')

for k, v in pairs (locs) do
	v.coords = json.decode(v.coords)
	local loc = vector3(v.coords.x, v.coords.y, v.coords.z)
	ps.boxTarget('drugLabcoke'..k, loc, {},{
		{
			label = 'Purchase Lab',
			action = function()
				ps.debug(v)
			end,
			canInteract = function()
				if v.owner then
					return false
				end
				return true
			end
		},
		{
			label = 'Enter Lab',
			action = function()
				TriggerServerEvent('TestCokeLab', k)
				insideLocation = k
			end,
			canInteract = function()
				if v.owner == ps.getIdentifier() then return true end
				if ps.tableContains(json.decode(v.allowedIn) or {}, ps.getIdentifier()) then return true end
				return false
			end
		},
		{
			label = 'Raid Lab',
			action = function()
				ps.debug(v)
			end,
			canInteract = function()
				if v.owner and ps.getJobType() == 'leo' then
					return true
				end
				return false
			end
		}
	})
end

ps.boxTarget('cokelabLeave', vector3(1088.64, -3187.21, -38.24), {length = 1.0, width = 1.0, height = 1.0, rotation = 180.0}, {
    {
        label = 'Leave Lab',
        action = function()
            inside = false
            cocaineLab = false
            TriggerServerEvent('RestoreCokeLab', insideLocation)
			for k, v in pairs(peds) do
				DeleteEntity(v)
			end
			labData = {}
        end,
        canInteract = function()
            return inside and cocaineLab
        end
    }
})

local function getInputData()
	if Config.TierSystem then
		return {
			{required = true, min = 0, type = 'number', title = ps.getLabel('coca_leaf'), max = ps.getItemCount('coca_leaf')},
			{required = true, min = 0, type = 'number', title = ps.getLabel('bakingsoda'), max = ps.getItemCount('bakingsoda')},
			{required = true, min = 0, type = 'number', title = ps.getLabel('loosecoke'), max = ps.getItemCount('loosecoke')},
			{required = true, min = 0, type = 'number', title = ps.getLabel('loosecokestagetwo'), max = ps.getItemCount('loosecokestagetwo')},
			{required = true, min = 0, type = 'number', title = ps.getLabel('loosecokestagethree'), max = ps.getItemCount('loosecokestagethree')},
			{required = true, min = 0, type = 'number', title = ps.getLabel('empty_weed_bag'), max = ps.getItemCount('empty_weed_bag')},
		}
	end
	return {
		{required = true, min = 0, type = 'number', title = ps.getLabel('coca_leaf'), max = ps.getItemCount('coca_leaf')},
		{required = true, min = 0, type = 'number', title = ps.getLabel('bakingsoda'), max = ps.getItemCount('bakingsoda')},
		{required = true, min = 0, type = 'number', title = ps.getLabel('loosecoke'), max = ps.getItemCount('loosecoke')},
		{required = true, min = 0, type = 'number', title = ps.getLabel('empty_weed_bag'), max = ps.getItemCount('empty_weed_bag')},
	}
end

local function returnResults(data) 
	if Config.TierSystem then
		local Items = {
			coca_leaf = data[1] or 0,
			bakingsoda = data[2] or 0,
			loosecoke = data[3] or 0,
			loosecokestagetwo = data[4] or 0,
			loosecokestagethree = data[5] or 0,
			empty_weed_bag = data[6] or 0,
		}
		for k, v in pairs (Items) do
			if v == 0 then
				Items[k] = nil
			end
		end
		return Items
	end
	local Items = {
		coca_leaf = data[1] or 0,
		bakingsoda = data[2] or 0,
		loosecoke = data[3] or 0,
		empty_weed_bag = data[4] or 0,
	}
	for k, v in pairs (Items) do
		if v == 0 then
			Items[k] = nil
		end
	end
	return Items
end

local function getDescript(employee) 
	local strings = ''
	strings = strings .. 'Hiring Cost: $' .. employee.salary * 10 .. '\n'
	strings = strings .. 'Salary: $'..employee.salary..'\n'
	strings = strings .. 'Job: ' .. employee.type..'\n'
	strings = strings .. 'Skills: \n'
	for k, v in pairs (json.decode(employee.skills) or {}) do
		strings = strings .. '- ' .. k .. ': ' .. v .. '\n'
	end
	return strings
end
local function openDrugLabMenu()
	local options = {
		{
			title = 'Lab Management',
			description = 'Manage the overall operations of your drug lab',
			action = function()
				local options = {
					{
						title = 'Add Funds',
						description = 'Add money to your drug lab\'s budget',
						action = function()
							local input = ps.input('Enter the amount of money to add:', {
								{type = 'number', min = 0, required = true}
							})
							if input and input[1] then
								TriggerServerEvent('md-drugs:server:AddLabFunds', tonumber(input[1]))
							end
						end
					},
					{
						title = 'Withdraw Funds',
						description = 'Withdraw money from your drug lab\'s budget',
						action = function()
							local input = ps.input('Enter the amount of money to withdraw:', {
								{type = 'number', min = 0, required = true}
							})
							if input and input[1] then
								TriggerServerEvent('md-drugs:server:WithdrawLabFunds', tonumber(input[1]))
							end
						end
					},
					{
						title = 'Give Access',
						description = 'Grant other players access to your drug lab',
						action = function()
							local input = ps.input('Enter the player ID to give access:', {
								{type = 'number', min = 1, required = true}
							})
							if input and input[1] then
								TriggerServerEvent('md-drugs:server:GiveLabAccess', tonumber(input[1]))
							end
						end
					},
					{
						title = 'Revoke Access',
						description = 'Remove other players\' access to your drug lab',
						action = function()
							local input = ps.input('Enter the player ID to revoke access:', {
								{type = 'number', min = 1, required = true}
							})
							if input and input[1] then
								TriggerServerEvent('md-drugs:server:RevokeLabAccess', tonumber(input[1]))
							end
						end
					}
				}
				ps.menu('Lab Management', 'Manage your drug lab', options)
			end,
		},
		{
			title = 'Manage Employees',
			description = 'View and manage your current drug lab employees',
			action = function()
				local options = {
					{
        				title = 'Hire Employees',
						description = 'Manage your drug lab employees',
        				action = function()
        				    local employees = ps.callback('md-drugs:server:GetAvailableEmployees')
   							local options = {}
							for k,v in pairs (employees) do
								options[#options+1] = {
									title = v.name,
									description = getDescript(v),
									action = function()
										TriggerServerEvent('md-drugs:server:HireEmployee', v.id)
									end,
								}
							end
							ps.menu('Drug Employees', 'Drug Employees', options)
        				end,
    				},
					{
						title = 'Fire Employees',
						description = 'Manage your drug lab employees',
						action = function()
							local employees = ps.callback('md-drugs:server:GetAvailableEmployees')
							local options = {}
							for k,v in pairs (employees) do
								options[#options+1] = {
									title = v.name,
									description = getDescript(v),
									action = function()
										local input = ps.input('Are you sure you want to fire this employee?', {
											{type = 'select', title = 'Confirm', options = {{label = 'Yes', value = true}, {label = 'No', value = false}}, required = true}
										})
										if input and input[1] == true then
											TriggerServerEvent('md-drugs:server:FireEmployee', v.id)
										end
									end,
								}
							end
							ps.menu('Drug Employees', 'Drug Employees', options)
						end,
					},
					{
						title = 'Train Employees',
						description = 'Improve the skills of your drug lab employees',
						action = function()
							local employees = ps.callback('md-drugs:server:GetAvailableEmployees')
							local options = {}
							for k,v in pairs (employees) do
								options[#options+1] = {
									title = v.name,
									description = getDescript(v),
									action = function()
										TriggerServerEvent('md-drugs:server:TrainEmployee', v.id)
									end,
								}
							end
							ps.menu('Train Employees', 'Select an employee to train', options)
						end,
					}
				}
				ps.menu('Manage Employees', 'Manage your drug lab employees', options)
			end,
		},
		{
			title = 'Input Stock Management',
			description = 'Manage the raw materials and supplies for your drug lab',
			action = function()
				local options = {
					{
						title = 'Input Stock',
						description = 'Add raw materials to your drug lab inventory',
						action = function()
							local input = ps.input('Enter the amount of stock to add:',getInputData())
							if not input or not input[1] then return end
							TriggerServerEvent('md-drugs:server:cokeAddStock', returnResults(input))
						end,
					},
					{
						title = 'Take Drug Ingredients',
						description = 'Withdraw finished products from your drug lab',
						action = function()
								local itemData = ps.callback('md-drugs:server:getCokeLabItemCount')
								if not itemData.input or #itemData.input == 0 then
									ps.notify('No drugs available to take.', 'error')
								return
							end
							local input = ps.input('Enter the amount of drugs to take:', itemData.input)
							if not input or not input[1] then return end
							local itemList = {}
					    	for i = 1, #input do
					        	local itemInfo = itemData.input[i]
					        	local value = tonumber(input[i])

					        	if not value or value < 0 then
					        	    ps.notify('Invalid amount entered.', 'error')
					        	    return
					        	end

					        	if value > 0 and itemInfo and itemInfo.item then
					        	    itemList[itemInfo.item] = value
					        	end
					    	end
							TriggerServerEvent('md-drugs:server:cokeTakeDrugs', itemList)
						end,
					}
				}
				ps.menu('Input Stock Management', 'Manage your drug lab\'s raw materials and supplies', options)
			end,
		},
	}
	ps.menu('Cocaine Lab Management', 'Cocaine Lab Management', options)
end

ps.boxTarget('cokeLabManagement', vector3(1099.67, -3193.13, -38.99), {length = 1.0, width = 1.0, height = 1.0, rotation = 0.0}, {
    {
        label = 'Open Coke Management',
        action = function()
           openDrugLabMenu()
        end,
		canInteract = function()
			if inside and cocaineLab and ps.getIdentifier() == labData.owner then
				return true
			end
			if labData and labData.allowedIn and ps.tableContains(labData.allowedIn, ps.getIdentifier()) then
				return true
			end
			return false
		end
    },
})

RegisterNetEvent('md-drugs:client:EnterCokeLab', function(data)
	inside = true
	cocaineLab = true
	labData = data
	labData.coords = json.decode(labData.coords)
	labData.allowedIn = json.decode(labData.allowedIn) or {}
	labData.employees = json.decode(labData.employees) or {}
	for k, v in pairs (labData.employees) do
		if v.type == 'packer' then
			BagCoke(vector3(1093.16, -3195.78, -39.19), vector3(4.515137, 2.542969, -0.814194), vector3(0,0,180.0))
		end
		if v.type == 'mixer' then
			CutCoke(vector3(1095.61, -3195.62, -39.13), vector3(-1.782227, 0.445068, -0.502701), vector3(0,0,0))
		end
	end
end)
