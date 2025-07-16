

--------------- events

RegisterServerEvent('md-drugs:server:dryoutweed', function()
	local src = source
    local Player = getPlayer(src)
	if RemoveItem(src,"wetcannabis", 1) then
    	AddItem(src,"drycannabis", 1)
		Log(GetName(source) .. ' Dried Weed', 'weed')
    else
		Notifys(src, Lang.Weed.nodry, "error")
	end
end)

local bluntwrap = {'mdreddextro','mdlean'}
for k, v in pairs (bluntwrap) do 
	CUI(v, function(source, item) TriggerClientEvent('md-drugs:client:makeBluntWrap', source) end)
end

local bluntwraps = {'leanbluntwrap', 'dextrobluntwrap', 'bluntwrap'}

for k, v in pairs (bluntwraps) do 
	CUI(v, function(source, item) TriggerClientEvent('md-drugs:client:rollBlunt', source) end)
end


RegisterServerEvent('md-drugs:server:MakeWeedItems', function(data)
	local src = source
	local Player = getPlayer(src) 
	if not Player then return end
	if not GetRecipe(src, data.recipe, data.table, data.item) then return end
end)

RegisterServerEvent('md-drugs:server:makeoil', function(data)
	local src = source
	local Player = getPlayer(src) 
	if not Player then return end
	if not GetRecipe(src, 'weed', 'oil', 'shatter') then return end
end)


CUI("dabrig", function(source, item)
    local src = source
    local Player = getPlayer(src)

    if Player.Functions.GetItemByName("butanetorch") then 
    	if RemoveItem(src, "shatter", 1) then
        	TriggerClientEvent("md-drugs:client:dodabs", src)
        end
    else
    	Notifys(src, 'You Need A Butane Torch', 'error')
    end
end)

CUI("weedgrinder", function(source, item)
    local src = source
    local Player = getPlayer(src)
    local has = Player.Functions.GetItemByName("drycannabis")
    if not has then Notifys(src, 'You Need Dried Cannabis', 'error') return end
     local check = ps.callback('md-drugs:client:uncuff', src, 'Grinding Weed')
    if not check then return end
    if RemoveItem(src, "drycannabis",1 ) then 
    	AddItem(src, "grindedweed", 1)
    end
end)

CUI("mdwoods", function(source, item)
	local src = source
	local Player = getPlayer(src)
     local check = ps.callback('md-drugs:client:uncuff', src, 'Breaking Blunt Open')
    if not check then return end
	if RemoveItem(src, "mdwoods",1 ) then 
		AddItem(src, "bluntwrap", 5)
		AddItem(src, "tobacco", 5)
	end
end)
