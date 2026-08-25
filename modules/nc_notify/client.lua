-- nc_notify (NewCity) — reroteia TODA notificacao do ox_inventory (via lib.notify)
-- para o nc_ui, pra o servidor ter UMA cara de notificacao so. Direcao UNICA
-- (client -> nc_ui local): nunca reemite lib.notify/ox_lib:notify, entao nao ha loop.
-- Isolado num modulo proprio pra higiene de rebase com o upstream ox_inventory.
if not lib then return end

-- type do ox_lib -> kind do nc_ui (nui.ts: success|error|info|warning; o App do
-- nc_ui cai em 'info' se vier desconhecido). 'inform' e um alias legado do qb/ox.
local KIND = {
    success = 'success',
    error   = 'error',
    warning = 'warning',
    info    = 'info',
    inform  = 'info',
}

-- Captura o ORIGINAL antes de trocar a chave: o acesso dispara o lazy-load do
-- ox_lib e a chave passa a guardar o valor cru (o __index nao dispara mais).
-- Serve de fallback sem recursao.
local _oxNotify = lib.notify

lib.notify = function(data)
    if type(data) ~= 'table' then return _oxNotify(data) end
    -- Degradacao graciosa: se o nc_ui nao estiver de pe, usa o toast original.
    if GetResourceState('nc_ui') ~= 'started' then return _oxNotify(data) end

    -- Utils.Notify ja converte text->description antes de chegar aqui; cobrimos os 3.
    local message = data.description or data.title or data.text
    if type(message) ~= 'string' or message == '' then
        return _oxNotify(data) -- nada exibivel: melhor o original que um card vazio
    end

    TriggerEvent('nc_ui:notify', { kind = KIND[data.type] or 'info', message = message })
end
