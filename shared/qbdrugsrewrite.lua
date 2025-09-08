QBConfig = {}
-----------  qb-drugs update built in here below
----------- Everything is now a target and not displaytext. Dealers are no longer just doors, they will spawn peds where you place your dealer. This is a literally qb-drugs with SLIGHT edits. mainly added peds for deliveries, made everything a target
QBConfig.Dealers = {}

-- Delivery locations and items is now in server/deliveries.lua 
-- cornerselling pricing and rep is now in server/cornerselling.lua 

QBConfig.NoSellZones = {
    {loc = vector3(445.11, -991.3, 30.69), width = 10.0, length = 10.0, height = 10.0, rot = 180.0},
}
QBConfig.SellLevel = {
   {price = 0.5, minrep = 0,    maxrep = 240,  label = 'Rookie'},
   {price = 1.0, minrep = 240,  maxrep = 600,  label = 'Corner Boy'},
   {price = 1.1, minrep = 600,  maxrep = 1200, label = 'Corner Man'},
   {price = 1.2, minrep = 1200, maxrep = 1800, label = 'Dope Peddler'},
   {price = 1.3, minrep = 1800, maxrep = 2400, label = 'Drug Supplier'},
   {price = 1.5, minrep = 2400, maxrep = 4800, label = 'Drug Pusher'},
   {price = 1.75, minrep = 4800, maxrep = 99999999999999, label = 'Drug Lord'},
}