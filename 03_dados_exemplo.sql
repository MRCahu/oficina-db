-- ============================================================================
-- DADOS DE EXEMPLO - OFICINA DE AUTOMÓVEIS
-- ============================================================================

USE oficina_db;

-- ============================================================================
-- 1. INSERIR CLIENTES
-- ============================================================================
INSERT INTO cliente (nome, tipo, cpf_cnpj, email, telefone, ativo) VALUES
('João Silva', 'PF', '12345678901', 'joao.silva@email.com', '11987654321', 1),
('Maria Santos', 'PF', '98765432101', 'maria.santos@email.com', '11987654322', 1),
('Carlos Oliveira', 'PF', '11122233344', 'carlos.oliveira@email.com', '11987654323', 1),
('Empresa A Ltda', 'PJ', '12345678901234', 'contato@empresaa.com.br', '1133334444', 1),
('Empresa B Comércio', 'PJ', '98765432101234', 'vendas@empresab.com.br', '1155556666', 1);

-- ============================================================================
-- 2. INSERIR ENDEREÇOS
-- ============================================================================
INSERT INTO endereco (cliente_id, tipo, rua, numero, complemento, bairro, cidade, estado, cep, principal) VALUES
(1, 'residencial', 'Avenida Paulista', '1000', 'Apto 1001', 'Bela Vista', 'São Paulo', 'SP', '01310100', 1),
(1, 'comercial', 'Rua Augusta', '2500', 'Sala 201', 'Consolação', 'São Paulo', 'SP', '01311200', 0),
(2, 'residencial', 'Rua do Ouvidor', '50', NULL, 'Centro', 'Rio de Janeiro', 'RJ', '20040020', 1),
(3, 'residencial', 'Avenida Getúlio Vargas', '1500', 'Apto 305', 'Centro', 'Belo Horizonte', 'MG', '30140071', 1),
(4, 'comercial', 'Rua da Aurora', '800', NULL, 'Santo Antônio', 'Recife', 'PE', '50010000', 1),
(5, 'comercial', 'Eixo Monumental', '100', 'Bloco A', 'Plano Piloto', 'Brasília', 'DF', '70040902', 1);

-- ============================================================================
-- 3. INSERIR TELEFONES
-- ============================================================================
INSERT INTO telefone (cliente_id, tipo, numero, principal) VALUES
(1, 'celular', '11987654321', 1),
(1, 'residencial', '1133334444', 0),
(2, 'celular', '11987654322', 1),
(3, 'celular', '11987654323', 1),
(4, 'comercial', '1133334444', 1),
(5, 'comercial', '1155556666', 1);

-- ============================================================================
-- 4. INSERIR VEÍCULOS
-- ============================================================================
INSERT INTO veiculo (cliente_id, placa, vin, marca, modelo, ano, cor, quilometragem_atual, ativo) VALUES
(1, 'ABC1234', '1HGBH41JXMN109186', 'Honda', 'Civic', 2020, 'Prata', 45000, 1),
(1, 'XYZ9876', '2HGBH41JXMN109187', 'Honda', 'Accord', 2019, 'Preto', 62000, 1),
(2, 'DEF5678', '3HGBH41JXMN109188', 'Toyota', 'Corolla', 2021, 'Branco', 32000, 1),
(3, 'GHI9012', '4HGBH41JXMN109189', 'Volkswagen', 'Golf', 2018, 'Azul', 78000, 1),
(4, 'JKL3456', '5HGBH41JXMN109190', 'Chevrolet', 'Onix', 2022, 'Vermelho', 15000, 1),
(5, 'MNO7890', '6HGBH41JXMN109191', 'Fiat', 'Uno', 2017, 'Cinza', 95000, 1);

-- ============================================================================
-- 5. INSERIR MECÂNICOS
-- ============================================================================
INSERT INTO mecanico (nome, cpf, email, telefone, especialidade, data_admissao, salario_base, ativo) VALUES
('João Mecânico', '11111111111', 'joao.mecanico@oficina.com', '11999999999', 'Motor e Transmissão', '2020-01-15', 3500.00, 1),
('Pedro Eletricista', '22222222222', 'pedro.eletricista@oficina.com', '11999999998', 'Elétrica', '2019-06-20', 3200.00, 1),
('Carlos Pintor', '33333333333', 'carlos.pintor@oficina.com', '11999999997', 'Pintura e Lataria', '2021-03-10', 2800.00, 1),
('Ana Diagnosticista', '44444444444', 'ana.diagnosticista@oficina.com', '11999999996', 'Diagnóstico', '2020-09-05', 3800.00, 1);

-- ============================================================================
-- 6. INSERIR TIPOS DE SERVIÇO
-- ============================================================================
INSERT INTO tipo_servico (nome, descricao, valor_padrao, tempo_estimado_horas, ativo) VALUES
('Troca de Óleo', 'Troca de óleo e filtro', 150.00, 0.5, 1),
('Revisão Completa', 'Revisão geral do veículo', 500.00, 3.0, 1),
('Reparo de Motor', 'Reparo de componentes do motor', 800.00, 8.0, 1),
('Troca de Pneus', 'Troca e balanceamento de pneus', 300.00, 1.5, 1),
('Alinhamento e Balanceamento', 'Alinhamento e balanceamento de rodas', 200.00, 1.0, 1),
('Reparo Elétrico', 'Reparo de sistema elétrico', 400.00, 4.0, 1),
('Pintura', 'Pintura de partes do veículo', 600.00, 5.0, 1),
('Troca de Bateria', 'Troca de bateria do veículo', 250.00, 0.5, 1);

-- ============================================================================
-- 7. INSERIR FORNECEDORES
-- ============================================================================
INSERT INTO fornecedor (razao_social, cnpj, email, telefone, endereco, cidade, estado, ativo) VALUES
('Fornecedor de Peças A', '11111111111111', 'contato@fornecedora.com.br', '1199999999', 'Rua A, 100', 'São Paulo', 'SP', 1),
('Fornecedor de Peças B', '22222222222222', 'vendas@fornecedorb.com.br', '1188888888', 'Rua B, 200', 'São Paulo', 'SP', 1),
('Fornecedor de Peças C', '33333333333333', 'contato@fornecedorc.com.br', '1177777777', 'Rua C, 300', 'Rio de Janeiro', 'RJ', 1);

-- ============================================================================
-- 8. INSERIR PEÇAS
-- ============================================================================
INSERT INTO peca (nome, descricao, fornecedor_id, preco_custo, preco_venda, estoque_quantidade, estoque_minimo, ativo) VALUES
('Óleo de Motor 5W30', 'Óleo mineral 5W30 1L', 1, 25.00, 45.00, 50, 10, 1),
('Filtro de Óleo', 'Filtro de óleo universal', 1, 15.00, 35.00, 30, 5, 1),
('Filtro de Ar', 'Filtro de ar do motor', 1, 20.00, 40.00, 25, 5, 1),
('Pneu Aro 15', 'Pneu 185/65 R15', 2, 150.00, 280.00, 15, 5, 1),
('Bateria 60Ah', 'Bateria automotiva 60Ah', 2, 250.00, 450.00, 8, 2, 1),
('Pastilha de Freio', 'Pastilha de freio dianteira', 3, 80.00, 150.00, 20, 5, 1),
('Disco de Freio', 'Disco de freio ventilado', 3, 120.00, 220.00, 10, 3, 1),
('Correia de Distribuição', 'Correia de distribuição', 1, 180.00, 350.00, 5, 2, 1),
('Vela de Ignição', 'Vela de ignição padrão', 2, 15.00, 35.00, 40, 10, 1),
('Amortecedor Dianteiro', 'Amortecedor dianteiro', 3, 200.00, 400.00, 6, 2, 1);

-- ============================================================================
-- 9. INSERIR SERVIÇOS
-- ============================================================================
INSERT INTO servico (veiculo_id, tipo_servico_id, data_inicio, data_conclusao, status, descricao, custo_mao_obra) VALUES
(1, 1, '2025-02-01 08:00:00', '2025-02-01 09:00:00', 'concluido', 'Troca de óleo e filtro', 150.00),
(1, 2, '2025-02-05 08:00:00', '2025-02-05 12:00:00', 'concluido', 'Revisão completa do veículo', 500.00),
(2, 3, '2025-02-08 08:00:00', '2025-02-09 17:00:00', 'concluido', 'Reparo de motor', 800.00),
(3, 4, '2025-02-10 09:00:00', '2025-02-10 11:00:00', 'concluido', 'Troca de pneus', 300.00),
(4, 5, '2025-02-12 10:00:00', '2025-02-12 12:00:00', 'concluido', 'Alinhamento e balanceamento', 200.00),
(5, 6, '2025-02-14 08:00:00', '2025-02-14 13:00:00', 'concluido', 'Reparo elétrico', 400.00),
(6, 8, '2025-02-15 09:00:00', '2025-02-15 10:00:00', 'concluido', 'Troca de bateria', 250.00),
(1, 1, '2025-02-18 08:00:00', NULL, 'em_andamento', 'Troca de óleo e filtro', 150.00);

-- ============================================================================
-- 10. INSERIR SERVIÇO_PECA
-- ============================================================================
INSERT INTO servico_peca (servico_id, peca_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 45.00),
(1, 2, 1, 35.00),
(2, 2, 1, 35.00),
(2, 3, 1, 40.00),
(3, 8, 1, 350.00),
(4, 4, 4, 280.00),
(5, 1, 1, 45.00),
(6, 9, 4, 35.00),
(7, 5, 1, 450.00),
(8, 1, 1, 45.00),
(8, 2, 1, 35.00);

-- ============================================================================
-- 11. INSERIR MECANICO_SERVICO
-- ============================================================================
INSERT INTO mecanico_servico (mecanico_id, servico_id, horas_trabalhadas, valor_hora) VALUES
(1, 1, 0.5, 100.00),
(1, 2, 3.0, 100.00),
(1, 3, 8.0, 100.00),
(2, 4, 1.5, 120.00),
(3, 5, 1.0, 90.00),
(2, 6, 4.0, 120.00),
(4, 7, 0.5, 110.00),
(1, 8, 0.5, 100.00);

-- ============================================================================
-- 12. INSERIR AGENDAMENTOS
-- ============================================================================
INSERT INTO agendamento (veiculo_id, mecanico_id, data_agendamento, hora_inicio, hora_fim, status, observacoes) VALUES
(1, 1, '2025-02-20', '08:00:00', '09:00:00', 'confirmado', 'Troca de óleo'),
(2, 1, '2025-02-21', '10:00:00', '14:00:00', 'confirmado', 'Revisão completa'),
(3, 2, '2025-02-22', '09:00:00', '11:00:00', 'pendente', 'Reparo elétrico'),
(4, 3, '2025-02-23', '14:00:00', '16:00:00', 'confirmado', 'Pintura de lateral'),
(5, 1, '2025-02-25', '08:00:00', '09:30:00', 'pendente', 'Troca de pneus'),
(6, 4, '2025-02-26', '10:00:00', '12:00:00', 'confirmado', 'Diagnóstico completo');

-- ============================================================================
-- 13. INSERIR PAGAMENTOS
-- ============================================================================
INSERT INTO pagamento (servico_id, cliente_id, data_pagamento, valor_total, forma_pagamento, status, numero_nota_fiscal) VALUES
(1, 1, '2025-02-01 09:30:00', 80.00, 'dinheiro', 'pago', 'NF001'),
(2, 1, '2025-02-05 12:30:00', 535.00, 'cartao', 'pago', 'NF002'),
(3, 1, '2025-02-09 18:00:00', 1150.00, 'pix', 'pago', 'NF003'),
(4, 2, '2025-02-10 11:30:00', 420.00, 'dinheiro', 'pago', 'NF004'),
(5, 3, '2025-02-12 12:30:00', 200.00, 'cartao', 'pago', 'NF005'),
(6, 4, '2025-02-14 13:30:00', 460.00, 'boleto', 'pago', 'NF006'),
(7, 5, '2025-02-15 10:30:00', 450.00, 'pix', 'pago', 'NF007'),
(8, 1, NULL, 80.00, 'dinheiro', 'pendente', NULL);

-- ============================================================================
-- FIM DO SCRIPT DE DADOS
-- ============================================================================
