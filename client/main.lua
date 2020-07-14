local PlayerData                = {}
ESX                             = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
    end
end) 

Citizen.CreateThread(function()
    if Config.NPCEnable == true then
        for i, v in pairs(Config.NPC) do
            RequestModel(v.npc)
            while not HasModelLoaded(v.npc) do
                Wait(1)
            end
            chickenped = CreatePed(1, v.npc, v.x, v.y, v.z, v.h, false, true)
            SetBlockingOfNonTemporaryEvents(chickenped, true)
            SetPedDiesWhenInjured(chickenped, false)
            SetPedCanPlayAmbientAnims(chickenped, true)
            SetPedCanRagdollFromPlayerImpact(chickenped, false)
            SetEntityInvincible(chickenped, true)
            FreezeEntityPosition(chickenped, true)
        end
    end
end)

function Animasyon() 
    RequestAnimDict("mp_common")
    while not HasAnimDictLoaded("mp_common")do 
        Citizen.Wait(0)
    end;b=CreateObject(GetHashKey('prop_weed_bottle'),0,0,0,true)
    AttachEntityToEntity(b,PlayerPedId(),
    GetPedBoneIndex(PlayerPedId(),57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    AttachEntityToEntity(p,l,GetPedBoneIndex(l,57005),0.13,0.02,0.0,-90.0,0,0,1,1,0,1,0,1)
    TaskPlayAnim(GetPlayerPed(-1),"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    TaskPlayAnim(l,"mp_common","givetake1_a",8.0,-8.0,-1,0,0,false,false,false)
    Wait(1550)
    DeleteEntity(b)
    ClearPedTasks(pid)
    ClearPedTasks(l)
end

function TavukToplamaAnim()
	local playerPed = GetPlayerPed(-1)
	ESX.Streaming.RequestAnimDict('random@domestic', function()
		TaskPlayAnim(playerPed, 'random@domestic', 'pickup_low', 8.0, -8, -1, 48, 0, 0, 0, 0)
	end)	
end

Citizen.CreateThread(function()
	while true do
		
		Citizen.Wait(0)
		
		local coords = GetEntityCoords(GetPlayerPed(-1))
		
		for k,v in pairs(Config.TavukTopla) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.5 then
			DrawText3D( v.x, v.y, v.z, "[E] Topla", 0.7)
			if IsControlJustPressed(1, 38) then
				TavukToplamaAnim()
				exports["aex-bar"]:taskBar(1500, "Tavuk Toplanıyor! ")
			TriggerServerEvent("arrival:itemver1", "alive_chicken")

			end
		   end
		end
	end
end)

function Tavukkesim()
    local elements = {
        {label = 'Tavukları Kes',   value = 'tavukisleme'},
        {label = 'Menüyü Kapat',   value = 'kapat'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tavukisleme', {
        title    = 'Kasap Saruhan',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'tavukisleme' then
           menu.close()
           Animasyon()
           exports['aex-bar']:taskBar(3000, "Tavukların kesiliyor!")
           Animasyon()
            TriggerServerEvent("td-chickenjob:Tavukisleme")
        elseif data.current.value == 'kapat' then
            menu.close()
        end
    end)
end

function Tavukpaket()
    local elements = {
        {label = 'Tavukları Paketle',   value = 'tavukpaketleme'},
        {label = 'Menüyü Kapat',   value = 'kapat'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tavukpaketleme', {
        title    = 'Kasap Remzi',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'tavukpaketleme' then
           menu.close()
           Animasyon()
           exports['aex-bar']:taskBar(3000, "Paketleri alıyorsun!")
           Animasyon()
            TriggerServerEvent("td-chickenjob:Tavukpaketleme")
        elseif data.current.value == 'kapat' then
            menu.close()
        end
    end)
end

function Tavuksatis()
    local elements = {
        {label = 'Tavukları Sat',   value = 'tavuksatis'},
        {label = 'Menüyü Kapat',   value = 'kapat'},

    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tavuksatis', {
        title    = 'Toptancı',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'tavuksatis' then
           menu.close()
           Animasyon()
           exports['aex-bar']:taskBar(3000, "Tavuklarını satıyorsun!")
           Animasyon()
            TriggerServerEvent("td-chickenjob:Tavuksatma")
        elseif data.current.value == 'kapat' then
            menu.close()
        end
    end)
end	

Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.islemeX, Config.islemeY, Config.islemeZ, true) < 2 then
                DrawText3D(Config.islemeX, Config.islemeY, 31.60, " [~g~E~w~] Kasap Saruhan")
                    if IsControlJustReleased(1, 51) then
                        Tavukkesim()                
            end
        end
    end
 end)

Citizen.CreateThread(function()
    while true do
	 local ped = PlayerPedId()
        Citizen.Wait(1)
            if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.PaketlemeX, Config.PaketlemeY, Config.PaketlemeZ, true) < 2 then
                DrawText3D(Config.PaketlemeX, Config.PaketlemeY, 31.90, " [~g~E~w~] Kasap Remzi")
                    if IsControlJustReleased(1, 51) then
                        Tavukpaket()                
            end
        end
    end
end)
 
 Citizen.CreateThread(function()
	
	for k,v in pairs(Config.TavukTopla) do
		
		local blip = AddBlipForCoord(v.x, v.y, v.z)

		SetBlipSprite (blip, 256)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.5)
		SetBlipColour (blip, 5)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Tavuk Fabrikası')
		EndTextCommandSetBlipName(blip)
	end

end)

 function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 0, 0, 0, 100)
end
