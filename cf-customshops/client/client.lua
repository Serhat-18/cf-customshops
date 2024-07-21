local QBCore = exports['qb-core']:GetCoreObject()
local MarketPeds = {}
local markerShop = {}

local function RemoveMarketPeds()
    for _, ped in pairs(MarketPeds) do
        if DoesEntityExist(ped) then
            DeletePed(ped)
        end
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        RemoveMarketPeds()
    end
end)

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

CreateThread(function()
    for marketName, marketData in pairs(ShopConf.Markets) do
        local pedCoords = marketData.Location.PedCoords
        local shopCoords = marketData.Location.ShopCoords
        local PedModel = marketData.Location.ModelName

        if marketData.PedSystem then
            RequestModel(GetHashKey(PedModel))
            while not HasModelLoaded(GetHashKey(PedModel)) do
                Wait(1)
            end
            local ped = CreatePed(1, GetHashKey(PedModel), pedCoords.x, pedCoords.y, pedCoords.z, false, true)
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)

            if marketData.PedAnimation then
                loadAnimDict("timetable@ron@ig_3_couch")
                TaskPlayAnim(ped, "timetable@ron@ig_3_couch", "base", 8.0, 1.0, -1, 1, 0, false, false, false)
            end

            exports['qb-target']:AddTargetEntity(ped, {
                options = {
                    {
                        num = 1,
                        type = "client",
                        event = marketData.Target.Event,
                        label = marketData.Target.Label,
                        icon = marketData.Target.Icon,
                        market = marketName
                    }
                },
                distance = 1.5
            })

            MarketPeds[marketName] = ped
        else
            if Config.OpenEventType == "marker" then
                table.insert(markerShop, {coords = shopCoords, market = marketName})
            elseif Config.OpenEventType == "qb-target" then
                exports['qb-target']:AddBoxZone('stash_' .. marketName, shopCoords, 3, 3, {
                    name = 'stash_' .. marketName,
                    heading = 0,
                    debugPoly = false,
                    minZ = shopCoords.z - 3,
                    maxZ = shopCoords.z + 2
                }, {
                    options = {
                        {
                            label = marketData.Target.Label,
                            icon = marketData.Target.Icon,
                            action = function()
                                TriggerEvent('cf-customshops:OpenShop', {market = marketName})
                            end
                        }
                    },
                    distance = 2.0
                })
            end
        end
    end
end)

if Config.OpenEventType == "marker" then
    CreateThread(function()
        while true do
            local sleep = 1000
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)

            for _, v in pairs(markerShop) do
                local dist = GetDistanceBetweenCoords(pedCoords, v.coords, true)

                if dist < Config.MarkerDist then
                    sleep = 0
                    DrawMarker(21, v.coords.x, v.coords.y, v.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 136, 255, 100, false, true, 2, true, nil, nil, false)
                    if dist < 1.5 then
                        QBCore.Functions.DrawText3D(v.coords.x, v.coords.y, v.coords.z, Config.LocaleConfig.Locales.MarkerText)
                        if IsControlJustPressed(0, Config.MarkerKey) then
                            TriggerEvent('cf-customshops:OpenShop', {market = v.market})
                        end
                    end
                end
            end
            Wait(sleep)
        end
    end)
end

function hasAccess(jobName, jobList)
    for _, job in pairs(jobList) do
        if jobName == job then
            return true
        end
    end
    return false
end

RegisterNetEvent('cf-customshops:OpenShop', function(data)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local marketName = data.market
    local marketData = ShopConf.Markets[marketName]

    if hasAccess(PlayerData.job.name, marketData.JobName) then
        TriggerServerEvent("inventory:server:OpenInventory", "shop", marketData.Shops.shopcf, marketData.ShopLabel)
    else
        QBCore.Functions.Notify(Config.LocaleConfig.Locales.DontThis, "error")
    end
end)
