CreateThread(function()
	RequestStreamedTextureDict("rectmap", false)
	while not HasStreamedTextureDictLoaded("rectmap") do
		Wait(100)
	end
	AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "rectmap", "radarmasksm")
end)

CreateThread(function()
	if not CONFIG.DISPLAY_N_BLIP then
		SetBlipAlpha(GetNorthRadarBlip(), 0)
	end

	if not CONFIG.DISPLAY_IN_CAR then
		DisplayRadar(false)

		if GetResourceState('es_extended') == "started" or GetResourceState('es_extended') == "starting" then
			AddEventHandler('esx:enteredVehicle', function()
				DisplayRadar(true)

				SendNUIMessage({
					display = true,
					data = GetMinimapAnchor(),
				})
			end)
			AddEventHandler('esx:exitedVehicle', function()
				DisplayRadar(false)

				SendNUIMessage({
					display = false,
				})
			end)
		elseif GetResourceState('baseevents') == "started" or GetResourceState('baseevents') == "starting" then
			AddEventHandler('baseevents:enteredVehicle', function()
				DisplayRadar(true)

				SendNUIMessage({
					display = true,
					data = GetMinimapAnchor(),
				})
			end)

			AddEventHandler('baseevents:leftVehicle', function()
				DisplayRadar(false)

				SendNUIMessage({
					display = false,
				})
			end)
		else
			print("Use ESX Legacy or baseevents in order to disable display of minimap in vehicles!")
		end
	else
		Wait(0)
		DisplayRadar(true)

		SendNUIMessage({
			display = true,
			data = GetMinimapAnchor(),
		})
	end

	if not CONFIG.DISPLAY_ON_PAUSEMENU then
		if GetResourceState('es_extended') == "started" or GetResourceState('es_extended') == "starting" then
			AddEventHandler('esx:pauseMenuActive', function(isActive)
				if isActive then
					DisplayRadar(false)

					SendNUIMessage({
						display = false,
					})
				else
					if not CONFIG.DISPLAY_IN_CAR then
						if IsPedInAnyVehicle(PlayerPedId(), false) then
							DisplayRadar(true)

							SendNUIMessage({
								display = true,
								data = GetMinimapAnchor(),
							})
						end
					else
						DisplayRadar(true)

						SendNUIMessage({
							display = true,
							data = GetMinimapAnchor(),
						})
					end
				end
			end)
		else
			print("Use ESX in order to hide minimap on pausemenu!")
		end
	end		

	if not CONFIG.DISPLAY_ON_OXINVENTORY then
		if GetResourceState('ox_inventory') == "started" or GetResourceState('ox_inventory') == "starting" then
			RegisterNetEvent('minimap:openedInventory')
			AddEventHandler('minimap:openedInventory', function()
				DisplayRadar(false)

				SendNUIMessage({
					display = false,
				})
			end)

			RegisterNetEvent('minimap:closedInventory')
			AddEventHandler('minimap:closedInventory', function()
				if not CONFIG.DISPLAY_IN_CAR then
					if IsPedInAnyVehicle(PlayerPedId(), false) then
						DisplayRadar(true)

						SendNUIMessage({
							display = true,
							data = GetMinimapAnchor(),
						})
					end
				else
					DisplayRadar(true)

					SendNUIMessage({
						display = true,
						data = GetMinimapAnchor(),
					})
				end
			end)
		else
			print("Use ox inventory in order to hide minimap on opened inventory!")
		end
	end
end)

CreateThread(function()
	if CONFIG.HIDE_STATUS then
		local minimap = RequestScaleformMovie("minimap")
		while true do
			Wait(0)
			BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
			ScaleformMovieMethodAddParamInt(3)
			EndScaleformMovieMethod()
		end
	end
end)