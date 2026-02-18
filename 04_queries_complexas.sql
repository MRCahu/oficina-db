-- ============================================================================
-- QUERIES COMPLEXAS - OFICINA DE AUTOMÓVEIS
-- Requisitos: SELECT, WHERE, derivados, ORDER BY, HAVING, JOINs
-- ============================================================================

USE oficina_db;

-- ============================================================================
-- SEÇÃO 1: QUERIES COM SELECT, WHERE E DERIVADOS
-- ============================================================================

-- Q1. Quantos serviços foram realizados por cada cliente?
-- Responde: Qual cliente utilizou mais os serviços da oficina?
SELECT 
    c.id,
    c.nome,
    c.tipo,
    COUNT(s.id) AS total_servicos,
    SUM(s.custo_total) AS valor_total_gasto,
    ROUND(AVG(s.custo_total), 2) AS ticket_medio,
    MAX(s.data_conclusao) AS data_ultimo_servico
FROM cliente c
LEFT JOIN veiculo v ON c.id = v.cliente_id
LEFT JOIN servico s ON v.id = s.veiculo_id
WHERE c.ativo = 1
GROUP BY c.id, c.nome, c.tipo
ORDER BY total_servicos DESC;

-- Q2. Clientes com mais de 2 serviços realizados
-- Responde: Quais clientes são os mais frequentes?
SELECT 
    c.id,
    c.nome,
    c.cpf_cnpj,
    c.email,
    COUNT(s.id) AS total_servicos,
    SUM(s.custo_total) AS valor_total_gasto,
    ROUND(AVG(s.custo_total), 2) AS ticket_medio
FROM cliente c
INNER JOIN veiculo v ON c.id = v.cliente_id
INNER JOIN servico s ON v.id = s.veiculo_id
WHERE c.ativo = 1 AND s.status = 'concluido'
GROUP BY c.id, c.nome, c.cpf_cnpj, c.email
HAVING COUNT(s.id) > 2
ORDER BY total_servicos DESC;

-- Q3. Veículos com mais serviços realizados
-- Responde: Qual veículo mais frequenta a oficina?
SELECT 
    v.id,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo, ' (', v.ano, ')') AS veiculo_completo,
    c.nome AS cliente,
    COUNT(s.id) AS total_servicos,
    SUM(s.custo_total) AS valor_total_gasto,
    v.quilometragem_atual
FROM veiculo v
INNER JOIN cliente c ON v.cliente_id = c.id
LEFT JOIN servico s ON v.id = s.veiculo_id
WHERE v.ativo = 1
GROUP BY v.id, v.placa, v.marca, v.modelo, v.ano, c.nome, v.quilometragem_atual
ORDER BY total_servicos DESC;

-- Q4. Serviços em andamento
-- Responde: Quais serviços ainda não foram concluídos?
SELECT 
    s.id,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo) AS veiculo,
    c.nome AS cliente,
    ts.nome AS tipo_servico,
    s.data_inicio,
    DATEDIFF(CURDATE(), DATE(s.data_inicio)) AS dias_em_andamento,
    s.custo_mao_obra,
    s.custo_peca,
    s.custo_total,
    s.descricao
FROM servico s
INNER JOIN veiculo v ON s.veiculo_id = v.id
INNER JOIN cliente c ON v.cliente_id = c.id
INNER JOIN tipo_servico ts ON s.tipo_servico_id = ts.id
WHERE s.status = 'em_andamento'
ORDER BY s.data_inicio ASC;

-- ============================================================================
-- SEÇÃO 2: QUERIES COM JOINS MÚLTIPLOS (Peças, Fornecedores, Estoque)
-- ============================================================================

-- Q5. Relação de serviços com peças utilizadas
-- Responde: Quais peças foram usadas em cada serviço?
SELECT 
    s.id AS servico_id,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo) AS veiculo,
    ts.nome AS tipo_servico,
    p.nome AS peca,
    sp.quantidade,
    sp.preco_unitario,
    sp.subtotal,
    f.razao_social AS fornecedor
FROM servico s
INNER JOIN veiculo v ON s.veiculo_id = v.id
INNER JOIN tipo_servico ts ON s.tipo_servico_id = ts.id
INNER JOIN servico_peca sp ON s.id = sp.servico_id
INNER JOIN peca p ON sp.peca_id = p.id
LEFT JOIN fornecedor f ON p.fornecedor_id = f.id
WHERE s.status = 'concluido'
ORDER BY s.id, p.nome;

-- Q6. Peças com baixo estoque
-- Responde: Quais peças precisam ser repostas?
SELECT 
    p.id,
    p.nome,
    p.estoque_quantidade,
    p.estoque_minimo,
    (p.estoque_minimo - p.estoque_quantidade) AS quantidade_necessaria,
    f.razao_social AS fornecedor,
    p.preco_custo,
    ROUND((p.estoque_minimo - p.estoque_quantidade) * p.preco_custo, 2) AS valor_reposicao
FROM peca p
LEFT JOIN fornecedor f ON p.fornecedor_id = f.id
WHERE p.estoque_quantidade <= p.estoque_minimo AND p.ativo = 1
ORDER BY quantidade_necessaria DESC;

-- Q7. Fornecedores e quantidade de peças fornecidas
-- Responde: Qual fornecedor fornece mais peças?
SELECT 
    f.id,
    f.razao_social,
    f.cnpj,
    f.email,
    f.telefone,
    COUNT(DISTINCT p.id) AS total_pecas,
    SUM(p.estoque_quantidade) AS estoque_total,
    ROUND(AVG(p.preco_venda), 2) AS preco_medio_venda
FROM fornecedor f
LEFT JOIN peca p ON f.id = p.fornecedor_id
WHERE f.ativo = 1
GROUP BY f.id, f.razao_social, f.cnpj, f.email, f.telefone
ORDER BY total_pecas DESC;

-- Q8. Custo de peças por serviço
-- Responde: Qual serviço utilizou mais peças em valor?
SELECT 
    s.id,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo) AS veiculo,
    ts.nome AS tipo_servico,
    COUNT(DISTINCT sp.peca_id) AS total_pecas_diferentes,
    SUM(sp.quantidade) AS total_quantidade_pecas,
    SUM(sp.subtotal) AS custo_total_pecas,
    s.custo_mao_obra,
    s.custo_total
FROM servico s
INNER JOIN veiculo v ON s.veiculo_id = v.id
INNER JOIN tipo_servico ts ON s.tipo_servico_id = ts.id
LEFT JOIN servico_peca sp ON s.id = sp.servico_id
WHERE s.status = 'concluido'
GROUP BY s.id, v.placa, v.marca, v.modelo, ts.nome, s.custo_mao_obra, s.custo_total
ORDER BY custo_total_pecas DESC;

-- ============================================================================
-- SEÇÃO 3: QUERIES COM ORDER BY E DERIVADOS (Atributos Calculados)
-- ============================================================================

-- Q9. Ranking de tipos de serviço mais realizados
-- Responde: Qual tipo de serviço gera mais receita?
SELECT 
    ts.id,
    ts.nome,
    COUNT(s.id) AS total_servicos,
    SUM(s.custo_total) AS receita_total,
    ROUND(AVG(s.custo_total), 2) AS valor_medio,
    ROUND(SUM(s.custo_mao_obra), 2) AS custo_mao_obra_total,
    ROUND(SUM(s.custo_peca), 2) AS custo_peca_total,
    ROUND(SUM(s.custo_total) - (SUM(s.custo_mao_obra) + SUM(s.custo_peca)), 2) AS lucro_estimado
FROM tipo_servico ts
LEFT JOIN servico s ON ts.id = s.tipo_servico_id
WHERE s.status = 'concluido'
GROUP BY ts.id, ts.nome
ORDER BY receita_total DESC;

-- Q10. Desempenho de mecânicos
-- Responde: Qual mecânico trabalhou mais horas e gerou mais receita?
SELECT 
    m.id,
    m.nome,
    m.especialidade,
    COUNT(DISTINCT ms.servico_id) AS total_servicos,
    ROUND(SUM(ms.horas_trabalhadas), 2) AS total_horas,
    ROUND(SUM(ms.subtotal), 2) AS receita_mao_obra,
    ROUND(AVG(ms.valor_hora), 2) AS valor_hora_medio,
    ROUND(SUM(ms.subtotal) / SUM(ms.horas_trabalhadas), 2) AS receita_por_hora
FROM mecanico m
LEFT JOIN mecanico_servico ms ON m.id = ms.mecanico_id
WHERE m.ativo = 1
GROUP BY m.id, m.nome, m.especialidade
ORDER BY total_horas DESC;

-- Q11. Agendamentos próximos (próximos 7 dias)
-- Responde: Quais agendamentos estão marcados para os próximos 7 dias?
SELECT 
    a.id,
    a.data_agendamento,
    a.hora_inicio,
    a.hora_fim,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo) AS veiculo,
    c.nome AS cliente,
    m.nome AS mecanico,
    a.status,
    DATEDIFF(a.data_agendamento, CURDATE()) AS dias_para_agendamento
FROM agendamento a
INNER JOIN veiculo v ON a.veiculo_id = v.id
INNER JOIN cliente c ON v.cliente_id = c.id
INNER JOIN mecanico m ON a.mecanico_id = m.id
WHERE a.data_agendamento BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
ORDER BY a.data_agendamento, a.hora_inicio;

-- Q12. Pagamentos pendentes
-- Responde: Quais serviços ainda não foram pagos?
SELECT 
    p.id,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo) AS veiculo,
    c.nome AS cliente,
    ts.nome AS tipo_servico,
    p.valor_total,
    p.forma_pagamento,
    p.status,
    DATEDIFF(CURDATE(), DATE(s.data_conclusao)) AS dias_desde_conclusao
FROM pagamento p
INNER JOIN servico s ON p.servico_id = s.id
INNER JOIN veiculo v ON s.veiculo_id = v.id
INNER JOIN cliente c ON v.cliente_id = c.id
INNER JOIN tipo_servico ts ON s.tipo_servico_id = ts.id
WHERE p.status = 'pendente'
ORDER BY s.data_conclusao ASC;

-- ============================================================================
-- SEÇÃO 4: QUERIES COM HAVING (Filtros em Agregações)
-- ============================================================================

-- Q13. Mecânicos com mais de 10 horas trabalhadas
-- Responde: Quais mecânicos têm maior carga de trabalho?
SELECT 
    m.id,
    m.nome,
    m.especialidade,
    COUNT(DISTINCT ms.servico_id) AS total_servicos,
    ROUND(SUM(ms.horas_trabalhadas), 2) AS total_horas,
    ROUND(SUM(ms.subtotal), 2) AS receita_total
FROM mecanico m
INNER JOIN mecanico_servico ms ON m.id = ms.mecanico_id
WHERE m.ativo = 1
GROUP BY m.id, m.nome, m.especialidade
HAVING SUM(ms.horas_trabalhadas) > 10
ORDER BY total_horas DESC;

-- Q14. Tipos de serviço com receita acima da média
-- Responde: Quais tipos de serviço são mais lucrativos?
SELECT 
    ts.id,
    ts.nome,
    COUNT(s.id) AS total_servicos,
    ROUND(SUM(s.custo_total), 2) AS receita_total,
    ROUND(AVG(s.custo_total), 2) AS valor_medio
FROM tipo_servico ts
LEFT JOIN servico s ON ts.id = s.tipo_servico_id
WHERE s.status = 'concluido'
GROUP BY ts.id, ts.nome
HAVING ROUND(SUM(s.custo_total), 2) > (
    SELECT AVG(receita_total) FROM (
        SELECT SUM(s2.custo_total) AS receita_total
        FROM tipo_servico ts2
        LEFT JOIN servico s2 ON ts2.id = s2.tipo_servico_id
        WHERE s2.status = 'concluido'
        GROUP BY ts2.id
    ) AS subquery
)
ORDER BY receita_total DESC;

-- Q15. Clientes com gasto total acima de R$ 500
-- Responde: Quais clientes são os maiores gastadores?
SELECT 
    c.id,
    c.nome,
    c.tipo,
    COUNT(DISTINCT v.id) AS total_veiculos,
    COUNT(DISTINCT s.id) AS total_servicos,
    ROUND(SUM(s.custo_total), 2) AS gasto_total,
    ROUND(AVG(s.custo_total), 2) AS ticket_medio
FROM cliente c
LEFT JOIN veiculo v ON c.id = v.cliente_id
LEFT JOIN servico s ON v.id = s.veiculo_id
WHERE c.ativo = 1 AND s.status = 'concluido'
GROUP BY c.id, c.nome, c.tipo
HAVING ROUND(SUM(s.custo_total), 2) > 500
ORDER BY gasto_total DESC;

-- ============================================================================
-- SEÇÃO 5: QUERIES COM MÚLTIPLOS JOINS E DERIVADOS COMPLEXOS
-- ============================================================================

-- Q16. Análise completa de serviços com cliente, veículo, peças e mecânico
-- Responde: Visão 360° de cada serviço realizado
SELECT 
    s.id,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo, ' (', v.ano, ')') AS veiculo_completo,
    c.nome AS cliente,
    ts.nome AS tipo_servico,
    s.data_inicio,
    s.data_conclusao,
    DATEDIFF(s.data_conclusao, s.data_inicio) AS dias_duracao,
    COUNT(DISTINCT sp.peca_id) AS total_pecas,
    COUNT(DISTINCT ms.mecanico_id) AS total_mecanicos,
    ROUND(SUM(ms.horas_trabalhadas), 2) AS total_horas_mecanicos,
    s.custo_mao_obra,
    s.custo_peca,
    s.custo_total,
    p.valor_total AS valor_pagamento,
    p.forma_pagamento,
    p.status AS status_pagamento
FROM servico s
INNER JOIN veiculo v ON s.veiculo_id = v.id
INNER JOIN cliente c ON v.cliente_id = c.id
INNER JOIN tipo_servico ts ON s.tipo_servico_id = ts.id
LEFT JOIN servico_peca sp ON s.id = sp.servico_id
LEFT JOIN mecanico_servico ms ON s.id = ms.servico_id
LEFT JOIN pagamento p ON s.id = p.servico_id
WHERE s.status = 'concluido'
GROUP BY s.id, v.placa, v.marca, v.modelo, v.ano, c.nome, ts.nome, s.data_inicio, s.data_conclusao, 
         s.custo_mao_obra, s.custo_peca, s.custo_total, p.valor_total, p.forma_pagamento, p.status
ORDER BY s.data_conclusao DESC;

-- Q17. Receita por período (mensal)
-- Responde: Qual mês gerou mais receita?
SELECT 
    DATE_TRUNC(s.data_conclusao, MONTH) AS mes_referencia,
    YEAR(s.data_conclusao) AS ano,
    MONTH(s.data_conclusao) AS mes,
    COUNT(s.id) AS total_servicos,
    ROUND(SUM(s.custo_total), 2) AS receita_total,
    ROUND(SUM(s.custo_mao_obra), 2) AS mao_obra_total,
    ROUND(SUM(s.custo_peca), 2) AS peca_total,
    ROUND(AVG(s.custo_total), 2) AS ticket_medio
FROM servico s
WHERE s.status = 'concluido'
GROUP BY YEAR(s.data_conclusao), MONTH(s.data_conclusao)
ORDER BY YEAR(s.data_conclusao) DESC, MONTH(s.data_conclusao) DESC;

-- Q18. Histórico de manutenção por veículo
-- Responde: Qual é o histórico completo de manutenção de um veículo?
SELECT 
    v.id,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo, ' (', v.ano, ')') AS veiculo_completo,
    c.nome AS cliente,
    COUNT(s.id) AS total_servicos,
    GROUP_CONCAT(DISTINCT ts.nome SEPARATOR ', ') AS tipos_servicos,
    MIN(s.data_inicio) AS primeira_manutencao,
    MAX(s.data_conclusao) AS ultima_manutencao,
    ROUND(SUM(s.custo_total), 2) AS custo_total_manutencao,
    v.quilometragem_atual
FROM veiculo v
INNER JOIN cliente c ON v.cliente_id = c.id
LEFT JOIN servico s ON v.id = s.veiculo_id
LEFT JOIN tipo_servico ts ON s.tipo_servico_id = ts.id
WHERE v.ativo = 1
GROUP BY v.id, v.placa, v.marca, v.modelo, v.ano, c.nome, v.quilometragem_atual
ORDER BY total_servicos DESC;

-- Q19. Formas de pagamento mais utilizadas
-- Responde: Qual forma de pagamento é mais popular?
SELECT 
    p.forma_pagamento,
    COUNT(p.id) AS total_transacoes,
    ROUND(SUM(p.valor_total), 2) AS valor_total_movimentado,
    ROUND(AVG(p.valor_total), 2) AS valor_medio_transacao,
    ROUND(COUNT(p.id) / (SELECT COUNT(*) FROM pagamento WHERE status = 'pago') * 100, 2) AS percentual_uso,
    COUNT(CASE WHEN p.status = 'pago' THEN 1 END) AS transacoes_pagas,
    COUNT(CASE WHEN p.status = 'pendente' THEN 1 END) AS transacoes_pendentes
FROM pagamento p
GROUP BY p.forma_pagamento
ORDER BY valor_total_movimentado DESC;

-- Q20. Eficiência de mecânicos (receita por hora)
-- Responde: Qual mecânico gera mais receita por hora trabalhada?
SELECT 
    m.id,
    m.nome,
    m.especialidade,
    m.salario_base,
    ROUND(SUM(ms.horas_trabalhadas), 2) AS total_horas,
    ROUND(SUM(ms.subtotal), 2) AS receita_gerada,
    ROUND(SUM(ms.subtotal) / SUM(ms.horas_trabalhadas), 2) AS receita_por_hora,
    ROUND((SUM(ms.subtotal) / SUM(ms.horas_trabalhadas)) - (m.salario_base / 160), 2) AS lucro_por_hora
FROM mecanico m
INNER JOIN mecanico_servico ms ON m.id = ms.mecanico_id
WHERE m.ativo = 1
GROUP BY m.id, m.nome, m.especialidade, m.salario_base
ORDER BY receita_por_hora DESC;

-- ============================================================================
-- FIM DO SCRIPT DE QUERIES COMPLEXAS
-- ============================================================================
