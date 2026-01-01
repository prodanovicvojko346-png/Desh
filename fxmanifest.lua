
-- Resource Metadata
fx_version 'bodacious'
games { 'gta5' }

author 'rubbertoe98'
description 'CarryPeople'
version '1.0.0'
lua54 'yes'

shared_scripts {
        '@es_extended/imports.lua',
        '@ox_lib/init.lua'
}


client_script "cl_carry.lua"
server_script "sv_carry.lua"

--shared_script "anvil.lua"