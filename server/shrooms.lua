
ps.createUseable('shrooms', function(source, item)
    local src = source
    if not ps.callback("md-drugs:client:shrooms", src) then
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('shrooms.cancel'), "error")
        return
    end
    ps.removeItem(src, 'shrooms', 1)
    Bridge.Notify.SendNotify(src, Bridge.Language.Locale('shrooms.took'), 'success')
end)

