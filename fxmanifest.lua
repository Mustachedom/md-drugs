name "mustache-drugs"
author "mustache_dom"
description "drugs by mustache dom"
fx_version "cerulean"
game "gta5"
version  '3.9.0'

client_scripts {
	--'@qbx_core/modules/playerdata.lua',
	'client/**.lua',
}

server_scripts {
	'server/functions.lua',
   	'server/**.lua',
	'@oxmysql/lib/MySQL.lua',
}

shared_scripts {
	'shared/config.lua',
	'@ox_lib/init.lua',
	'shared/**.lua',
}

lua54 'yes'

files {
    'stream/mushroom.ytyp',
    'stream/mushroom.ydr'
}

data_file 'DLC_ITYP_REQUEST' 'stream/mushroom.ytyp'
