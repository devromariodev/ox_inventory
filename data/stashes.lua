return {
	-- >>> NEWCITY: ARMARIO PESSOAL DA POLICIA DESLIGADO >>>
	-- Bau pessoal de demonstracao do upstream (70 slots, `owner = true`), dentro da
	-- delegacia, a dois metros do nosso vestiario (454.91/-990.89/30.69).
	--
	-- POR QUE SAI (ADR-0013 §4, "desligar, nao neutralizar"): quem e dono do armario
	-- da policia e o `nc_job_police` (`ARQ-18`), e o nosso nao guarda nada -- entrega
	-- o kit do grau e recolhe tudo no fim do turno (`EMP-17`).
	--
	-- E, pior que duplicado, este bau e o BURACO do `EMP-17`: o
	-- `nc_items:RemoveTagged` nao desce em container, entao um bau pessoal dentro da
	-- delegacia e o lugar perfeito pra guardar o fuzil da corporacao antes de bater
	-- o ponto de saida. A pendencia ja esta escrita no README do `nc_job_police`;
	-- ligar este bau seria servir a fuga numa bandeja.
	--
	-- E ele nao aparece pra ninguem HOJE, mas por ACIDENTE e nao por decisao: o
	-- `groups` pergunta ao `PlayerData.job` do qbx_core, e o `nc_jobs` nunca escreve
	-- la (`EMP-13`).
	--
	-- O `emslocker` abaixo FICA, de proposito: `ambulance` e conceito que ainda NAO
	-- e nosso (`ARQ-18`, ultima linha -- hospital/paramedico e Marco 4), e o §4 do
	-- ADR-0013 so manda desligar o motor daquilo que a gente assumiu.
	--[[
	{
		coords = vec3(452.3, -991.4, 30.7),
		target = {
			loc = vec3(451.25, -994.28, 30.69),
			length = 1.2,
			width = 5.6,
			heading = 0,
			minZ = 29.49,
			maxZ = 32.09,
			label = 'Abrir o armário pessoal'
		},
		name = 'policelocker',
		label = 'Armário pessoal',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = shared.police
	},
	]]
	-- <<< NEWCITY: ARMARIO PESSOAL DA POLICIA DESLIGADO <<<

	{
		coords = vec3(301.3, -600.23, 43.28),
		target = {
			loc = vec3(301.82, -600.99, 43.29),
			length = 0.6,
			width = 1.8,
			heading = 340,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Abrir o armário pessoal'
		},
		name = 'emslocker',
		label = 'Armário pessoal',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = {['ambulance'] = 0}
	},
}
