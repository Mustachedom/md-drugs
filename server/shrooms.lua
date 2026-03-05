if not Config.Drugs['shrooms'] then return end
Bridge.Framework.RegisterUsableItem('shrooms', function(source, item)
    local src = source
    if not Bridge.Callback.Trigger("md-drugs:client:shrooms", src) then
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('shrooms.cancel'), "error")
        return
    end
    Bridge.Inventory.RemoveItem(src, 'shrooms', 1)
    Bridge.Notify.SendNotify(src, Bridge.Language.Locale('shrooms.took'), 'success')
end)

