
AddEventHandler("pretrazivanjelux", function()
	local igrac = PlayerPedId()
    exports.rprogress:Custom({
        Async = false, Duration = 4000, Label = "Pretrazujete igraca...",
        canCancel = true,
        Animation = {
			animationDictionary = "missexile3",
			animationName = "ex03_dingy_search_case_base_michael"
        },
        onComplete = function(canceled)
            if not canceled then
                exports.ox_inventory:openNearbyInventory()
                ClearPedTasks(igrac)
            end
        end,
    })
end)

local dragStatus = {}

RegisterNetEvent('lolcina:vezivanje')
AddEventHandler('lolcina:vezivanje', function()
	isHandcuffed = not isHandcuffed
	local playerPed = PlayerPedId()
		if isHandcuffed then
		RequestAnimDict('mp_arresting')
		while not HasAnimDictLoaded('mp_arresting') do Wait(0) end
		TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)
		DisplayRadar(false)
	else
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)


RegisterNetEvent('lolcina:odvezivanje')
AddEventHandler('lolcina:odvezivanje', function()
	if isHandcuffed then
		local playerPed = PlayerPedId()
		isHandcuffed = false
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
	end
end)


RegisterNetEvent('lolcina:vuci')
AddEventHandler('lolcina:vuci', function(copId)
	if not isHandcuffed then return end
	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.CopId = copId
end)

local target2 = nil

RegisterNetEvent('lolcina:nesto')
AddEventHandler('lolcina:nesto', function(target)
	kurac = true
	target2 = nil
	target2 = target
end)


local darkdoktor = TriggerServerEvent
local vezan = false
local OsobaMrtva = false

orge = {
    ["police"] = -1,
    ["ukp"] = -8,
    ["dmb"] = -1,
    ["omerta"] = -1,
    ["black"] = -1,
	["yakuza"] = -1,
    ["ruskamafija"] = -1,
    ["kavacki"] = -1,
	["nemci"] = -1,
	["anarchy"] = -1,
    ["triads"] = -1,
    ["simperi"] = -1,
    ["tunershop"] = -1,
    ["kindergarten"] = -1,
    ["scarface"] = -1,
    ["misevi"] = -1,
    ["japanci"] = -1,
    ["japancars"] = -1,
    ["vozdovacki"] = -1,
    ["loslocos"] = -1,
    ["buksnaland"] = -1,
    ["tigrovi"] = -1,
    ["teqila"] = -1,
    ["pinkpanteri"] = -1,
  ["chicago"] = -1,
    ["automafija"] = -1,
    ["picerija"] = -1,
    ["alkaida"] = -1,
    ["zemunski"] = -1,
    ["bratva"] = -1,
    ["bahama"] = -1,
    ["novosadjani"] = -1,
    ["zaza"] = -1,
    ["bahamas"] = -1,
   ["h2o"] = -1,
    ["bloods"] = -1,
    ["sinaloa"] = -1,
    ["bq"] = -1,
    ["gsf"] = -1,
    ["brazilci"] = -1,
    ["ltf"] = -1,
    ["vagos"] = -1,
    ["ballas"] = -1,
    ["skyloft"] = -1,
    ["medelin"] = -1,
    ["mexican"] = -1,
    ["bolivija"] = -1,
    ["barani"] = -1,
    ["skaljarski"] = -1,
    ["asasin"] = -1,
    ["delija"] = -1,
    ["crnogorci"] = -1,
    ["grobari"] = -1,
    ["bajkeri"] = -1,
    ["camorra"] = -1,
    ["hitman"] = -1,
    ["lcn"] = -1,
    ["krava"] = -1,
    ["cartel"] = -1,
    ["sopranos"] = -1,
    ["clowns"] = -1,
    ["spijuni"] = -1,
    ["crips"] = -1,
	["casino"] = -1,
    ["shadows"] = -1,
    ["ltr"] = -1,
    ["og"] = -1,
	["sindikat"] = -1,
    ["cayoperico"] = -1,
    ["konicari"] = -1,
    ["fbi"] = -1,
    ["saj"] = -1
}
exports.qtarget:Player({
	options = {
	{
		event = "pretrazivanjelux",
		icon = "fa-solid fa-magnifying-glass",
		label = "Pretrazivanje",
		job = orge,
		num = 2
	  },
        {
            icon = "fa-solid fa-handcuffs",
            label = "Vezivanje",
            job = orge,
            action = function(entity)
                if not isDead then
                    TriggerServerEvent('pravise:vezivanje', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
                else
                    ESX.ShowNotification('Ne mozes to radit dok si mrtav')
                end
            end,
            num = 3,
        },
        {
            icon = "fa-solid fa-hand",
            label = "Vuci",
            job = orge,
            action = function(entity)
                if not isDead then
                    TriggerServerEvent('hMafije:vuci', GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
                else
                    ESX.ShowNotification('Ne mozes to radit dok si mrtav')
                end
            end,
            num = 4,
        },
	},
	distance = 2
  
})





Citizen.CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()
		if isHandcuffed then
			DisableControlAction(0, 1, true) -- Disable pan
			DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S
			DisableControlAction(0, 30, true) -- D
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 23, true) -- Also 'enter'?
			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 0, true) -- Disable changing view
			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			if not IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Wait(2000)
		end
	end
end)






















local dragStatus = {}, {}
dragStatus.isDragged = falsessss



local draggedBy = -1
local drag = false
local wasDragged = false

RegisterNetEvent("hMafije:vuci")
AddEventHandler("hMafije:vuci", function(_source)
    draggedBy = _source
    drag = not drag
end)

RegisterNetEvent("lux:vuci", function(dragger)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(dragger))

	if not IsPedSittingInAnyVehicle(playerPed) then
		AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
	else
		DetachEntity(targetPed, true, false)
	end

	if IsPedDeadOrDying(playerPed, true) then
		DetachEntity(targetPed, true, false)
	end
end)


local target2 = nil

RegisterNetEvent('hMafije:nesto')
AddEventHandler('hMafije:nesto', function(target)
	kurac = true
	target2 = nil
	target2 = target
end)

Citizen.CreateThread(function()
    while true do
        Wait(10)
        if kurac then
            local playerPed = PlayerPedId()
            local player = GetPlayerPed(-1)
            local vehicle = GetVehiclePedIsIn(player, false)
            if IsPedInAnyVehicle(player, false) then
                TaskLeaveVehicle(playerPed, vehiclesssss, 0)
                DisablePlayerFiring(player, true)
            end
            if IsControlJustReleased(0, 323) then
                DisablePlayerFiring(playerPed, false)
                TriggerServerEvent('hMafije:vuci2', target2)
                TriggerEvent('lux:pustivucenje')
                DetachEntity(playerPed, true, true) 
                kurac = false
            end
        end
    end
end)

RegisterNetEvent("lux:pustivucenje", function()
	DetachEntity(PlayerPedId(), true, true) 
end)