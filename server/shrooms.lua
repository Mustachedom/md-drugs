
CUI('shrooms', function(source, item)
local src = source
if TriggerClientEvent('md-drugs:client:takeshrooms', src, item.name) then
	RemoveItem(src, 'shrooms', 1)
    --Log(GetName(source) .. ' Took Some Mushrooms', 'shrooms')
    ps.notify(src, 'You Took Some Shrooms!', 'success')
	end
end)

