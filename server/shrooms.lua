
ps.createUseable('shrooms', function(source, item)
    local src = source
    if not ps.callback("md-drugs:client:shrooms", src) then
        ps.notify(src, ps.lang('Shrooms.cancel'), "error")
        return
    end
    ps.removeItem(src, 'shrooms', 1)
    ps.notify(src, 'You Took Some Shrooms!', 'success')
end)

