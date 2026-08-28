local Vehicles = {
	-- 0	vehicle has no storage
	-- 1	vehicle has no trunk storage
	-- 2	vehicle has no glovebox storage
	-- 3	vehicle has trunk in the hood
	Storage = {
		[`jester`] = 3,
		[`adder`] = 3,
		[`osiris`] = 1,
		[`pfister811`] = 1,
		[`penetrator`] = 1,
		[`autarch`] = 1,
		[`bullet`] = 1,
		[`cheetah`] = 1,
		[`cyclone`] = 1,
		[`voltic`] = 1,
		[`reaper`] = 3,
		[`entityxf`] = 1,
		[`t20`] = 1,
		[`taipan`] = 1,
		[`tezeract`] = 1,
		[`torero`] = 3,
		[`turismor`] = 1,
		[`fmj`] = 1,
		[`infernus`] = 1,
		[`italigtb`] = 3,
		[`italigtb2`] = 3,
		[`nero2`] = 1,
		[`vacca`] = 3,
		[`vagner`] = 1,
		[`visione`] = 1,
		[`prototipo`] = 1,
		[`zentorno`] = 1,
		[`trophytruck`] = 0,
		[`trophytruck2`] = 0,
	},

	-- slots, maxWeight; default weight is 8000 per slot
	glovebox = {
		[0] = {11, 88000},		-- Compact
		[1] = {11, 88000},		-- Sedan
		[2] = {11, 88000},		-- SUV
		[3] = {11, 88000},		-- Coupe
		[4] = {11, 88000},		-- Muscle
		[5] = {11, 88000},		-- Sports Classic
		[6] = {11, 88000},		-- Sports
		[7] = {11, 88000},		-- Super
		[8] = {5, 40000},		-- Motorcycle
		[9] = {11, 88000},		-- Offroad
		[10] = {11, 88000},		-- Industrial
		[11] = {11, 88000},		-- Utility
		[12] = {11, 88000},		-- Van
		[14] = {31, 248000},	-- Boat
		[15] = {31, 248000},	-- Helicopter
		[16] = {51, 408000},	-- Plane
		[17] = {11, 88000},		-- Service
		[18] = {11, 88000},		-- Emergency
		[19] = {11, 88000},		-- Military
		[20] = {11, 88000},		-- Commercial (trucks)
		models = {
			[`xa21`] = {11, 88000}
		}
	},

	trunk = {
		[0] = {21, 168000},		-- Compact
		[1] = {41, 328000},		-- Sedan
		[2] = {51, 408000},		-- SUV
		[3] = {31, 248000},		-- Coupe
		[4] = {41, 328000},		-- Muscle
		[5] = {31, 248000},		-- Sports Classic
		[6] = {31, 248000},		-- Sports
		[7] = {21, 168000},		-- Super
		[8] = {5, 40000},		-- Motorcycle
		[9] = {51, 408000},		-- Offroad
		[10] = {51, 408000},	-- Industrial
		[11] = {41, 328000},	-- Utility
		[12] = {61, 488000},	-- Van
		-- [14] -- Boat
		-- [15] -- Helicopter
		-- [16] -- Plane
		[17] = {41, 328000},	-- Service
		[18] = {41, 328000},	-- Emergency
		[19] = {41, 328000},	-- Military
		[20] = {61, 488000},	-- Commercial
		models = {
			[`xa21`] = {11, 10000}
		},
	}
}

-- ==== NEWCITY ==============================================================
-- A POLITICA (quanto cabe em cada carro) mora no nc_vehicles, em
-- shared/storage.lua — tabela gerada por tools/vehicle-storage. Aqui so a
-- FUSAO.
--
-- Por que a tabela nao mora aqui: a loja de carros mostra no card quanto a
-- mala aguenta, e os dois lados tem que ler o MESMO numero. Se cada um
-- tivesse a sua copia, o card mentiria mais cedo ou mais tarde.
--
-- Por que os numeros do upstream nao serviam: eles vem so por CLASSE, e o
-- porta-luvas de quase todo carro aguentava 88 kg — com o jogador inteiro
-- carregando 30 kg. Cabiam tres mochilas de jogador no porta-luvas.
--
-- Sem o nc_vehicles no ar, valem os numeros do upstream: degradacao, nao erro.
-- E por isso que o pcall engole em silencio.
do
    local bruto = LoadResourceFile('nc_vehicles', 'shared/storage.lua')
    local chunk = bruto and load(bruto, '@nc_storage', 't')
    local ok, nc = pcall(chunk or function() end)

    if ok and type(nc) == 'table' and type(nc.modelos) == 'table' then
        -- Fallback por classe do GTA, pro que a tabela por modelo nao cobre.
        for classe, cap in pairs(nc.classes or {}) do
            Vehicles.trunk[classe] = { 50, cap.mala }
            Vehicles.glovebox[classe] = { 50, cap.luvas }
        end

        -- Por modelo. `Storage` diz se o compartimento EXISTE e por onde abre;
        -- `trunk.models`/`glovebox.models` dizem QUANTO cabe.
        for modelo, cap in pairs(nc.modelos) do
            local hash = GetHashKey(modelo)

            if (cap.mala or 0) > 0 then
                Vehicles.trunk.models[hash] = { 50, cap.mala }
                -- 3 = mala no capo (motor central/traseiro); nil = traseira
                -- normal, que e o comportamento padrao.
                Vehicles.Storage[hash] = cap.onde == 'capo' and 3 or nil
            else
                -- 1 = sem mala mas com porta-luvas; 0 = sem nada.
                Vehicles.Storage[hash] = (cap.luvas or 0) > 0 and 1 or 0
            end

            if (cap.luvas or 0) > 0 then
                Vehicles.glovebox.models[hash] = { 50, cap.luvas }
            end
        end
    end
end

return Vehicles
