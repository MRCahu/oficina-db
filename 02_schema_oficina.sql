-- ============================================================================
-- SCHEMA LÓGICO - BANCO DE DADOS PARA OFICINA DE AUTOMÓVEIS
-- Banco: oficina_db
-- Autor: Mauro Cahu
-- Data: 2025-02-18
-- Normalização: 3FN (Terceira Forma Normal)
-- ============================================================================

-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS oficina_db;
USE oficina_db;

-- ============================================================================
-- TABELA: CLIENTE
-- Descrição: Armazena informações de clientes (PF e PJ)
-- ============================================================================
CREATE TABLE cliente (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    tipo ENUM('PF', 'PJ') NOT NULL DEFAULT 'PF',
    cpf_cnpj VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_tipo (tipo),
    INDEX idx_ativo (ativo),
    INDEX idx_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: ENDERECO
-- Descrição: Armazena múltiplos endereços por cliente
-- ============================================================================
CREATE TABLE endereco (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT UNSIGNED NOT NULL,
    tipo ENUM('residencial', 'comercial') NOT NULL DEFAULT 'residencial',
    rua VARCHAR(255) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(10),
    principal TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE,
    INDEX idx_cliente_id (cliente_id),
    INDEX idx_principal (principal)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: TELEFONE
-- Descrição: Armazena múltiplos telefones por cliente
-- ============================================================================
CREATE TABLE telefone (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT UNSIGNED NOT NULL,
    tipo ENUM('celular', 'residencial', 'comercial') NOT NULL DEFAULT 'celular',
    numero VARCHAR(20) NOT NULL,
    principal TINYINT(1) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE,
    INDEX idx_cliente_id (cliente_id),
    INDEX idx_numero (numero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: VEICULO
-- Descrição: Armazena informações de veículos dos clientes
-- ============================================================================
CREATE TABLE veiculo (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT UNSIGNED NOT NULL,
    placa VARCHAR(10) UNIQUE NOT NULL,
    vin VARCHAR(20) UNIQUE,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    ano INT NOT NULL,
    cor VARCHAR(50),
    quilometragem_atual INT UNSIGNED DEFAULT 0,
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE,
    INDEX idx_cliente_id (cliente_id),
    INDEX idx_placa (placa),
    INDEX idx_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: MECANICO
-- Descrição: Armazena informações de mecânicos
-- ============================================================================
CREATE TABLE mecanico (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20),
    especialidade VARCHAR(150),
    data_admissao DATE NOT NULL,
    salario_base DECIMAL(10, 2) NOT NULL,
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_ativo (ativo),
    INDEX idx_especialidade (especialidade)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: TIPO_SERVICO
-- Descrição: Categoriza tipos de serviços oferecidos
-- ============================================================================
CREATE TABLE tipo_servico (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    valor_padrao DECIMAL(10, 2),
    tempo_estimado_horas DECIMAL(5, 2),
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_ativo (ativo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: FORNECEDOR
-- Descrição: Armazena informações de fornecedores de peças
-- ============================================================================
CREATE TABLE fornecedor (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    razao_social VARCHAR(255) NOT NULL,
    cnpj VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    endereco VARCHAR(255),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_ativo (ativo),
    INDEX idx_cnpj (cnpj)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: PECA
-- Descrição: Armazena informações de peças/materiais
-- ============================================================================
CREATE TABLE peca (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao TEXT,
    fornecedor_id INT UNSIGNED,
    preco_custo DECIMAL(10, 2) NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL,
    estoque_quantidade INT UNSIGNED NOT NULL DEFAULT 0,
    estoque_minimo INT UNSIGNED NOT NULL DEFAULT 10,
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (fornecedor_id) REFERENCES fornecedor(id) ON DELETE SET NULL,
    INDEX idx_fornecedor_id (fornecedor_id),
    INDEX idx_ativo (ativo),
    INDEX idx_estoque (estoque_quantidade)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: SERVICO
-- Descrição: Armazena informações de serviços realizados
-- ============================================================================
CREATE TABLE servico (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    veiculo_id INT UNSIGNED NOT NULL,
    tipo_servico_id INT UNSIGNED NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_conclusao DATETIME,
    status ENUM('em_andamento', 'concluido', 'cancelado') NOT NULL DEFAULT 'em_andamento',
    descricao TEXT,
    custo_mao_obra DECIMAL(10, 2) DEFAULT 0,
    custo_peca DECIMAL(10, 2) DEFAULT 0,
    custo_total DECIMAL(10, 2) GENERATED ALWAYS AS (custo_mao_obra + custo_peca) STORED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (veiculo_id) REFERENCES veiculo(id) ON DELETE CASCADE,
    FOREIGN KEY (tipo_servico_id) REFERENCES tipo_servico(id) ON DELETE RESTRICT,
    INDEX idx_veiculo_id (veiculo_id),
    INDEX idx_tipo_servico_id (tipo_servico_id),
    INDEX idx_status (status),
    INDEX idx_data_inicio (data_inicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: SERVICO_PECA
-- Descrição: Tabela de junção entre serviços e peças (M:N)
-- ============================================================================
CREATE TABLE servico_peca (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    servico_id INT UNSIGNED NOT NULL,
    peca_id INT UNSIGNED NOT NULL,
    quantidade INT UNSIGNED NOT NULL DEFAULT 1,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (quantidade * preco_unitario) STORED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (servico_id) REFERENCES servico(id) ON DELETE CASCADE,
    FOREIGN KEY (peca_id) REFERENCES peca(id) ON DELETE RESTRICT,
    INDEX idx_servico_id (servico_id),
    INDEX idx_peca_id (peca_id),
    UNIQUE KEY unique_servico_peca (servico_id, peca_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: MECANICO_SERVICO
-- Descrição: Tabela de junção entre mecânicos e serviços (M:N)
-- ============================================================================
CREATE TABLE mecanico_servico (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    mecanico_id INT UNSIGNED NOT NULL,
    servico_id INT UNSIGNED NOT NULL,
    horas_trabalhadas DECIMAL(5, 2) NOT NULL,
    valor_hora DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) GENERATED ALWAYS AS (horas_trabalhadas * valor_hora) STORED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (mecanico_id) REFERENCES mecanico(id) ON DELETE CASCADE,
    FOREIGN KEY (servico_id) REFERENCES servico(id) ON DELETE CASCADE,
    INDEX idx_mecanico_id (mecanico_id),
    INDEX idx_servico_id (servico_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: AGENDAMENTO
-- Descrição: Armazena agendamentos de serviços
-- ============================================================================
CREATE TABLE agendamento (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    veiculo_id INT UNSIGNED NOT NULL,
    mecanico_id INT UNSIGNED NOT NULL,
    data_agendamento DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fim TIME,
    status ENUM('pendente', 'confirmado', 'concluido', 'cancelado') NOT NULL DEFAULT 'pendente',
    observacoes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (veiculo_id) REFERENCES veiculo(id) ON DELETE CASCADE,
    FOREIGN KEY (mecanico_id) REFERENCES mecanico(id) ON DELETE RESTRICT,
    INDEX idx_veiculo_id (veiculo_id),
    INDEX idx_mecanico_id (mecanico_id),
    INDEX idx_data_agendamento (data_agendamento),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TABELA: PAGAMENTO
-- Descrição: Armazena informações de pagamentos
-- ============================================================================
CREATE TABLE pagamento (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    servico_id INT UNSIGNED NOT NULL,
    cliente_id INT UNSIGNED NOT NULL,
    data_pagamento DATETIME,
    valor_total DECIMAL(10, 2) NOT NULL,
    forma_pagamento ENUM('dinheiro', 'cartao', 'cheque', 'pix', 'boleto') NOT NULL DEFAULT 'dinheiro',
    status ENUM('pendente', 'pago', 'cancelado') NOT NULL DEFAULT 'pendente',
    numero_nota_fiscal VARCHAR(50),
    observacoes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (servico_id) REFERENCES servico(id) ON DELETE CASCADE,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE CASCADE,
    INDEX idx_servico_id (servico_id),
    INDEX idx_cliente_id (cliente_id),
    INDEX idx_status (status),
    INDEX idx_data_pagamento (data_pagamento),
    UNIQUE KEY unique_servico_pagamento (servico_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- FIM DO SCHEMA
-- ============================================================================
