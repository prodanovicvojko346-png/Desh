
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('pravise:vezivanje')
AddEventHandler('pravise:vezivanje', function(target)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and target ~= -1 then
		if drugijebeniigrac then -- dali id ove osobe postoji?
			if udaljenost < 8.0 then
				if src ~= target then
					TriggerClientEvent('lolcina:vezivanje', target)
					return
				end
			end
		end
	end

	DropPlayer(src, 'Protected')
end)

RegisterNetEvent('hMafije:vuci')
AddEventHandler('hMafije:vuci', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xJob = xPlayer.job
    local drugijebeniigrac = ESX.GetPlayerFromId(target)
    local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

    if xJob and target ~= -1 then
        if drugijebeniigrac then
            if src ~= target then
                TriggerClientEvent('lux:vuci', target, src)
                TriggerClientEvent('hMafije:nesto', src, target)
                
                return
            end
        end
    end
end)


RegisterNetEvent('hMafije:vuci2')
AddEventHandler('hMafije:vuci2', function(target)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local xJob = xPlayer.job
	local drugijebeniigrac = ESX.GetPlayerFromId(target)
	local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

	if xJob and target ~= -1 then
		if drugijebeniigrac then 
			if src ~= target then
				TriggerClientEvent('lux:pustivucenje', target, src)
				return
			end
		end
	end

end)