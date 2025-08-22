local locations = MySQL.query.await('SELECT * FROM druglabs WHERE type = ?', {'cocaine'})

ps.registerCallback('md-drugs:server:GetCokeLabLocations', function()
    return locations
end)

RegisterNetEvent('TestCokeLab', function(num)
    local src = source
    saveBucket(src, num)
    SetEntityCoords(GetPlayerPed(src), vector3(1088.62, -3187.54, -38.99))
    local labData = MySQL.query.await('SELECT * FROM druglabs WHERE id = ?', {num})
    if labData and #labData > 0 then
        TriggerClientEvent('md-drugs:client:EnterCokeLab', src, labData[1])
    else
        ps.notify(src, 'Lab data not found.', 'error')
    end
end)

RegisterNetEvent('RestoreCokeLab', function(num)
    local src = source
    restoreBucket(src)
    local loc = json.decode(locations[num].coords)
    SetEntityCoords(GetPlayerPed(src), vector3(loc.x, loc.y, loc.z))
end)

ps.registerCallback('md-drugs:server:GetAvailableEmployees',function(source)
    local src = source
    local identifier = ps.getIdentifier(src)
    local hasLab = MySQL.query.await('SELECT * FROM druglabs WHERE owner = ?', {identifier})
    if hasLab and #hasLab > 0 then
       return MySQL.query.await('SELECT * FROM drug_employees', {})
    end
end)

RegisterNetEvent('md-drugs:server:HireEmployee', function(employeeId)
    local src = source
    local identifier = ps.getIdentifier(src)

    local hasLab = MySQL.query.await('SELECT * FROM druglabs WHERE owner = ?', {identifier})
    if not hasLab or #hasLab == 0 then
        ps.notify(src, 'You do not own a drug lab.', 'error')
        return
    end

    local employee = MySQL.query.await('SELECT * FROM drug_employees WHERE id = ?', {employeeId})
    if not employee or #employee == 0 then
        ps.notify(src, 'Employee not found.', 'error')
        return
    end

    local employeeData = employee[1]
    local currentEmployees = json.decode(hasLab[1].employees) or {}

    for _, emp in ipairs(currentEmployees) do
        if emp.type == employeeData.type then
            ps.notify(src, 'You already have an employee of this type hired.', 'error')
            return
        end
    end

    if ps.removeMoney(src, 'bank', employeeData.salary * 10) then
        table.insert(currentEmployees, employeeData)
        MySQL.update.await('UPDATE druglabs SET employees = ? WHERE owner = ?', {json.encode(currentEmployees), identifier})
        MySQL.query.await('DELETE FROM drug_employees WHERE id = ?', {employeeId})
        TriggerClientEvent('md-drugs:client:EmployeeHired', src, employeeId)
    end
end)

RegisterNetEvent('md-drugs:server:cokeAddStock',function(stock)
    local src = source
    local identifier = ps.getIdentifier(src)

    local hasLab = MySQL.query.await('SELECT * FROM druglabs WHERE owner = ?', {identifier})
    if not hasLab or #hasLab == 0 then
        ps.notify(src, 'You do not own a drug lab.', 'error')
        return
    end

    local stockCheck = verifyHas(src, stock)
    if not stockCheck then
        ps.notify(src, 'You do not have enough items to add to the lab.', 'error')
        return
    end

    for item, amount in pairs(stock) do
        ps.removeItem(src, item, amount)
    end

    local currentStock = json.decode(hasLab[1].inputItems) or {}
    for item, amount in pairs(stock) do
        currentStock[item] = (currentStock[item] or 0) + amount
    end
    MySQL.update.await('UPDATE druglabs SET inputItems = ? WHERE owner = ?', {json.encode(currentStock), identifier})
    ps.notify(src, 'Stock added to your lab successfully.', 'success')
end)

ps.registerCallback('md-drugs:server:getCokeLabItemCount',function(source)
    local src = source
    local identifier = ps.getIdentifier(src)

    local hasLab = MySQL.query.await('SELECT * FROM druglabs WHERE owner = ?', {identifier})
    if not hasLab or #hasLab == 0 then
        ps.notify(src, 'You do not own a drug lab.', 'error')
        return
    end

    local stock = json.decode(hasLab[1].inputItems) or {}
    local inputData, itemOrder = {}, {}
    for item, amount in pairs(stock) do
        table.insert(inputData, {
            type = 'number',
            max = amount,
            title = ps.getItemLabel(item),
            required = true,
            min = 0,
            item = item,
        })
        itemOrder[item] = amount
    end
    return {input = inputData, order = itemOrder}
end)

RegisterNetEvent('md-drugs:server:cokeTakeDrugs', function(data)
    local src = source
    local identifier = ps.getIdentifier(src)
    ps.debug(data)
    local hasLab = MySQL.query.await('SELECT * FROM druglabs WHERE owner = ?', {identifier})
    if not hasLab or #hasLab == 0 then
        ps.notify(src, 'You do not own a drug lab.', 'error')
        return
    end

    local stock = json.decode(hasLab[1].inputItems) or {}
    if next(stock) == nil then
        ps.notify(src, 'No drugs available to take.', 'error')
        return
    end

    for item, amount in pairs(data) do
        if not stock[item] then
            goto skip
        end
        if stock[item] < amount then
            ps.notify(src, 'Insufficient stock for ' .. ps.getItemLabel(item) .. '.', 'error')
            goto skip
        end
        if amount == 0 then
            goto skip
        end
       if ps.addItem(src, item, amount) then
           stock[item] = stock[item] - amount
           if stock[item] == 0 then
               stock[item] = nil
           end
       else
           ps.notify(src, 'Failed to add ' .. ps.getItemLabel(item) .. ' to your inventory.', 'error')
       end
        ::skip::
    end
    MySQL.update.await('UPDATE druglabs SET inputItems = ? WHERE owner = ?', {json.encode(stock), identifier})
end)