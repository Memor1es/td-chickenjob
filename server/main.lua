ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('td-chickenjob:itemver1')
AddEventHandler('td-chickenjob:itemver1', function(itemname)
	local player = ESX.GetPlayerFromId(source)
	local chicken = player.getInventoryItem('alive_chicken').count
	if chicken > 99 then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Daha fazlasını taşıyamazsın!'}) 
	else
		player.addInventoryItem(itemname, 1)
	end
end)

RegisterNetEvent("td-chickenjob:Tavukisleme")
AddEventHandler("td-chickenjob:Tavukisleme", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('alive_chicken').count > 0 then
                xPlayer.removeInventoryItem('alive_chicken', 1)
                xPlayer.addInventoryItem('slaughtered_chicken', 1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Tavuğu kestin!'})
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Üzerinde tavuk yok!'})
            end
        end
    end)

RegisterNetEvent("td-chickenjob:Tavukpaketleme")
AddEventHandler("td-chickenjob:Tavukpaketleme", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('slaughtered_chicken').count > 1 then
                xPlayer.removeInventoryItem('slaughtered_chicken', 2)
                xPlayer.addInventoryItem('packaged_chicken', 1)
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Tavukları paketledin!'})
            elseif xPlayer.getInventoryItem('slaughtered_chicken').count < 2 then
                TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Üzerinde kesilmiş tavuk yok!'})
            end
        end
    end)
	
RegisterServerEvent('td-chickenjob:Tavuksatma')
AddEventHandler('td-chickenjob:Tavuksatma', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local tavuk = 0
			
	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]
			
		if item.name == "packaged_chicken" then
			tavuk= item.count
		end
	end
				
	    if tavuk > 0 then
		  xPlayer.removeInventoryItem('packaged_chicken', 1)
			xPlayer.addMoney(90)
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Tavuk sattın.'})
		else 
			TriggerClientEvent('mythic_notify:client:SendAlert', xPlayer.source, { type = 'inform', text = 'Satacak bir tavuğun yok'})
	    end
end)
