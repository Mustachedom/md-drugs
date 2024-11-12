name "mustache-drugs"
author "mustache_dom"
description "drugs by mustache dom"
fx_version "cerulean"
game "gta5"
version  '3.8.0'
client_scripts {
	'client/**.lua',
}

server_scripts {
   	'server/**.lua',
	'@oxmysql/lib/MySQL.lua',
	
}

shared_scripts {
	'@ox_lib/init.lua',
	'shared/**.lua',

}


lua54 'yes'


dependency 'bob74_ipl'
files {
    'stream/mushroom.ytyp',
    'stream/mushroom.ydr'
}

data_file 'DLC_ITYP_REQUEST' 'stream/mushroom.ytyp'
