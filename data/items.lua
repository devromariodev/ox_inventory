return {
    ['paper_map'] = {
        label = 'Map',
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 200,
        stack = false,
        close = true,
        consume = 0, -- required: frp_map keeps the item, using it just opens the atlas
        description = 'A folded paper map of the region. Whatever you have charted is inked in; the rest is blank.',
        client = {
            export = 'frp_map.useMap',
        },
        -- frp_racing's route picker. The item belongs to frp_map; racing only adds
        -- this button and its own frp*-prefixed metadata keys.
        buttons = {
            {
                label = 'Racing routes',
                action = function(slot)
                    if GetResourceState('frp_racing') ~= 'started' then return end
                    exports.frp_racing:openRoutes(slot)
                end,
            },
        },
    },

    ['map_board'] = {
        label = 'Community Board',
        rarity = 'uncommon',
        grid = { 2, 2 },
        weight = 3500,
        stack = true,
        close = true,
        consume = 0, -- required: frp_map takes the item itself, only once placement succeeds
        description = 'A cork noticeboard and a bag of pins. Put it up somewhere and anyone can pin notes to it.',
        client = {
            export = 'frp_map.useBoardItem',
        },
    },

    ['racing_tablet'] = {
        label = 'Racing Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 500,
        stack = false,
        close = true,
        consume = 0,
        description = 'Street racing tablet — events, tracks and rankings.',
        server = {
            export = 'sd-racing.useRacing_tablet',
        },
    },

    ['sim_card'] = {
        grid = { 1, 1 },
        label = 'SIM Card',
        rarity = 'uncommon',
        weight = 5,
        stack = false,
        close = true,
        consume = 0, -- required: sd-phone consumes the item itself on install
        server = { export = 'sd-phone.useSim_card' },
    },


    ['bandage'] = {
        grid = { 1, 1 },
        label = 'Bandagem',
        rarity = 'common',
        weight = 115,
    },

    ['burger'] = {
        grid = { 1, 1 },
        label = 'Hambúrguer',
        rarity = 'common',
        weight = 220,
        client = {
            status = { hunger = 200000 },
            anim = 'eating',
            prop = 'burger',
            usetime = 2500,
            notification = 'You ate a delicious burger'
        },
    },

    ["megaphone"] = {
        label = "Megaphone",
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 500,
        stack = false,
        close = true,
        description = "A usable megaphone"
    },

    
    
    
    
    

    ['screwdriver'] = {
        grid = { 2, 1 },
    label = 'Screwdriver',
    rarity = 'common',
    weight = 300,
    stack = true,
    close = true,
    description = 'A flathead screwdriver for prying coin boxes and unbolting fixtures.',
},
['wirecutter'] = {
    grid = { 2, 1 },
    label = 'Wire Cutters',
    rarity = 'common',
    weight = 600,
    stack = true,
    close = true,
    description = 'Sharp wire cutters that slice through brake lines and wiring.',
},
['cutter'] = {
    grid = { 2, 1 },
    label = 'Box Cutter',
    rarity = 'common',
    weight = 200,
    stack = true,
    close = true,
    description = 'A retractable box cutter - sharp enough to slash tyres and puncture tanks.',
},
['multitool'] = {
    grid = { 2, 1 },
    label = 'Multitool',
    rarity = 'uncommon',
    weight = 400,
    stack = true,
    close = true,
    description = 'A folding multitool that handles meters, news racks, and signs.',
},
['powersaw'] = {
    label = 'Power Saw',
    rarity = 'uncommon',
    grid = { 2, 2 },
    weight = 4000,
    stack = true,
    close = true,
    description = 'A cordless reciprocating saw for cutting through metal.',
},
['anglegrinder'] = {
    label = 'Angle Grinder',
    rarity = 'uncommon',
    grid = { 2, 2 },
    weight = 3500,
    stack = true,
    close = true,
    description = 'A battery angle grinder that chews through converters and AC units.',
},
['bolt_cutter'] = {
    label = 'Bolt Cutters',
    rarity = 'uncommon',
    grid = { 2, 1 },
    weight = 2500,
    stack = true,
    close = true,
    description = 'Long-handled bolt cutters for chains, bolts, and converter mounts.',
},
['oxycutter'] = {
    label = 'Oxy Cutter',
    rarity = 'rare',
    grid = { 2, 2 },
    weight = 4000,
    stack = true,
    close = true,
    description = 'An oxy-acetylene cutting torch that slices through catalytic converters and AC units in seconds.',
},
['porch_package'] = {
    label = 'Porch Package',
    rarity = 'uncommon',
    grid = { 2, 2 },
    weight = 1000,
    stack = false,
    close = true,
    consume = 0,
    description = 'A swiped porch delivery. Use it to open it up and see what was inside.',
    server = { export = 'sd-pettycrime.usePorch_package' },
},
['mail_package'] = {
    label = 'Mail Bundle',
    rarity = 'common',
    grid = { 2, 1 },
    weight = 300,
    stack = false,
    close = true,
    consume = 0,
    description = 'A bundle of stolen mail. Use it to open it up and see what was inside.',
    server = { export = 'sd-pettycrime.useMail_package' },
},
['skimmer'] = {
    grid = { 2, 1 },
    label = 'Card Skimmer',
    rarity = 'rare',
    weight = 250,
    stack = true,
    close = true,
    description = 'Install on an ATM, then slot in a USB to record card data. Wears out the longer it runs.',
},
['atm_skimmer_usb'] = {
    grid = { 2, 1 },
    label = 'Card Data USB',
    rarity = 'uncommon',
    weight = 50,
    stack = true,
    close = true,
    description = 'A USB stick for an ATM card skimmer. Stores stolen card data when slotted into an installed skimmer.',
},
['speed_bomb'] = {
    label = 'Speedbomb',
    rarity = 'epic',
    grid = { 2, 1 },
    weight = 1500,
    stack = true,
    close = true,
    description = 'Wire it under a parked vehicle. Arms when driven fast and blows if the speed drops.',
},
['catalytic_converter'] = {
    label = 'Catalytic Converter',
    rarity = 'rare',
    grid = { 2, 2 },
    weight = 2500,
    stack = true,
    close = true,
    description = 'A sawn-off catalytic converter, packed with precious metals and worth a fortune to the right buyer.',
},
    
    
    
    

    ['sprunk'] = {
        grid = { 1, 1 },
        label = 'Sprunk',
        rarity = 'common',
        weight = 350,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
            usetime = 2500,
            notification = 'You quenched your thirst with a sprunk'
        }
    },

    ['parachute'] = {
        label = 'Parachute',
        rarity = 'rare',
        grid = { 2, 2 },
        clothing = 'backpack',
        weight = 8000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 1500
        }
    },

    ['garbage'] = {
        grid = { 2, 1 },
        label = 'Garbage',
        rarity = 'common',
    },

    ["bands"] = {
        grid = { 1, 1 },
        label = "Band Of Notes",
        rarity = 'uncommon',
        weight = 100,
        stack = true,
        close = false,
        description = "A band of small notes..",
        consume = 0,
        client = {
            image = "bands.png",
        }
    },
    

    ["fleeca_case"] = {
        label = "Fleeca Bank Case",
        rarity = 'epic',
        grid = { 2, 2 },
        weight = 2000,
        stack = true,
        close = true,
        description = "A mysterious case from a Fleeca Bank heist. Contains random loot.",
        consume = 0,
        client = {
            image = "case_1.png",
        },
        server = {
            export = 'sd-cases.useFleeca_case',
        }
    },
    
    ["house_case"] = {
        label = "House Robbery Case",
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 2000,
        stack = true,
        close = true,
        description = "A case filled with items from house burglaries. Contents unknown.",
        consume = 0,
        client = {
            image = "case_2.png",
        },
        server = {
            export = 'sd-cases.useHouse_case',
        }
    },
    
    ["chopshop_case"] = {
        label = "Chop Shop Case",
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 2500,
        stack = true,
        close = true,
        description = "A case containing random car parts from the chop shop.",
        consume = 0,
        client = {
            image = "case_3.png",
        },
        server = {
            export = 'sd-cases.useChopshop_case',
        }
    },
    
    ["jewelry_case"] = {
        label = "Jewelry Store Case",
        rarity = 'epic',
        grid = { 2, 2 },
        weight = 1500,
        stack = true,
        close = true,
        description = "A luxury case from Vangelico's. May contain valuable jewelry.",
        consume = 0,
        client = {
            image = "case_4.png",
        },
        server = {
            export = 'sd-cases.useJewelry_case',
        }
    },
    
    ["pacific_case"] = {
        label = "Pacific Bank Case",
        rarity = 'legendary',
        grid = { 2, 2 },
        weight = 3000,
        stack = true,
        close = true,
        description = "A high-security case from the Pacific Standard vault. Extremely valuable.",
        consume = 0,
        client = {
            image = "case_5.png",
        },
        server = {
            export = 'sd-cases.usePacific_case',
        }
    },
    
    ["casino_case"] = {
        label = "Casino Heist Case",
        rarity = 'legendary',
        grid = { 2, 2 },
        weight = 2500,
        stack = true,
        close = true,
        description = "A case stolen from the Diamond Casino vault. Contains premium loot.",
        consume = 0,
        client = {
            image = "case_6.png",
        },
        server = {
            export = 'sd-cases.useCasino_case',
        }
    },
    
    ["package"] = {
        label = "Suspicious Package",
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 10000,
        stack = false,
        close = false,
        description = "A mysterious package.. Scary!",
        consume = 0,
        client = {
            image = "package.png",
        }
    },

    
    
    
    
    
    -- Deer Carcass Items (3 tiers)
    ['carcass_1'] = {
        label = 'Poor Deer Carcass',
        rarity = 'common',
        grid = { 2, 2 },
        weight = 2000,
        stack = true,
        close = true,
        description = 'Low quality deer carcass - damaged during hunt',
        client = {
            image = 'carcass_1.png',
        }
    },
    
    ['carcass_2'] = {
        label = 'Good Deer Carcass',
        rarity = 'uncommon',
        grid = { 2, 2 },
        weight = 2500,
        stack = true,
        close = true,
        description = 'Good quality deer carcass - cleanly hunted',
        client = {
            image = 'carcass_2.png',
        }
    },
    
    ['carcass_3'] = {
        label = 'Perfect Deer Carcass',
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 3000,
        stack = true,
        close = true,
        description = 'Pristine deer carcass - expertly hunted',
        client = {
            image = 'carcass_3.png',
        }
    },
    
    -- Mountain Lion Carcass Items (3 tiers)
    ['redcarcass_1'] = {
        label = 'Poor Mountain Lion Carcass',
        rarity = 'uncommon',
        grid = { 2, 2 },
        weight = 3000,
        stack = true,
        close = true,
        description = 'Low quality mountain lion carcass - damaged pelt',
        client = {
            image = 'redcarcass_1.png',
        }
    },
    
    ['redcarcass_2'] = {
        label = 'Good Mountain Lion Carcass',
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 3500,
        stack = true,
        close = true,
        description = 'Good quality mountain lion carcass - valuable game',
        client = {
            image = 'redcarcass_2.png',
        }
    },
    
    ['redcarcass_3'] = {
        label = 'Perfect Mountain Lion Carcass',
        rarity = 'epic',
        grid = { 2, 2 },
        weight = 4000,
        stack = true,
        close = true,
        description = 'Pristine mountain lion carcass - trophy quality',
        client = {
            image = 'redcarcass_3.png',
        }
    },
    
    -- Single tier items (no quality variations)
    ['deerhide'] = {
        label = 'Deer Hide',
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 800,
        stack = true,
        close = true,
        description = 'Quality deer hide suitable for leather crafting',
        client = {
            image = 'deerhide.png',
        }
    },
    
    ['antlers'] = {
        label = 'Deer Antlers',
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 600,
        stack = true,
        close = true,
        description = 'Pristine deer antlers - valuable trophy item',
        client = {
            image = 'antlers.png',
        }
    },
    
    ['mtlionpelt'] = {
        label = 'Mountain Lion Pelt',
        rarity = 'rare',
        grid = { 2, 1 },
        weight = 1200,
        stack = true,
        close = true,
        description = 'Rare mountain lion pelt - highly valued by traders',
        client = {
            image = 'mtlionpelt.png',
        }
    },
    
    
    ['coyotepelt'] = {
        label = 'Coyote Pelt',
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 600,
        stack = true,
        close = true,
        description = 'Warm coyote fur pelt - good for crafting',
        client = {
            image = 'coyotepelt.png',
        }
    },
    
    ['boarmeat'] = {
        label = 'Wild Boar Meat',
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 1800,
        stack = true,
        close = true,
        description = 'Fresh wild boar meat - a hearty game meat',
        client = {
            image = 'boarmeat.png',
        }
    },
    


    ['panties'] = {
        grid = { 2, 1 },
        label = 'Knickers',
        rarity = 'common',
        weight = 10,
        consume = 0,
        client = {
            status = { thirst = -100000, stress = -25000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
            usetime = 2500,
        }
    },

    ['lockpick'] = {
        grid = { 1, 1 },
        label = 'Chave Micha',
        rarity = 'common',
        weight = 160,
    },

    -- Celulares (ADR-0014 do newcity): os 9 aparelhos abrem o MESMO telefone
    -- (nc_phone); a cor e so a cara da moldura, nunca funcao. Antes apontavam para
    -- o sd-phone do scaffold da demo, que nao existe no servidor — nenhum fazia nada.
    ['phone'] = {
        label = 'Celular',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 190,
        stack = false,
        consume = 0, -- nunca consome no uso: abre o telefone
        server = {
            export = 'nc_phone.usePhone'
        }
    },

    ['phone_black'] = {
        label = 'Celular Preto',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 190,
        stack = false,
        consume = 0,
        server = { export = 'nc_phone.usePhone' }
    },

    ['phone_blue'] = {
        label = 'Celular Azul',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 190,
        stack = false,
        consume = 0,
        server = { export = 'nc_phone.usePhone' }
    },

    ['phone_green'] = {
        label = 'Celular Verde',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 190,
        stack = false,
        consume = 0,
        server = { export = 'nc_phone.usePhone' }
    },

    ['phone_orange'] = {
        label = 'Celular Laranja',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 190,
        stack = false,
        consume = 0,
        server = { export = 'nc_phone.usePhone' }
    },

    ['phone_pink'] = {
        label = 'Celular Rosa',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 190,
        stack = false,
        consume = 0,
        server = { export = 'nc_phone.usePhone' }
    },

    ['phone_purple'] = {
        label = 'Celular Roxo',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 190,
        stack = false,
        consume = 0,
        server = { export = 'nc_phone.usePhone' }
    },

    ['phone_red'] = {
        label = 'Celular Vermelho',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 190,
        stack = false,
        consume = 0,
        server = { export = 'nc_phone.usePhone' }
    },

    ['phone_yellow'] = {
        label = 'Celular Amarelo',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 190,
        stack = false,
        consume = 0,
        server = { export = 'nc_phone.usePhone' }
    },

    ['tablet'] = {
        label       = 'Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight      = 700,
        stack       = false,
        close       = true,
        consume     = 0,
        description = 'A tablet. Everything your phone does, except calls.',
        client      = { image = 'tablet_black.png' },
        server      = { export = 'sd-tablet.useTablet' },
    },

    ['tablet_black'] = {
        label       = 'Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight      = 700,
        stack       = false,
        close       = true,
        consume     = 0,
        description = 'A tablet. Everything your phone does, except calls.',
        client      = { image = 'tablet_black.png' },
        server      = { export = 'sd-tablet.useTablet_black' },
    },

    ['tablet_blue'] = {
        label       = 'Blue Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight      = 700,
        stack       = false,
        close       = true,
        consume     = 0,
        description = 'A tablet. Everything your phone does, except calls.',
        client      = { image = 'tablet_blue.png' },
        server      = { export = 'sd-tablet.useTablet_blue' },
    },

    ['tablet_green'] = {
        label       = 'Green Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight      = 700,
        stack       = false,
        close       = true,
        consume     = 0,
        description = 'A tablet. Everything your phone does, except calls.',
        client      = { image = 'tablet_green.png' },
        server      = { export = 'sd-tablet.useTablet_green' },
    },

    ['tablet_orange'] = {
        label       = 'Orange Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight      = 700,
        stack       = false,
        close       = true,
        consume     = 0,
        description = 'A tablet. Everything your phone does, except calls.',
        client      = { image = 'tablet_orange.png' },
        server      = { export = 'sd-tablet.useTablet_orange' },
    },

    ['tablet_pink'] = {
        label       = 'Pink Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight      = 700,
        stack       = false,
        close       = true,
        consume     = 0,
        description = 'A tablet. Everything your phone does, except calls.',
        client      = { image = 'tablet_pink.png' },
        server      = { export = 'sd-tablet.useTablet_pink' },
    },

    ['tablet_purple'] = {
        label       = 'Purple Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight      = 700,
        stack       = false,
        close       = true,
        consume     = 0,
        description = 'A tablet. Everything your phone does, except calls.',
        client      = { image = 'tablet_purple.png' },
        server      = { export = 'sd-tablet.useTablet_purple' },
    },

    ['tablet_red'] = {
        label       = 'Red Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight      = 700,
        stack       = false,
        close       = true,
        consume     = 0,
        description = 'A tablet. Everything your phone does, except calls.',
        client      = { image = 'tablet_red.png' },
        server      = { export = 'sd-tablet.useTablet_red' },
    },

    ['tablet_yellow'] = {
        label       = 'Yellow Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight      = 700,
        stack       = false,
        close       = true,
        consume     = 0,
        description = 'A tablet. Everything your phone does, except calls.',
        client      = { image = 'tablet_yellow.png' },
        server      = { export = 'sd-tablet.useTablet_yellow' },
    },

    ['phone_powerbank'] = {
        grid = { 2, 1 },
        label = 'Power Bank',
        rarity = 'uncommon',
        weight = 250,
        stack = false,
        close = true,
        consume = 0,
        server = { export = 'sd-phone.usePhone_powerbank' },
    },

    -- Using it latches charging on, using it again latches it off.
    ['phone_cable'] = {
        grid = { 1, 1 },
        label = 'Charging Cable',
        rarity = 'common',
        weight = 80,
        stack = false,
        close = true,
        consume = 0,
        server = { export = 'sd-phone.usePhone_cable' },
    },


    ['water'] = {
        grid = { 1, 1 },
        label = 'Água',
        rarity = 'common',
        weight = 500,
        client = {
            status = { thirst = 200000 },
            anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
            prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
            usetime = 2500,
            cancel = true,
            notification = 'You drank some refreshing water'
        }
    },

    -- NewCity (#88): o colete e ITEM DE VERDADE, nao aparencia (decisao do dono
    -- 2026-08-27). Era `clothing = 'armour'`, e o handler de clothing do fork so
    -- troca componente do ped — nao dava protecao nenhuma. Agora e usavel, e o
    -- efeito vem do nc_survival (dono da vida/colete, ARQ-18) via o Item() em
    -- modules/items/client.lua.
    ['armour'] = {
        label = 'Colete Balístico',
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 3000,
        stack = false,
        client = {
            anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
            usetime = 3500
        }
    },


    ['money'] = {
        grid = { 1, 1 },
        label = 'Dinheiro',
        rarity = 'common',
    },

    ['black_money'] = {
        grid = { 1, 1 },
        label = 'Dirty Money',
        rarity = 'common',
    },

    ['id_card'] = {
        grid = { 1, 1 },
        label = 'Identidade',
        rarity = 'common',
    },

    ["metaldetector_1"] = {
        label = "Basic Metal Detector",
        rarity = 'common',
        grid = { 2, 2 },
        weight = 2500,
        stack = false,
        close = true,
        consume = 0,
        description = "Entry-level detector with 5m range and 60% accuracy. Use to start detecting metals.",
        client = {
            image = "metaldetector_1.png",
        },
        server = {
            export = 'sd-civjobs.useMetalDetector'
        }
    },
    
    ["metaldetector_2"] = {
        label = "Amateur Metal Detector",
        rarity = 'uncommon',
        grid = { 2, 2 },
        weight = 2300,
        stack = false,
        close = true,
        consume = 0,
        description = "Improved detector with 7m range and 70% accuracy. Use to start detecting metals.",
        client = {
            image = "metaldetector_2.png",
        },
        server = {
            export = 'sd-civjobs.useMetalDetector'
        }
    },
    
    ["metaldetector_3"] = {
        label = "Professional Metal Detector",
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 2100,
        stack = false,
        close = true,
        consume = 0,
        description = "Professional-grade detector with 9m range and 80% accuracy. Use to start detecting metals.",
        client = {
            image = "metaldetector_3.png",
        },
        server = {
            export = 'sd-civjobs.useMetalDetector'
        }
    },
    
    ["metaldetector_4"] = {
        label = "Advanced Metal Detector",
        rarity = 'epic',
        grid = { 2, 2 },
        weight = 2000,
        stack = false,
        close = true,
        consume = 0,
        description = "Advanced detector with 11m range and 90% accuracy. Use to start detecting metals.",
        client = {
            image = "metaldetector_4.png",
        },
        server = {
            export = 'sd-civjobs.useMetalDetector'
        }
    },
    
    ["metaldetector_5"] = {
        label = "Elite Metal Detector",
        rarity = 'legendary',
        grid = { 2, 2 },
        weight = 1800,
        stack = false,
        close = true,
        consume = 0,
        description = "Top-tier detector with 13m range and 95% accuracy. Use to start detecting metals.",
        client = {
            image = "metaldetector_5.png",
        },
        server = {
            export = 'sd-civjobs.useMetalDetector'
        }
    },

    ["detecting_shovel"] = {
        label = "Shovel",
        rarity = 'common',
        grid = { 1, 3 },
        weight = 1500,
        stack = false,
        close = true,
        consume = 0,
        description = "High-quality shovel for metal detecting excavations.",
        client = {
            image = "detecting_shovel.png",
        }
    },














































    ['driver_license'] = {
        grid = { 1, 1 },
        label = 'Carteira de Motorista',
        rarity = 'common',
    },

    ['weaponlicense'] = {
        grid = { 1, 1 },
        label = 'Porte de Arma',
        rarity = 'uncommon',
    },

    ['lawyerpass'] = {
        grid = { 2, 1 },
        label = 'Lawyer Pass',
        rarity = 'uncommon',
    },


        
    -- Bee Honey (Basic)
    
    -- Chiliad Honey
    
    -- Green Hills Honey
    
    -- Alamo Honey
    
    -- Bee Wax
        
        
    
    

    
    
    ["secured_safe"] = {
        label = "Safe",
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 200,
        stack = false,
        close = true,
        description = "Meant to protect valuables",
        consume = 0,
        client = {
            image = "secured_safe.png",
        },
    },
    
    ["expensive_champagne"] = {
        client = { status = { thirst = 200000 }, anim = 'drinking', prop = 'champagne', usetime = 2500, cancel = true },
        label = 'Champanhe',
        rarity = 'rare',
        grid = { 1, 2 },
        weight = 200,
        stack = true,
        close = true,
        description = "A sparkling wine from France",
        consume = 0,
        client = {
            image = "expensive_champagne.png",
        },
    },
    
    ["default_gateway_override"] = {
        grid = { 2, 1 },
        label = "Gateway Override",
        rarity = 'rare',
        weight = 200,
        stack = false,
        close = true,
        description = "A default gateway override on a usb",
        consume = 0,
        client = {
            image = "default_gateway_override.png",
        },
    },

    ['prescription'] = {
        grid = { 2, 1 },
		label = 'Prescription',
		rarity = 'common',
		weight = 300,
		stack = false,
		close = true,
		description = "A piece of paper used for pharmacies"
	},
	['prescriptionpad'] = {
	    grid = { 2, 1 },
		label = 'Prescription Pad',
		rarity = 'uncommon',
		weight = 300,
		stack = false,
		close = true,
		description = "A prescription pad used by doctors to write prescriptions"
	},
    
    ["revivekit"] = {
        label = "Revival Kit",
        rarity = 'epic',
        grid = { 2, 2 },
        weight = 3000,
        stack = false,
        close = false,
        description = "When your pal needs that pick me up",
        consume = 0,
        client = {
            image = "revivekit.png",
        },
        server = {
            export = 'sd-yacht.useRevivekit',
        }
    },
    

    ['radio'] = {
        label = 'Rádio',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 1000,
        allowArmed = true,
        consume = 0,
        client = {
            event = 'mm_radio:client:use'
        }
    },

    ['jammer'] = {
        label = 'Radio Jammer',
        rarity = 'epic',
        grid = { 2, 2 },
        weight = 10000,
        allowArmed = true,
        client = {
            event = 'mm_radio:client:usejammer'
        }
    },


    ['advancedlockpick'] = {
        grid = { 2, 1 },
        label = 'Advanced Lockpick',
        rarity = 'uncommon',
        weight = 500,
    },

    ['screwdriverset'] = {
        grid = { 2, 2 },
        label = 'Screwdriver Set',
        rarity = 'common',
        weight = 500,
    },


    ['cleaningkit'] = {
        grid = { 1, 1 },
        label = 'Kit de Limpeza',
        rarity = 'common',
        weight = 500,
    },

    ['repairkit'] = {
        label = 'Kit de Reparo',
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 2500,
    },

    ['advancedrepairkit'] = {
        label = 'Advanced Repair Kit',
        rarity = 'rare',
        grid = { 2, 1 },
        weight = 4000,
    },

    ['diamond_ring'] = {
        grid = { 1, 1 },
        label = 'Diamond',
        rarity = 'epic',
        weight = 1500,
    },

    ['rolex'] = {
        grid = { 1, 1 },
        label = 'Golden Watch',
        rarity = 'rare',
        weight = 1500,
    },

    ['goldbar'] = {
        label = 'Gold Bar',
        rarity = 'legendary',
        grid = { 2, 1 },
        weight = 1500,
    },

    ['goldchain'] = {
        grid = { 1, 1 },
        label = 'Golden Chain',
        rarity = 'rare',
        weight = 1500,
    },

    ['crack_baggy'] = {
        grid = { 2, 1 },
        label = 'Crack Baggy',
        rarity = 'uncommon',
        weight = 100,
    },

    ['cokebaggy'] = {
        grid = { 2, 1 },
        label = 'Bag of Coke',
        rarity = 'uncommon',
        weight = 100,
    },

    ['coke_brick'] = {
        label = 'Coke Brick',
        rarity = 'rare',
        grid = { 2, 1 },
        weight = 2000,
    },

    ['coke_small_brick'] = {
        grid = { 2, 1 },
        label = 'Coke Package',
        rarity = 'uncommon',
        weight = 1000,
    },

    ['xtcbaggy'] = {
        grid = { 2, 1 },
        label = 'Bag of Ecstasy',
        rarity = 'uncommon',
        weight = 100,
    },

    ['meth'] = {
        grid = { 2, 1 },
        label = 'Methamphetamine',
        rarity = 'uncommon',
        weight = 100,
    },

    ['oxy'] = {
        grid = { 1, 1 },
        label = 'Oxycodone',
        rarity = 'uncommon',
        weight = 100,
    },

    ['weed_ak47'] = {
        grid = { 2, 1 },
        label = 'AK47 2g',
        rarity = 'common',
        weight = 200,
    },

    ['weed_ak47_seed'] = {
        grid = { 1, 1 },
        label = 'AK47 Seed',
        rarity = 'common',
        weight = 1,
    },

    ['weed_skunk'] = {
        grid = { 2, 1 },
        label = 'Skunk 2g',
        rarity = 'common',
        weight = 200,
    },

    ['weed_skunk_seed'] = {
        grid = { 1, 1 },
        label = 'Skunk Seed',
        rarity = 'common',
        weight = 1,
    },

    ['weed_amnesia'] = {
        grid = { 2, 1 },
        label = 'Amnesia 2g',
        rarity = 'common',
        weight = 200,
    },

    ['weed_amnesia_seed'] = {
        grid = { 1, 1 },
        label = 'Amnesia Seed',
        rarity = 'common',
        weight = 1,
    },

    ['weed_og-kush'] = {
        grid = { 2, 1 },
        label = 'OGKush 2g',
        rarity = 'common',
        weight = 200,
    },

    ['weed_og-kush_seed'] = {
        grid = { 1, 1 },
        label = 'OGKush Seed',
        rarity = 'common',
        weight = 1,
    },

    ['weed_white-widow'] = {
        grid = { 2, 1 },
        label = 'OGKush 2g',
        rarity = 'common',
        weight = 200,
    },

    ['weed_white-widow_seed'] = {
        grid = { 1, 1 },
        label = 'White Widow Seed',
        rarity = 'common',
        weight = 1,
    },

    ['weed_purple-haze'] = {
        grid = { 2, 1 },
        label = 'Purple Haze 2g',
        rarity = 'common',
        weight = 200,
    },

    ['weed_purple-haze_seed'] = {
        grid = { 1, 1 },
        label = 'Purple Haze Seed',
        rarity = 'common',
        weight = 1,
    },

    ['weed_brick'] = {
        label = 'Weed Brick',
        rarity = 'rare',
        grid = { 2, 1 },
        weight = 2000,
    },

    ["wood"] = {
        label = "Wood",
        rarity = 'common',
        grid = { 2, 1 },
        weight = 500,
        stack = true,
        close = false,
        consume = 0,
        description = "A piece of raw wood that can be processed into planks.",
        client = {
            image = "wood.png",
        }
    },
    
    ["powersaw"] = {
        label = "Power Saw",
        rarity = 'uncommon',
        grid = { 2, 2 },
        weight = 2000,
        stack = false,
        close = false,
        consume = 0,
        description = "A powerful electric saw used for cutting trees and logs.",
        client = {
            image = "powersaw.png",
        }
    },

    ['wood_planks'] = {
        label = 'Wood Planks',
        rarity = 'common',
        grid = { 2, 1 },
        weight = 90,
        stack = true,
        close = false,
        consume = 0,
        description = 'Several short, rough-cut wooden planks. Useful for repairs or crafting.',
        client = {
            image = "wood_planks.png",
        }
    },

    ['weed_nutrition'] = {
        grid = { 2, 1 },
        label = 'Plant Fertilizer',
        rarity = 'common',
        weight = 2000,
    },

    ['joint'] = {
        grid = { 1, 1 },
        label = 'Joint',
        rarity = 'common',
        weight = 200,
    },

    ['rolling_paper'] = {
        grid = { 1, 1 },
        label = 'Rolling Paper',
        rarity = 'common',
        weight = 0,
    },

    ['empty_weed_bag'] = {
        grid = { 2, 1 },
        label = 'Empty Weed Bag',
        rarity = 'common',
        weight = 0,
    },

    ['firstaid'] = {
        label = 'Kit de Primeiros Socorros',
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 2500,
    },

    ['ifaks'] = {
        grid = { 1, 1 },
        label = 'Kit Médico Avançado',
        rarity = 'uncommon',
        weight = 2500,
    },

    ['painkillers'] = {
        grid = { 1, 1 },
        label = 'Painkillers',
        rarity = 'common',
        weight = 400,
    },

    ['firework1'] = {
        grid = { 2, 1 },
        label = '2Brothers',
        rarity = 'uncommon',
        weight = 1000,
    },

    ['firework2'] = {
        grid = { 2, 1 },
        label = 'Poppelers',
        rarity = 'uncommon',
        weight = 1000,
    },

    ['firework3'] = {
        grid = { 2, 1 },
        label = 'WipeOut',
        rarity = 'uncommon',
        weight = 1000,
    },

    ['firework4'] = {
        grid = { 2, 1 },
        label = 'Weeping Willow',
        rarity = 'uncommon',
        weight = 1000,
    },

    ['steel'] = {
        grid = { 1, 1 },
        label = 'Steel',
        rarity = 'common',
        weight = 100,
    },

    ['rubber'] = {
        grid = { 1, 1 },
        label = 'Rubber',
        rarity = 'common',
        weight = 100,
    },

    ['metalscrap'] = {
        grid = { 1, 1 },
        label = 'Metal Scrap',
        rarity = 'common',
        weight = 100,
    },

    ['iron'] = {
        grid = { 1, 1 },
        label = 'Iron',
        rarity = 'common',
        weight = 100,
    },

    ['copper'] = {
        grid = { 1, 1 },
        label = 'Copper',
        rarity = 'common',
        weight = 100,
    },

    ['aluminium'] = {
        grid = { 1, 1 },
        label = 'Aluminium',
        rarity = 'common',
        weight = 100,
    },

    ['plastic'] = {
        grid = { 1, 1 },
        label = 'Plastic',
        rarity = 'common',
        weight = 100,
    },

    ['glass'] = {
        grid = { 1, 1 },
        label = 'Glass',
        rarity = 'common',
        weight = 100,
    },

    ['gatecrack'] = {
        grid = { 2, 1 },
        label = 'Gatecrack',
        rarity = 'rare',
        weight = 1000,
    },

    ['cryptostick'] = {
        grid = { 2, 1 },
        label = 'Crypto Stick',
        rarity = 'rare',
        weight = 100,
    },

    ['trojan_usb'] = {
        grid = { 2, 1 },
        label = 'Trojan USB',
        rarity = 'rare',
        weight = 100,
    },

    ['toaster'] = {
        label = 'Toaster',
        rarity = 'common',
        grid = { 2, 2 },
        weight = 5000,
    },

    ['small_tv'] = {
        label = 'Small TV',
        rarity = 'uncommon',
        grid = { 2, 2 },
        weight = 100,
    },

    ['security_card_01'] = {
        grid = { 2, 1 },
        label = 'Security Card A',
        rarity = 'rare',
        weight = 100,
    },

    ['security_card_02'] = {
        grid = { 2, 1 },
        label = 'Security Card B',
        rarity = 'rare',
        weight = 100,
    },

    ['drill'] = {
        label = 'Drill',
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 5000,
    },

    ['thermite'] = {
        grid = { 2, 2 },
        label = 'Thermite',
        rarity = 'epic',
        weight = 1000,
    },


-- Add this to your regular items.lua (or replace if they already exist)
["diving_gear_1"] = {
    label = "Basic Scuba Gear",
    rarity = 'common',
    grid = { 2, 2 },
    clothing = 'backpack',
    weight = 1000,
    stack = false,
    close = true,
    consume = 0,
    description = "Basic diving equipment with 120 seconds of oxygen. Use to put on diving suit.",
    client = {
        image = "diving_gear_1.png",
    },
    server = {
        export = 'sd-civjobs.useDivingGear'
    }
},

["diving_gear_2"] = {
    label = "Improved Scuba Gear",
    rarity = 'uncommon',
    grid = { 2, 2 },
    clothing = 'backpack',
    weight = 1000,
    stack = false,
    close = true,
    consume = 0,
    description = "Improved diving equipment with 180 seconds of oxygen. Use to put on diving suit.",
    client = {
        image = "diving_gear_2.png",
    },
    server = {
        export = 'sd-civjobs.useDivingGear'
    }
},

["diving_gear_3"] = {
    label = "Advanced Scuba Gear",
    rarity = 'rare',
    grid = { 2, 2 },
    clothing = 'backpack',
    weight = 1000,
    stack = false,
    close = true,
    consume = 0,
    description = "Advanced diving equipment with 240 seconds of oxygen. Use to put on diving suit.",
    client = {
        image = "diving_gear_3.png",
    },
    server = {
        export = 'sd-civjobs.useDivingGear'
    }
},

["diving_gear_4"] = {
    label = "Professional Scuba Gear",
    rarity = 'epic',
    grid = { 2, 2 },
    clothing = 'backpack',
    weight = 1000,
    stack = false,
    close = true,
    consume = 0,
    description = "Professional diving equipment with 300 seconds of oxygen. Use to put on diving suit.",
    client = {
        image = "diving_gear_4.png",
    },
    server = {
        export = 'sd-civjobs.useDivingGear'
    }
},

["diving_gear_5"] = {
    label = "Elite Scuba Gear",
    rarity = 'legendary',
    grid = { 2, 2 },
    clothing = 'backpack',
    weight = 1000,
    stack = false,
    close = true,
    consume = 0,
    description = "Elite diving equipment with 360 seconds of oxygen. Use to put on diving suit.",
    client = {
        image = "diving_gear_5.png",
    },
    server = {
        export = 'sd-civjobs.useDivingGear'
    }
},
    
    ["diving_fill"] = {
        label = "Diving Tube",
        rarity = 'common',
        grid = { 1, 2 },
        weight = 1000,
        stack = false,
        close = true,
        consume = 0,
        description = "Refill your oxygen tank with this diving tube.",
        client = {
            image = "diving_tube.png",
        },
        server = {
            export = 'sd-civjobs.useDivingFill'
        }
    },

    ["welding_torch"] = {
        label = "Welding Torch",
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 2000,
        stack = false,
        close = true,
        consume = 0,
        description = "Professional welding torch for electrical repairs. Use near electrical equipment.",
        client = {
            image = "welding_torch.png",
        },
        server = {
            export = 'sd-civjobs.useWeldingTorch'
        }
    },

    ["diving_crate"] = {
        label = "Diving Crate",
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 500,
        stack = true,
        close = true,
        consume = 0,
        description = "A mysterious crate found while diving. Use to open and discover its contents.",
        client = {
            image = "diving_crate.png",
        },
        server = {
            export = 'sd-civjobs.openDivingCrate'
        }
    },    
    ["garden_shovel"] = {
        label = "Garden Shovel",
        rarity = 'common',
        grid = { 1, 3 },
        weight = 500,
        stack = true,
        close = true,
        consume = 0,
        description = "A sturdy garden shovel required for picking flowers. Essential tool for florist work.",
        client = {
            image = "garden_shovel.png",
        }
    },

    
    
    
    



    ['jerry_can'] = {
        label = 'Jerrycan',
        rarity = 'common',
        grid = { 2, 2 },
        weight = 3000,
    },

    ['nitrous'] = {
        label = 'Nitrous',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 1000,
    },

    ['wine'] = {
        client = { status = { thirst = 200000 }, anim = 'drinking', prop = 'wine', usetime = 2500, cancel = true },
        label = 'Vinho',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 500,
    },



    ['coffee'] = {
        client = { status = { thirst = 200000 }, anim = 'drinking', prop = 'coffee', usetime = 2500, cancel = true },
        grid = { 1, 1 },
        label = 'Café',
        rarity = 'common',
        weight = 200,
    },

    ['vodka'] = {
        client = { status = { thirst = 200000 }, anim = 'drinking', prop = 'vodka', usetime = 2500, cancel = true },
        label = 'Vodka',
        rarity = 'common',
        grid = { 1, 2 },
        weight = 500,
    },

    ['whiskey'] = {
        client = { status = { thirst = 200000 }, anim = 'drinking', prop = 'whiskey', usetime = 2500, cancel = true },
        label = 'Uísque',
        rarity = 'common',
        grid = { 1, 2 },
        weight = 200,
    },

    ['beer'] = {
        grid = { 2, 1 },
        client = { status = { thirst = 200000 }, anim = 'drinking', prop = 'beer', usetime = 2500, cancel = true },
        label = 'Cerveja',
        rarity = 'common',
        weight = 200,
    },

    ['sandwich'] = {
        client = { status = { hunger = 200000 }, anim = 'eating', prop = 'burger', usetime = 2500, cancel = true },
        grid = { 1, 1 },
        label = 'Sanduíche',
        rarity = 'common',
        weight = 200,
    },

    ['walking_stick'] = {
        label = 'Walking Stick',
        rarity = 'common',
        grid = { 1, 3 },
        weight = 1000,
    },

    ['lighter'] = {
        grid = { 1, 1 },
        label = 'Lighter',
        rarity = 'common',
        weight = 200,
    },

    ['binoculars'] = {
        label = 'Binoculars',
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 800,
    },


    ['empty_evidence_bag'] = {
        grid = { 2, 1 },
        label = 'Empty Evidence Bag',
        rarity = 'common',
        weight = 200,
    },

    ['filled_evidence_bag'] = {
        grid = { 2, 1 },
        label = 'Filled Evidence Bag',
        rarity = 'common',
        weight = 200,
    },

    ['harness'] = {
        grid = { 2, 2 },
        label = 'Harness',
        rarity = 'uncommon',
        clothing = 'torso',
        weight = 200,
    },

    ['flat_cap'] = {
        grid = { 2, 1 },
        label = 'Flat Cap',
        rarity = 'common',
        clothing = 'hat',
        weight = 150,
        stack = false,
        close = false,
        consume = 0,
        wear = {
            male   = { prop = 0, drawable = 15, texture = 0 },
            female = { prop = 0, drawable = 15, texture = 0 },
        },
    },

    ['ski_mask'] = {
        grid = { 2, 1 },
        label = 'Ski Mask',
        rarity = 'uncommon',
        clothing = 'mask',
        weight = 120,
        stack = false,
        close = false,
        consume = 0,
        wear = {
            male   = { component = 1, drawable = 52, texture = 0 },
            female = { component = 1, drawable = 52, texture = 0 },
        },
    },

    ['work_gloves'] = {
        grid = { 2, 1 },
        label = 'Work Gloves',
        rarity = 'common',
        clothing = 'gloves',
        weight = 100,
        stack = false,
        close = false,
        consume = 0,
        wear = {
            male   = { component = 3, drawable = 4, texture = 0 },
            female = { component = 3, drawable = 6, texture = 0 },
        },
    },

    ['handcuffs'] = {
        label = 'Algemas',
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 200,
    },

["workbench"] = {
    label = "Basic Workbench",
    rarity = 'rare',
    grid = { 3, 2 },
    weight = 5000,
    stack = false,
    close = true,
    description = "A small workbench for crafting basic stuff.",
    consume = 0,
    client = {
        image = "workbench.png",
    },
    server = {
        export = 'sd-crafting.useWorkbench',
    }
},

["advanced_workbench"] = {
    label = "Advanced Workbench",
    rarity = 'epic',
    grid = { 3, 2 },
    weight = 10000,
    stack = false,
    close = true,
    description = "A high-tech workbench with advanced crafting capabilities.",
    consume = 0,
    client = {
        image = "advanced_workbench.png",
    },
    server = {
        export = 'sd-crafting.useAdvanced_workbench',
    }
},

-- Crafting Blueprints
["blueprint_advancedlockpick"] = {
    grid = { 2, 1 },
    label = "Advanced Lockpick Blueprint",
    rarity = 'rare',
    weight = 100,
    stack = true,
    close = true,
    description = "A blueprint containing instructions for crafting an advanced lockpick. Add to crafting inventory to unlock the recipe.",
    consume = 0,
    client = {
        image = "blueprint_advancedlockpick.png",
    }
},













    ['merryweather_tablet'] = {
        label = 'Merryweather Tablet',
        rarity = 'legendary',
        grid = { 2, 2 },
        weight = 2000,
        stack = false,
        consume = 0,
        description = 'A ruggedized Merryweather field tablet, reflashed with a custom intrusion terminal.',
        client = { export = 'sd-deaddrop.useTablet', image = 'merryweather_tablet.png' },
        buttons = {
            {
                label = 'USB Storage',
                action = function(slot)
                    exports['sd-deaddrop']:openTabletStash(slot)
                end,
            },
        },
    },





    -- frp_mdt: printed record (REPORTS.EXE / CASES.EXE Print button). The
    -- metadata carries the frozen record snapshot; using it opens the document.
    ['mdt_document'] = {
        grid = { 2, 1 },
        label = 'Printed Document',
        rarity = 'common',
        weight = 50,
        stack = false,
        close = true,
        consume = 0,
        description = 'An official printed record from a department terminal.',
        client = { export = 'frp_mdt.mdt_document' },
    },


    ['traffic_cone'] = {
        label = 'Traffic Cone',
        rarity = 'common',
        grid = { 1, 2 },
        weight = 500,
        stack = true,
        close = false,
        consume = 0,
        description = 'A road cone. Someone told you a bloke out west collects them.',
    },

    ['racing_traffic_cone'] = {
        label = 'Racing Traffic Cone',
        rarity = 'uncommon',
        grid = { 1, 2 },
        weight = 250,
        stack = true,
        close = false,
        consume = 0,
        description = 'A road cone wrapped in racing tape. The crews leave these ones alone.',
    },

    ['road_map'] = {
        label = 'Road Map',
        rarity = 'uncommon',
        grid = { 2, 1 },
        weight = 200,
        stack = false,
        close = true,
        consume = 0,
        description = 'A folded road map, marked up in biro. Tracks you have driven get added to it.',
        client = {
            export = 'frp_racing.useRoadMap',
        },
    },



    ['backpack_fashion'] = {
        label = 'Mochila Básica',
        rarity = 'common',
        grid = { 2, 2 },
        clothing = 'backpack',
        weight = 600,
        stack = false,
        close = false,
        consume = 0,
        description = 'More of a statement than a bag. Holds a phone, a wallet, and very little else.',
    },

    ['backpack_small'] = {
        label = 'Mochila Pequena',
        rarity = 'common',
        grid = { 2, 2 },
        clothing = 'backpack',
        weight = 800,
        stack = false,
        close = false,
        consume = 0,
        description = 'A compact daypack. Ten pockets and not much shoulder strain.',
    },

    ['backpack_urban'] = {
        label = 'Mochila Urbana',
        rarity = 'common',
        grid = { 2, 2 },
        clothing = 'backpack',
        weight = 1100,
        stack = false,
        close = false,
        consume = 0,
        description = 'Loud panels, cheap zips, surprising amount of room. Built for a commute, used for worse.',
    },

    ['backpack_gamer'] = {
        label = 'Mochila Gamer',
        rarity = 'uncommon',
        grid = { 2, 2 },
        clothing = 'backpack',
        weight = 1300,
        stack = false,
        close = false,
        consume = 0,
        description = 'Padded sleeves, cable ports, and a light strip nobody asked for. The padding does earn its keep.',
    },

    ['backpack_medium'] = {
        label = 'Mochila Média',
        rarity = 'common',
        grid = { 2, 2 },
        clothing = 'backpack',
        weight = 1400,
        stack = false,
        close = false,
        consume = 0,
        description = 'A standard hiking pack. Twice the room of a daypack and still easy to run in.',
    },

    ['backpack_hiking'] = {
        label = 'Mochila de Trilha',
        rarity = 'rare',
        grid = { 2, 3 },
        clothing = 'backpack',
        weight = 2000,
        stack = false,
        close = false,
        consume = 0,
        description = 'Weatherproof shell, hip belt, and enough straps to lose a thumb in. Made for long days.',
    },

    ['backpack_large'] = {
        label = 'Mochila Grande',
        rarity = 'rare',
        grid = { 2, 3 },
        clothing = 'backpack',
        weight = 2200,
        stack = false,
        close = false,
        consume = 0,
        description = 'A heavy-duty hauler. Thirty pockets, and you will feel every one of them.',
    },

    ['duffel_bag_sport'] = {
        label = 'Bolsa Esportiva',
        rarity = 'epic',
        grid = { 3, 2 },
        clothing = 'backpack',
        weight = 2700,
        stack = false,
        close = false,
        consume = 0,
        description = 'Gym bag on paper. Nobody has ever checked what is actually inside one.',
    },

    ['duffel_bag'] = {
        label = 'Bolsa de Viagem',
        rarity = 'epic',
        grid = { 3, 2 },
        clothing = 'backpack',
        weight = 3000,
        stack = false,
        close = false,
        consume = 0,
        description = 'A holdall built for moving a lot at once. Heavy before you put anything in it.',
    },

    ['briefcase'] = {
        label = 'Maleta',
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 1500,
        stack = false,
        close = false,
        consume = 0,
        description = 'Brushed aluminium with a combination catch. Carried in hand, and it shows.',
    },

    ['medic_bag'] = {
        label = 'Bolsa Médica',
        rarity = 'rare',
        grid = { 3, 2 },
        weight = 2500,
        stack = false,
        close = false,
        consume = 0,
        description = 'Reflective trauma bag with a wide mouth. Everything inside is meant to be found fast.',
    },

    ['police_duty_belt'] = {
        label = 'Duty Belt',
        rarity = 'rare',
        grid = { 2, 1 },
        clothing = 'belt',
        weight = 1200,
        stack = false,
        close = false,
        consume = 0,
        description = 'Moulded pouches on a rigid belt. Spreads the load across your hips — carry 8kg more while worn.',
    },

    ['police_duty_belt_heavy'] = {
        label = 'Tactical Duty Belt',
        rarity = 'epic',
        grid = { 2, 1 },
        clothing = 'belt',
        weight = 1500,
        stack = false,
        close = false,
        consume = 0,
        description = 'The loaded-out version, with a drop leg strap taking the worst of it — carry 14kg more while worn.',
    },

    -- ==================== sd-restoration ====================
    ['salvage_tablet'] = {
        label = 'Salvage Tablet',
        rarity = 'rare',
        grid = { 2, 2 },
        weight = 700,
        stack = false,
        close = true,
        consume = 0,
        description = 'A battered trade tablet with a broker login saved on it. Opens the salvage catalog from anywhere.',
    },

    -- ---------------------------------------------------------------------------------------
    -- Raw materials (also what scrapping a project returns)
    -- ---------------------------------------------------------------------------------------
    ['steel_scrap']     = { grid = { 1, 1 }, label = 'Scrap Steel',      weight = 400, stack = true, close = false, description = 'Cut-up body steel. Worth more melted than it is bolted to anything.' },
    ['aluminium_scrap'] = { grid = { 1, 1 }, label = 'Scrap Aluminium',  weight = 220, stack = true, close = false, description = 'Light alloy offcuts — heads, wheels, the odd intake manifold.' },
    ['copper_wire']     = { grid = { 1, 1 }, label = 'Copper Wire',      weight = 120, stack = true, close = false, description = 'Stripped loom copper, coiled by hand.' },
    ['rubber_scrap']    = { grid = { 1, 1 }, label = 'Scrap Rubber',     weight = 180, stack = true, close = false, description = 'Perished hoses and dead tyre carcass.' },
    ['carbon_offcut']   = { grid = { 1, 1 }, label = 'Carbon Offcut',    weight = 90,  stack = true, close = false, description = 'Trimmings from a carbon panel. Sharp, light, and expensive.' },
    ['steel_stock']     = { grid = { 1, 1 }, label = 'Steel Stock',      weight = 900, stack = true, close = false, description = 'Fresh box section for cutting frame repair patches out of.' },
    ['welding_rod']     = { grid = { 2, 1 }, label = 'Welding Rod',      weight = 150, stack = true, close = false, description = 'Filler rod. Consumable, and you will always want one more.' },
    ['cutting_disc']    = { grid = { 2, 1 }, label = 'Cutting Disc',     weight = 100, stack = true, close = false, description = 'Thin abrasive disc for an angle grinder. Lasts about one arch.' },

    -- ---------------------------------------------------------------------------------------
    -- Chassis, suspension, brakes
    -- ---------------------------------------------------------------------------------------
    ['suspension_kit']  = { grid = { 3, 2 }, label = 'Suspension Kit',   weight = 2400, stack = true, close = false, description = 'Struts, springs and bushes for one corner.' },
    ['brake_kit']       = { grid = { 2, 2 }, label = 'Brake Kit',        weight = 1600, stack = true, close = false, description = 'Discs, pads and a caliper rebuild for one axle.' },
    ['brake_fluid']     = { grid = { 1, 1 }, label = 'Brake Fluid',      weight = 500,  stack = true, close = false, description = 'DOT 4. Eats paint, so do not spill it on the car you just sprayed.' },
    ['restored_wheel']  = { grid = { 3, 2 }, label = 'Restored Wheel',   weight = 8000, stack = true, close = false, description = 'A straightened rim with a fresh tyre on it, balanced and ready to hang.' },
    ['lug_nut']         = { grid = { 1, 1 }, label = 'Lug Nut',          weight = 40,   stack = true, close = false, description = 'One wheel nut. You will need five per corner and you will lose one.' },

    -- ---------------------------------------------------------------------------------------
    -- Engine and drivetrain
    -- ---------------------------------------------------------------------------------------
    ['engine_block']    = { grid = { 3, 2 }, label = 'Engine Block',     weight = 30000, stack = true, close = false, description = 'A rebuilt short block on a stand. Do not try to carry two.' },
    ['engine_mount']    = { grid = { 2, 2 }, label = 'Engine Mount',     weight = 700,   stack = true, close = false, description = 'Rubber and steel. The thing that stops the engine leaving the car.' },
    ['cylinder_head']   = { grid = { 2, 2 }, label = 'Cylinder Head',    weight = 9000,  stack = true, close = false, description = 'Skimmed flat, valves lapped, ready to torque down.' },
    ['head_gasket']     = { grid = { 2, 2 }, label = 'Head Gasket',      weight = 200,   stack = true, close = false, description = 'Multi-layer steel. Fit it once, fit it right.' },
    ['head_bolt']       = { grid = { 1, 1 }, label = 'Head Bolt',        weight = 90,    stack = true, close = false, description = 'Torque-to-yield. Single use, no arguments.' },
    ['timing_kit']      = { grid = { 2, 2 }, label = 'Timing Kit',       weight = 1200,  stack = true, close = false, description = 'Belt, tensioner and idlers. Cheaper than the valves it saves.' },
    ['transmission']    = { grid = { 3, 2 }, label = 'Transmission',     weight = 22000, stack = true, close = false, description = 'A rebuilt gearbox, drained and sealed for transport.' },
    ['gear_oil']        = { grid = { 1, 1 }, label = 'Gear Oil',         weight = 900,   stack = true, close = false, description = 'Heavy and foul-smelling. Everything about it is correct.' },
    ['radiator']        = { grid = { 3, 2 }, label = 'Radiator',         weight = 3500,  stack = true, close = false, description = 'Recored and pressure-tested.' },
    ['coolant_hose']    = { grid = { 2, 1 }, label = 'Coolant Hose',     weight = 250,   stack = true, close = false, description = 'Silicone hose in a length that is never quite the length you needed.' },
    ['exhaust_section'] = { grid = { 2, 2 }, label = 'Exhaust Section',  weight = 4000,  stack = true, close = false, description = 'Mandrel-bent tubing, one section of a system.' },
    ['exhaust_clamp']   = { grid = { 2, 1 }, label = 'Exhaust Clamp',    weight = 120,   stack = true, close = false, description = 'A band clamp. Cheap insurance against a drone you cannot find.' },
    ['fuel_pump']       = { grid = { 2, 2 }, label = 'Fuel Pump',        weight = 1100,  stack = true, close = false, description = 'In-tank pump and sender assembly.' },
    ['fuel_line']       = { grid = { 2, 1 }, label = 'Fuel Line',        weight = 300,   stack = true, close = false, description = 'Braided line, rated well past anything this engine will make.' },
    ['car_battery']     = { grid = { 2, 2 }, label = 'Car Battery',      weight = 14000, stack = true, close = false, description = 'Charged and load-tested. The last thing you fit before it starts.' },
    ['motor_oil']       = { grid = { 1, 1 }, label = 'Motor Oil',        weight = 1000,  stack = true, close = false, description = 'Five litres of the correct grade.' },
    ['coolant']         = { grid = { 1, 1 }, label = 'Coolant',          weight = 1000,  stack = true, close = false, description = 'Pre-mixed. Bright enough to find on the floor when it leaks.' },

    -- ---------------------------------------------------------------------------------------
    -- Electrical
    -- ---------------------------------------------------------------------------------------
    ['wiring_harness']  = { grid = { 2, 2 }, label = 'Wiring Harness',   weight = 3000, stack = true, close = false, description = 'A whole loom, labelled by somebody who cared. Rare and precious.' },
    ['electrical_tape'] = { grid = { 2, 1 }, label = 'Electrical Tape',  weight = 80,   stack = true, close = false, description = 'Cloth tape, because the sticky kind turns to soup in an engine bay.' },
    ['dash_cluster']    = { grid = { 2, 2 }, label = 'Dash Cluster',     weight = 2200, stack = true, close = false, description = 'Instrument binnacle with every bulb replaced.' },
    ['headlight_set']   = { grid = { 2, 2 }, label = 'Headlight Set',    weight = 3000, stack = true, close = false, description = 'A matched pair, polished clear.' },
    ['taillight_set']   = { grid = { 2, 2 }, label = 'Taillight Set',    weight = 2000, stack = true, close = false, description = 'A matched pair, no cracks, correct lenses.' },

    -- ---------------------------------------------------------------------------------------
    -- Body, glass and paint
    -- ---------------------------------------------------------------------------------------
    ['body_panel']      = { grid = { 3, 2 }, label = 'Body Panel',       weight = 7000, stack = true, close = false, description = 'A straight replacement panel. Getting it to line up is the hard part.' },
    ['panel_bolt']      = { grid = { 1, 1 }, label = 'Panel Bolt',       weight = 40,   stack = true, close = false, description = 'One captive bolt with a shouldered washer.' },
    ['door_hinge']      = { grid = { 2, 1 }, label = 'Door Hinge',       weight = 800,  stack = true, close = false, description = 'New pins and bushes, so the door stops dropping.' },
    ['bumper_shell']    = { grid = { 3, 2 }, label = 'Bumper Shell',     weight = 5000, stack = true, close = false, description = 'Unpainted bumper skin, ready for prep.' },
    ['widebody_arch']   = { grid = { 3, 2 }, label = 'Widebody Arch',    weight = 4000, stack = true, close = false, description = 'A moulded over-fender. Fitting it means cutting the wing you already own.' },
    ['auto_glass']      = { grid = { 2, 2 }, label = 'Auto Glass',       weight = 6000, stack = true, close = false, description = 'Laminated glass cut to pattern. Handle with two hands.' },
    ['urethane_tube']   = { grid = { 2, 1 }, label = 'Urethane Tube',    weight = 400,  stack = true, close = false, description = 'Glass bonding adhesive. One continuous bead or it leaks.' },
    ['sandpaper']       = { grid = { 2, 1 }, label = 'Sandpaper',        weight = 60,   stack = true, close = false, description = 'Wet-and-dry sheets. Never enough of them.' },
    ['body_filler']     = { grid = { 2, 1 }, label = 'Body Filler',      weight = 1200, stack = true, close = false, description = 'Two-part filler and hardener. A skim, not a sculpture.' },
    ['primer_can']      = { grid = { 2, 2 }, label = 'Primer',           weight = 1400, stack = true, close = false, description = 'High-build primer. Grey, dull, and the reason the colour looks right.' },
    ['paint_can']       = { grid = { 2, 2 }, label = 'Paint',            weight = 1400, stack = true, close = false, description = 'Base coat, mixed to whatever code you gave the shop.' },
    ['clearcoat_can']   = { grid = { 2, 2 }, label = 'Clearcoat',        weight = 1400, stack = true, close = false, description = 'Two-pack clear. The shine is entirely this.' },

    -- ---------------------------------------------------------------------------------------
    -- Interior
    -- ---------------------------------------------------------------------------------------
    ['seat_kit']        = { grid = { 3, 2 }, label = 'Seat Kit',         weight = 12000, stack = true, close = false, description = 'A retrimmed seat with new foam.' },
    ['trim_set']        = { grid = { 2, 2 }, label = 'Trim Set',         weight = 4000,  stack = true, close = false, description = 'Door cards, sills and pillar trims, with most of the clips.' },
}
