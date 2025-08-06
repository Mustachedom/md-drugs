
ps.registerCallback("md-drugs:client:shrooms", function()
    if not ps.progressbar(ps.lang('Shrooms.eat'), 5000, 'eat')  then return end
    CreateThread(function()
        EcstasyEffect()
    end)
    return true
end)