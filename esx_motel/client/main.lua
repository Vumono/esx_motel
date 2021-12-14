local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local CachedApartments = {}
local Apartments = {
	[1] = {
		label = 'Motel',
		ipl = 'Motel',
		enter = {x = -270.6047, y = -957.9693, z = 30.2231},
		inside = {x = 151.4854, y = -1007.5345, z = -99.0},
		exit = {x = 151.38, y = -1007.95, z = -100.0},
		closet = {x = 151.8, y = -1001.36, z = -100.0},
		storage = {x = 151.33, y = -1003.08, z = -100.0}
	}
}	
local PlayerData                = {}
local GUI                       = {}
local playerId = PlayerId()
local serverId = GetPlayerServerId(localPlayerId)
local cam = nil
local hidden = {}

ESX = nil






Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj
		end)
		
		Citizen.Wait(0)
	end

	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(100)
	end

	CacheApartments(function()
		for k,v in pairs(Apartments) do
			local owns = HasApartment(k)
			local owned = not visit and not invite
			local ped = PlayerPedId()
			local dist = #(GetEntityCoords(ped)-vector3(-270.6047, -957.9693, 30.2231))
			local Iszone = false

			if dist <= 5.0 then
				Iszone = true
				while Iszone do
					Wait(0)
					if IsControlJustReleased(0, 38) then
						OpenApartmentMenu(k, owns)
					end
				end
			else
				Iszone = false
			end
				

			if owned or visit then
				Session('create', {type = 'apartment', id = apartment})
				exports.qtarget:AddTargetModel({-1663022887}, {
					options = {
						{
							event = "esx_motel:exit",
							icon = "fas fa-sign-out-alt",
							label = "Leave apartment",
							num = 1
						},
						--[[{
							event = "esx_motel:invite",
							icon = "fas fa-address-book",
							label = "Invite",
							num = 2
						},]]
					},
					distance = 2
				})
			end	
			if v.enter ~= nil then
				local coords = v.enter
				local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

				SetBlipSprite(blip, 475)
				SetBlipDisplay(blip, 4)
				SetBlipColour(blip, 2)
				SetBlipScale(blip, 0.8)
				SetBlipAsShortRange(blip, true)

			    BeginTextCommandSetBlipName("STRING")
			    AddTextComponentString('Apartments')
	    		EndTextCommandSetBlipName(blip)
			end
		end

		TriggerServerEvent('esx_sommen_motel:playerLoaded', GetPlayerServerId(PlayerId()))
	end)
end)

local enter = {
	{x = -270.6047, y = -957.9693, z = 30.2231}
}
	
Citizen.CreateThread(function()
	local alreadyEnteredZone = false
	local text = nil
	while true do
		wait = 5
		local ped = PlayerPedId()
		local inZone = false
		for k, coords in pairs(enter) do
			local dist = #(GetEntityCoords(ped)-vector3(coords.x, coords.y, coords.z))
			if dist <= 3.0 then
				wait = 5
				inZone  = true
				text = '<b>Apartment</b></p>[E] Press to enter your apartment'

				if IsControlJustReleased(0, 38) then
				end
				break
			else
				wait = 1000
			end
		end
		
		if inZone and not alreadyEnteredZone then
			alreadyEnteredZone = true
			TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
		end

		if not inZone and alreadyEnteredZone then
			alreadyEnteredZone = false
			TriggerEvent('cd_drawtextui:HideUI')
		end
		Citizen.Wait(wait)
	end
end)

local closet = {
	{x = 151.8, y = -1001.36, z = -100.0}
}
	
Citizen.CreateThread(function()
	local alreadyEnteredZone = false
	local text = nil
	while true do
		wait = 5
		local ped = PlayerPedId()
		local inZone = false
		for k, coords in pairs(closet) do
			local dist = #(GetEntityCoords(ped)-vector3(coords.x, coords.y, coords.z))
			if dist <= 1.5 then
				wait = 5
				inZone  = true
				text = '<b>Closet</b></p>[E] Press to open your closet'

				if IsControlJustReleased(0, 38) then
					TriggerEvent('esx_motel:changeclothingmenu')
				end
				break
			else
				wait = 1000
			end
		end
		
		if inZone and not alreadyEnteredZone then
			alreadyEnteredZone = true
			TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
		end

		if not inZone and alreadyEnteredZone then
			alreadyEnteredZone = false
			TriggerEvent('cd_drawtextui:HideUI')
		end
		Citizen.Wait(wait)
	end
end)


RegisterNetEvent('esx_motel:changeclothingmenu', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "Change Outfit",
			txt = "",
			params = {
				event = "fivem-appearance:pickNewOutfit",
				args = {
					number = 1,
					id = 2
				}
			}
		},
		{
			id = 2,
			header = "Save New Outfit",
			txt = "",
			params = {
				event = "fivem-appearance:saveOutfit"
			}
		},
		{
			id = 3,
			header = "Delete Outfit",
			txt = "",
			params = {
				event = "fivem-appearance:deleteOutfitMenu",
				args = {
					number = 1,
					id = 2
				}
			}
		}
	})
end)




RegisterNetEvent('esx_motel:exit')
AddEventHandler('esx_motel:exit', function()
	SetEntityCoords(PlayerPedId(), -270.6047, -957.9693, 31.2231)

	if owned or visit then
		Session('delete')
	else
		Session('leave')
	end
end)

RegisterNetEvent('esx_motel:invite')
AddEventHandler('esx_motel:invite', function()
	local playersInArea = ESX.Game.GetPlayersInArea(vector3(-270.6047,-957.9693,30.2231), 10.0)
	local elements = {}
		for i=1, #playersInArea, 1 do
			if playersInArea[i] ~= PlayerId() then
				table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
			end
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartments_invite',
			{
				title = 'Invite a friend',
				align = 'top-left',
				elements = elements,
			},
			function(data, menu)
				menu.close()

				Session('invite', GetPlayerServerId(data.current.value), apartment)
			end,
			function(data, menu)
				menu.close()
			end
		)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		for i=1, #hidden, 1 do
			local ped = GetPlayerPed(hidden[i])

			SetEntityLocallyInvisible(ped)
			SetEntityNoCollisionEntity(PlayerPedId(), ped, true)
		end
	end
end)

function Session(data, ...)
	TriggerServerEvent('esx_sommen_motel:session:' .. data, GetPlayerServerId(PlayerId()), ...)
end


RegisterNetEvent('esx_sommen_motel:voiceChannel')
AddEventHandler('esx_sommen_motel:voiceChannel', function(channel)
	if channel ~= nil then
		NetworkSetVoiceChannel(channel)
	else	
		Citizen.InvokeNative(0xE036A705F989E049)
	end
end)

RegisterNetEvent('esx_sommen_motel:show')
AddEventHandler('esx_sommen_motel:show', function(id)
	for i=1, #ESX.Game.GetPlayers(), 1 do
		if GetPlayerServerId(ESX.Game.GetPlayers()[i]) == id then
			for i=1, #hidden, 1 do
				if GetPlayerServerId(hidden[i]) == id then
					table.remove(hidden, i)
			 	end 
			end
		end
	end
end)

RegisterNetEvent('esx_sommen_motel:leave')
AddEventHandler('esx_sommen_motel:leave', function(session)
	if session.data ~= nil then
		if session.data.type == 'apartment' then
			local apartment = session.data.id
			local values = GetApartmentValues(apartment)

			SetEntityCoords(PlayerPedId(), -270.6047, -957.9693, 31.2231)

		else
		end
	end
end)

RegisterNetEvent('esx_sommen_motel:joinedSession')
AddEventHandler('esx_sommen_motel:joinedSession', function(session, identifier)
	if session.data ~= nil then
		if session.data.type == 'apartment' then

			SetEntityCoords(PlayerPedId(), 151.38, -1007.95, -99.0 - 1.0)

		end
	end
end)

RegisterNetEvent('esx_sommen_motel:hide')
AddEventHandler('esx_sommen_motel:hide', function(id)
	for i=1, #ESX.Game.GetPlayers(), 1 do
		if GetPlayerServerId(ESX.Game.GetPlayers()[i]) == id then
			local ped = GetPlayerPed(ESX.Game.GetPlayers()[i])

			table.insert(hidden, ESX.Game.GetPlayers()[i])
		end
	end
end)

RegisterNetEvent('esx_sommen_motel:gotInvite')
AddEventHandler('esx_sommen_motel:gotInvite', function(inviter, apartment)
	OpenConfirmationMenu(function(confirmed)
		if confirmed then
			Session('acceptInvite', inviter)

			SetEntityCoords(PlayerPedId(), 151.38, -1007.95, -99.0 - 1.0)

		end
	end)
end)


function OpenApartmentMenu(apartment, owned)
	local values = GetApartmentValues(apartment)

		if owned then

			SetEntityCoords(PlayerPedId(), 151.38, -1007.95, -99.0 - 1.0)

		else
			CachedApartments[apartment] = {
				owned = true,
				items = '[]'
			}

			MySQL.execute('INSERT INTO motel (id, identifier) VALUES (@id, @identifier)', 
				{
					["@id"] = apartment,
					["@identifier"] = ESX.GetPlayerData().identifier,	
				}
			)

			SetEntityCoords(PlayerPedId(), 151.38, -1007.95, -99.0 - 1.0)
			
		end					    	
end



function HasApartment(apartment)
	return CachedApartments[apartment].owned
end

function GetApartmentValues(apartment)
	for k,v in pairs(Apartments) do
		if k == apartment then
			return v
		end
	end
end

function CacheApartments(callback)
	local identifier = ESX.GetPlayerData().identifier

	MySQL.fetchAll('SELECT * FROM motel WHERE identifier = @identifier', 
	{
		["@identifier"] = identifier,
	}, 
	function(fetched)
		if fetched ~= nil then
			for i=1, #fetched, 1 do
				local row = fetched[i]

				CachedApartments[row.id] = {owned = true}
			end

			callback()
		end
	end)

	for k,v in pairs(Apartments) do
		if CachedApartments[k] == nil then
			CachedApartments[k] = {owned = false}
		end
	end
end

