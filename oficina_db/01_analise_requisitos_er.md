# Análise de Requisitos e Esquema Conceitual – Oficina de Automóveis

## 1. Visão Geral do Projeto

Este projeto visa modelar um banco de dados para uma **oficina de automóveis multiserviços**, capaz de gerenciar clientes, veículos, serviços, peças, agendamentos, pagamentos e histórico de manutenção. O sistema deve permitir rastreamento completo de todas as operações, desde o atendimento inicial até a conclusão do serviço.

---

## 2. Requisitos Funcionais

### 2.1 Gestão de Clientes
- Cadastrar clientes (PF e PJ)
- Armazenar múltiplos endereços e telefones
- Manter histórico de contato e preferências
- Rastrear clientes inativos

### 2.2 Gestão de Veículos
- Cadastrar veículos associados a clientes
- Armazenar dados técnicos (marca, modelo, ano, placa, VIN)
- Manter histórico de serviços por veículo
- Rastrear manutenções preventivas

### 2.3 Gestão de Serviços
- Cadastrar tipos de serviços (manutenção, reparo, revisão)
- Associar serviços a veículos
- Registrar tempo gasto e mão de obra
- Calcular custos de serviços

### 2.4 Gestão de Peças/Materiais
- Cadastrar peças utilizadas
- Controlar estoque
- Rastrear fornecedores
- Calcular custos de peças

### 2.5 Agendamentos
- Agendar serviços
- Gerenciar disponibilidade de mecânicos
- Rastrear status de agendamentos (pendente, confirmado, concluído, cancelado)

### 2.6 Pagamentos
- Registrar múltiplas formas de pagamento
- Rastrear status de pagamentos
- Gerar faturas

### 2.7 Relatórios e Análises
- Receita por período
- Serviços mais realizados
- Clientes mais frequentes
- Desempenho de mecânicos
- Histórico de manutenção por veículo

---

## 3. Entidades Principais (Esquema Conceitual)

### 3.1 Entidade: CLIENTE

**Descrição**: Representa uma pessoa física ou jurídica que utiliza os serviços da oficina.

**Atributos**:
- ID (PK)
- Nome/Razão Social
- CPF/CNPJ
- Email
- Telefone
- Tipo (PF/PJ)
- Data de Cadastro
- Ativo (Sim/Não)

**Relacionamentos**:
- 1:N com VEICULO (um cliente pode ter múltiplos veículos)
- 1:N com ENDERECO (um cliente pode ter múltiplos endereços)
- 1:N com TELEFONE (um cliente pode ter múltiplos telefones)

---

### 3.2 Entidade: VEICULO

**Descrição**: Representa um veículo que recebe serviços na oficina.

**Atributos**:
- ID (PK)
- Cliente_ID (FK)
- Placa (UNIQUE)
- VIN (UNIQUE)
- Marca
- Modelo
- Ano
- Cor
- Quilometragem Atual
- Data de Cadastro

**Relacionamentos**:
- N:1 com CLIENTE
- 1:N com SERVICO (um veículo pode ter múltiplos serviços)
- 1:N com AGENDAMENTO (um veículo pode ter múltiplos agendamentos)

---

### 3.3 Entidade: SERVICO

**Descrição**: Representa um serviço realizado em um veículo.

**Atributos**:
- ID (PK)
- Veiculo_ID (FK)
- Tipo_Servico_ID (FK)
- Data_Inicio
- Data_Conclusao
- Status (em andamento, concluído, cancelado)
- Descricao
- Custo_Mao_Obra
- Custo_Total

**Relacionamentos**:
- N:1 com VEICULO
- N:1 com TIPO_SERVICO
- 1:N com SERVICO_PECA (um serviço pode usar múltiplas peças)
- 1:N com MECANICO_SERVICO (múltiplos mecânicos podem trabalhar em um serviço)
- 1:1 com PAGAMENTO

---

### 3.4 Entidade: TIPO_SERVICO

**Descrição**: Categoriza os tipos de serviços oferecidos pela oficina.

**Atributos**:
- ID (PK)
- Nome (ex: Troca de Óleo, Revisão, Reparo de Motor)
- Descricao
- Valor_Padrao
- Tempo_Estimado_Horas
- Ativo

**Relacionamentos**:
- 1:N com SERVICO

---

### 3.5 Entidade: PECA

**Descrição**: Representa peças/materiais utilizados nos serviços.

**Atributos**:
- ID (PK)
- Nome
- Descricao
- Fornecedor_ID (FK)
- Preco_Custo
- Preco_Venda
- Estoque_Quantidade
- Estoque_Minimo
- Ativo

**Relacionamentos**:
- N:1 com FORNECEDOR
- 1:N com SERVICO_PECA (uma peça pode ser usada em múltiplos serviços)

---

### 3.6 Entidade: SERVICO_PECA

**Descrição**: Tabela de junção que associa peças aos serviços.

**Atributos**:
- ID (PK)
- Servico_ID (FK)
- Peca_ID (FK)
- Quantidade
- Preco_Unitario
- Subtotal

**Relacionamentos**:
- N:1 com SERVICO
- N:1 com PECA

---

### 3.7 Entidade: MECANICO

**Descrição**: Representa um mecânico que trabalha na oficina.

**Atributos**:
- ID (PK)
- Nome
- CPF
- Email
- Telefone
- Especialidade
- Data_Admissao
- Salario_Base
- Ativo

**Relacionamentos**:
- 1:N com MECANICO_SERVICO (um mecânico pode trabalhar em múltiplos serviços)
- 1:N com AGENDAMENTO (um mecânico pode ter múltiplos agendamentos)

---

### 3.8 Entidade: MECANICO_SERVICO

**Descrição**: Tabela de junção que associa mecânicos aos serviços.

**Atributos**:
- ID (PK)
- Mecanico_ID (FK)
- Servico_ID (FK)
- Horas_Trabalhadas
- Valor_Hora
- Subtotal

**Relacionamentos**:
- N:1 com MECANICO
- N:1 com SERVICO

---

### 3.9 Entidade: AGENDAMENTO

**Descrição**: Representa um agendamento de serviço.

**Atributos**:
- ID (PK)
- Veiculo_ID (FK)
- Mecanico_ID (FK)
- Data_Agendamento
- Hora_Inicio
- Hora_Fim
- Status (pendente, confirmado, concluído, cancelado)
- Observacoes

**Relacionamentos**:
- N:1 com VEICULO
- N:1 com MECANICO

---

### 3.10 Entidade: PAGAMENTO

**Descrição**: Representa o pagamento de um serviço.

**Atributos**:
- ID (PK)
- Servico_ID (FK)
- Cliente_ID (FK)
- Data_Pagamento
- Valor_Total
- Forma_Pagamento (dinheiro, cartão, cheque, PIX)
- Status (pendente, pago, cancelado)
- Numero_Nota_Fiscal

**Relacionamentos**:
- 1:1 com SERVICO
- N:1 com CLIENTE

---

### 3.11 Entidade: FORNECEDOR

**Descrição**: Representa fornecedores de peças.

**Atributos**:
- ID (PK)
- Razao_Social
- CNPJ
- Email
- Telefone
- Endereco
- Ativo

**Relacionamentos**:
- 1:N com PECA

---

### 3.12 Entidade: ENDERECO

**Descrição**: Armazena endereços de clientes.

**Atributos**:
- ID (PK)
- Cliente_ID (FK)
- Tipo (residencial, comercial)
- Rua
- Numero
- Complemento
- Bairro
- Cidade
- Estado
- CEP
- Principal (Sim/Não)

**Relacionamentos**:
- N:1 com CLIENTE

---

### 3.13 Entidade: TELEFONE

**Descrição**: Armazena telefones de clientes.

**Atributos**:
- ID (PK)
- Cliente_ID (FK)
- Tipo (celular, residencial, comercial)
- Numero
- Principal (Sim/Não)

**Relacionamentos**:
- N:1 com CLIENTE

---

## 4. Diagrama ER Textual

```
CLIENTE
├── 1:N → VEICULO
├── 1:N → ENDERECO
├── 1:N → TELEFONE
└── 1:N → PAGAMENTO

VEICULO
├── N:1 ← CLIENTE
├── 1:N → SERVICO
└── 1:N → AGENDAMENTO

SERVICO
├── N:1 ← VEICULO
├── N:1 ← TIPO_SERVICO
├── 1:N → SERVICO_PECA
├── 1:N → MECANICO_SERVICO
└── 1:1 → PAGAMENTO

TIPO_SERVICO
└── 1:N → SERVICO

PECA
├── N:1 ← FORNECEDOR
└── 1:N → SERVICO_PECA

SERVICO_PECA
├── N:1 ← SERVICO
└── N:1 ← PECA

MECANICO
├── 1:N → MECANICO_SERVICO
└── 1:N → AGENDAMENTO

MECANICO_SERVICO
├── N:1 ← MECANICO
└── N:1 ← SERVICO

AGENDAMENTO
├── N:1 ← VEICULO
└── N:1 ← MECANICO

PAGAMENTO
├── 1:1 ← SERVICO
└── N:1 ← CLIENTE

FORNECEDOR
└── 1:N → PECA

ENDERECO
└── N:1 ← CLIENTE

TELEFONE
└── N:1 ← CLIENTE
```

---

## 5. Requisitos Não-Funcionais

- **Normalização**: Aplicar 3FN (Terceira Forma Normal)
- **Integridade Referencial**: Usar chaves estrangeiras
- **Constraints**: Validações de dados (NOT NULL, UNIQUE, CHECK)
- **Índices**: Criar índices em FK, UNIQUE e campos de busca
- **Rastreabilidade**: Campos `created_at` e `updated_at` em tabelas principais
- **Soft Delete**: Campo `ativo` para preservar histórico
- **Performance**: Otimizar queries com índices apropriados

---

## 6. Próximas Etapas

1. Transformar este esquema conceitual em esquema lógico (relacional)
2. Criar scripts SQL para criação das tabelas
3. Inserir dados de exemplo
4. Desenvolver queries complexas para análises
5. Documentar o dicionário de dados
6. Preparar para GitHub

---

**Fim da Análise de Requisitos**
