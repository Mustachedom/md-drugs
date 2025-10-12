fx_version 'cerulean'
game 'gta5'

lua54 'yes'
this_is_a_map 'yes'

author 'Atenea'
description 'Props para ti <3'
version '1.0.1'

---------------------------------------------------------------------------
-- INCLUDED FILES
---------------------------------------------------------------------------
files {
    'stream/*.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/*.ytyp'

dependency '/assetpacks'


escrow_ignore {
    'stream/*.ydr',
}
