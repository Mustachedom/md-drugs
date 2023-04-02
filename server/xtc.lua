local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('md-drugs:server:stealisosafrole', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.AddItem("isosafrole", 1) then 
  end	
end)

RegisterServerEvent('md-drugs:server:stealmdp2p', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.AddItem("mdp2p", 1) then 
  end	
end)

RegisterServerEvent('md-drugs:server:makingrawxtc', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("mdp2p", 1) then 
      if Player.Functions.RemoveItem("isosafrole", 1) then
          Player.Functions.AddItem("raw_xtc", 1)
  end	
end)
  
 RegisterServerEvent('md-drugs:server:makextcsingle', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then 
          Player.Functions.AddItem("white_xtc", 1)
  end	
end)
 
 RegisterServerEvent('md-drugs:server:makextcdual', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then 
          Player.Functions.AddItem("white_xtc2", 1)
  end	
end)

 RegisterServerEvent('md-drugs:server:makextctriple', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then 
          Player.Functions.AddItem("white_xtc3", 1)
  end	
end)

 RegisterServerEvent('md-drugs:server:makextcquad', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then 
          Player.Functions.AddItem("white_xtc4", 1)
  end	
end)
  
 RegisterServerEvent('md-drugs:server:makeredxtcsingle', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then 
          Player.Functions.AddItem("white_xtc", 1)
  end	
end)
 
 RegisterServerEvent('md-drugs:server:makextcdual', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then 
       if Player.Functions.RemoveItem("coke", 1) then
            Player.Functions.AddItem("red_xtc", 1)
       end
  end	
end)

 RegisterServerEvent('md-drugs:server:makextctriple', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then 
          Player.Functions.AddItem("white_xtc3", 1)
  end	
end)

 RegisterServerEvent('md-drugs:server:makextcquad', function()
	local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  if Player.Functions.RemoveItem("raw_xtc", 1) then 
          Player.Functions.AddItem("white_xtc4", 1)
  end	
end)
  
