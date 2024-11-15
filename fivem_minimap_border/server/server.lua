CreateThread(function()
    if not CONFIG.DISPLAY_ON_OXINVENTORY then
        if GetResourceState('ox_inventory') == "started" or GetResourceState('ox_inventory') == "starting" then
            AddEventHandler('ox_inventory:openedInventory', function(playerId, inventoryId) 
                TriggerClientEvent("minimap:openedInventory", playerId)
            end)

            AddEventHandler('ox_inventory:closedInventory', function(playerId, inventoryId) 
                TriggerClientEvent("minimap:closedInventory", playerId)
            end)
        end
    end
end)