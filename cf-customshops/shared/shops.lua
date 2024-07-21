ShopConf = {}

local ShopITEMS = itemConf.shopitems
ShopConf.Markets = {
        cfshopv1 = {
            PedSystem = false,  -- Ped system on - off (ONLY USE TARGET)
            PedAnimation = false, -- Ped system on then edit this
            JobName = { "police" }, -- Job access 
            Location = {
                PedCoords = vector4(-276.41, 2200.53, 129.82, 338.46), -- Ped Coords
                ShopCoords = vector4(-276.41, 2200.53, 129.82, 338.46), -- Shop Coords
                ModelName = "u_m_m_streetart_01", -- Ped Model
                ModelHash = 0x6C19E962 -- Ped Hash
            },
            Shops = {
                shopcf = {
                    label = "Mağaza", -- Shop Label
                    slots = 10, -- Slot Amount
                    items = ShopITEMS
                },
            },
            Target = {
                Label = "Open Market", -- Target Label
                Icon = "fas fa-store", -- fas fa icon
                Event = "cf-customshops:OpenShop" -- Event
            }
        },
        -- More Shops Add Here!
    }





