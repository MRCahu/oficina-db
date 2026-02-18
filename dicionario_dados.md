# Dicionário de Dados – Oficina DB

Este documento detalha a estrutura de cada tabela no banco de dados `oficina_db`, incluindo descrições de colunas, tipos de dados, chaves e outras restrições.

---

## Tabela: `cliente`

**Descrição**: Armazena informações de clientes (PF e PJ).

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do cliente. |
| `nome` | `VARCHAR(150)` | Não | | | Nome completo ou razão social do cliente. |
| `tipo` | `ENUM("PF", "PJ")` | Não | | `PF` | Tipo de cliente (Pessoa Física ou Jurídica). |
| `cpf_cnpj` | `VARCHAR(20)` | Sim | UNIQUE | `NULL` | CPF ou CNPJ do cliente (sem formatação). |
| `email` | `VARCHAR(100)` | Sim | UNIQUE | `NULL` | Endereço de e-mail do cliente. |
| `telefone` | `VARCHAR(20)` | Sim | | `NULL` | Número de telefone principal do cliente. |
| `ativo` | `TINYINT(1)` | Não | | `1` | Status do cliente (1 = Ativo, 0 = Inativo/Soft Delete). |
| `data_cadastro` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data e hora do cadastro do cliente. |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

## Tabela: `endereco`

**Descrição**: Armazena múltiplos endereços por cliente.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do endereço. |
| `cliente_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `cliente(id)`. |
| `tipo` | `ENUM(...)` | Não | | `residencial` | Tipo de endereço (`residencial`, `comercial`). |
| `rua` | `VARCHAR(255)` | Não | | | Nome da rua. |
| `numero` | `VARCHAR(20)` | Não | | | Número do endereço. |
| `complemento` | `VARCHAR(255)` | Sim | | `NULL` | Complemento do endereço. |
| `bairro` | `VARCHAR(100)` | Sim | | `NULL` | Bairro do endereço. |
| `cidade` | `VARCHAR(100)` | Não | | | Cidade do endereço. |
| `estado` | `VARCHAR(2)` | Não | | | Estado do endereço (UF). |
| `cep` | `VARCHAR(10)` | Sim | | `NULL` | Código de Endereçamento Postal. |
| `principal` | `TINYINT(1)` | Sim | | `0` | Indica se é o endereço principal do cliente. |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

## Tabela: `telefone`

**Descrição**: Armazena múltiplos telefones por cliente.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do telefone. |
| `cliente_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `cliente(id)`. |
| `tipo` | `ENUM(...)` | Não | | `celular` | Tipo de telefone (`celular`, `residencial`, `comercial`). |
| `numero` | `VARCHAR(20)` | Não | | | Número do telefone. |
| `principal` | `TINYINT(1)` | Sim | | `0` | Indica se é o telefone principal do cliente. |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |

---

## Tabela: `veiculo`

**Descrição**: Armazena informações de veículos dos clientes.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do veículo. |
| `cliente_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `cliente(id)`. |
| `placa` | `VARCHAR(10)` | Não | UNIQUE | | Placa do veículo. |
| `vin` | `VARCHAR(20)` | Sim | UNIQUE | `NULL` | Número de Identificação do Veículo (Chassi). |
| `marca` | `VARCHAR(50)` | Não | | | Marca do veículo. |
| `modelo` | `VARCHAR(100)` | Não | | | Modelo do veículo. |
| `ano` | `INT` | Não | | | Ano de fabricação do veículo. |
| `cor` | `VARCHAR(50)` | Sim | | `NULL` | Cor do veículo. |
| `quilometragem_atual` | `INT UNSIGNED` | Sim | | `0` | Quilometragem atual do veículo. |
| `data_cadastro` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data e hora do cadastro do veículo. |
| `ativo` | `TINYINT(1)` | Não | | `1` | Status do veículo (1 = Ativo, 0 = Inativo). |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

## Tabela: `mecanico`

**Descrição**: Armazena informações de mecânicos.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do mecânico. |
| `nome` | `VARCHAR(150)` | Não | | | Nome completo do mecânico. |
| `cpf` | `VARCHAR(11)` | Não | UNIQUE | | CPF do mecânico (sem formatação). |
| `email` | `VARCHAR(100)` | Sim | UNIQUE | `NULL` | Endereço de e-mail do mecânico. |
| `telefone` | `VARCHAR(20)` | Sim | | `NULL` | Número de telefone do mecânico. |
| `especialidade` | `VARCHAR(150)` | Sim | | `NULL` | Especialidade do mecânico. |
| `data_admissao` | `DATE` | Não | | | Data de admissão do mecânico. |
| `salario_base` | `DECIMAL(10,2)` | Não | | | Salário base do mecânico. |
| `ativo` | `TINYINT(1)` | Não | | `1` | Status do mecânico (1 = Ativo, 0 = Inativo). |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

## Tabela: `tipo_servico`

**Descrição**: Categoriza tipos de serviços oferecidos.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do tipo de serviço. |
| `nome` | `VARCHAR(100)` | Não | UNIQUE | | Nome do tipo de serviço. |
| `descricao` | `TEXT` | Sim | | `NULL` | Descrição do tipo de serviço. |
| `valor_padrao` | `DECIMAL(10,2)` | Sim | | `NULL` | Valor padrão do serviço. |
| `tempo_estimado_horas` | `DECIMAL(5,2)` | Sim | | `NULL` | Tempo estimado para realizar o serviço. |
| `ativo` | `TINYINT(1)` | Não | | `1` | Status do tipo de serviço (1 = Ativo, 0 = Inativo). |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

## Tabela: `fornecedor`

**Descrição**: Armazena informações de fornecedores de peças.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do fornecedor. |
| `razao_social` | `VARCHAR(255)` | Não | | | Razão social do fornecedor. |
| `cnpj` | `VARCHAR(14)` | Não | UNIQUE | | CNPJ do fornecedor (sem formatação). |
| `email` | `VARCHAR(100)` | Sim | | `NULL` | E-mail de contato do fornecedor. |
| `telefone` | `VARCHAR(20)` | Sim | | `NULL` | Telefone de contato do fornecedor. |
| `endereco` | `VARCHAR(255)` | Sim | | `NULL` | Endereço do fornecedor. |
| `cidade` | `VARCHAR(100)` | Sim | | `NULL` | Cidade do fornecedor. |
| `estado` | `VARCHAR(2)` | Sim | | `NULL` | Estado do fornecedor (UF). |
| `ativo` | `TINYINT(1)` | Não | | `1` | Status do fornecedor (1 = Ativo, 0 = Inativo). |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

## Tabela: `peca`

**Descrição**: Armazena informações de peças/materiais.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único da peça. |
| `nome` | `VARCHAR(150)` | Não | | | Nome da peça. |
| `descricao` | `TEXT` | Sim | | `NULL` | Descrição da peça. |
| `fornecedor_id` | `INT UNSIGNED` | Sim | FK | `NULL` | Chave estrangeira que referencia `fornecedor(id)`. |
| `preco_custo` | `DECIMAL(10,2)` | Não | | | Preço de custo da peça. |
| `preco_venda` | `DECIMAL(10,2)` | Não | | | Preço de venda da peça. |
| `estoque_quantidade` | `INT UNSIGNED` | Não | | `0` | Quantidade em estoque. |
| `estoque_minimo` | `INT UNSIGNED` | Não | | `10` | Quantidade mínima em estoque para alerta. |
| `ativo` | `TINYINT(1)` | Não | | `1` | Status da peça (1 = Ativa, 0 = Inativa). |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

## Tabela: `servico`

**Descrição**: Armazena informações de serviços realizados.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do serviço. |
| `veiculo_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `veiculo(id)`. |
| `tipo_servico_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `tipo_servico(id)`. |
| `data_inicio` | `DATETIME` | Não | | | Data e hora de início do serviço. |
| `data_conclusao` | `DATETIME` | Sim | | `NULL` | Data e hora de conclusão do serviço. |
| `status` | `ENUM(...)` | Não | | `em_andamento` | Status do serviço (`em_andamento`, `concluido`, `cancelado`). |
| `descricao` | `TEXT` | Sim | | `NULL` | Descrição do serviço. |
| `custo_mao_obra` | `DECIMAL(10,2)` | Sim | | `0` | Custo da mão de obra. |
| `custo_peca` | `DECIMAL(10,2)` | Sim | | `0` | Custo das peças. |
| `custo_total` | `DECIMAL(10,2)` | Sim | `GENERATED` | | Custo total (mão de obra + peças). |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

## Tabela: `servico_peca`

**Descrição**: Tabela de junção entre serviços e peças (M:N).

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único da associação. |
| `servico_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `servico(id)`. |
| `peca_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `peca(id)`. |
| `quantidade` | `INT UNSIGNED` | Não | | `1` | Quantidade de peças utilizadas. |
| `preco_unitario` | `DECIMAL(10,2)` | Não | | | Preço unitário da peça no momento do serviço. |
| `subtotal` | `DECIMAL(10,2)` | Sim | `GENERATED` | | Subtotal (quantidade * preço unitário). |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |

---

## Tabela: `mecanico_servico`

**Descrição**: Tabela de junção entre mecânicos e serviços (M:N).

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único da associação. |
| `mecanico_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `mecanico(id)`. |
| `servico_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `servico(id)`. |
| `horas_trabalhadas` | `DECIMAL(5,2)` | Não | | | Horas trabalhadas pelo mecânico no serviço. |
| `valor_hora` | `DECIMAL(10,2)` | Não | | | Valor da hora do mecânico no momento do serviço. |
| `subtotal` | `DECIMAL(10,2)` | Sim | `GENERATED` | | Subtotal (horas trabalhadas * valor hora). |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |

---

## Tabela: `agendamento`

**Descrição**: Armazena agendamentos de serviços.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do agendamento. |
| `veiculo_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `veiculo(id)`. |
| `mecanico_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `mecanico(id)`. |
| `data_agendamento` | `DATE` | Não | | | Data do agendamento. |
| `hora_inicio` | `TIME` | Não | | | Hora de início do agendamento. |
| `hora_fim` | `TIME` | Sim | | `NULL` | Hora de fim do agendamento. |
| `status` | `ENUM(...)` | Não | | `pendente` | Status do agendamento (`pendente`, `confirmado`, `concluido`, `cancelado`). |
| `observacoes` | `TEXT` | Sim | | `NULL` | Observações sobre o agendamento. |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

## Tabela: `pagamento`

**Descrição**: Armazena informações de pagamentos.

| Coluna | Tipo de Dado | Nulo? | Chave | Padrão | Descrição |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `id` | `INT UNSIGNED` | Não | PK | `AUTO_INCREMENT` | Identificador único do pagamento. |
| `servico_id` | `INT UNSIGNED` | Não | FK, UNIQUE | | Chave estrangeira que referencia `servico(id)`. |
| `cliente_id` | `INT UNSIGNED` | Não | FK | | Chave estrangeira que referencia `cliente(id)`. |
| `data_pagamento` | `DATETIME` | Sim | | `NULL` | Data e hora do pagamento. |
| `valor_total` | `DECIMAL(10,2)` | Não | | | Valor total do pagamento. |
| `forma_pagamento` | `ENUM(...)` | Não | | `dinheiro` | Forma de pagamento (`dinheiro`, `cartao`, `cheque`, `pix`, `boleto`). |
| `status` | `ENUM(...)` | Não | | `pendente` | Status do pagamento (`pendente`, `pago`, `cancelado`). |
| `numero_nota_fiscal` | `VARCHAR(50)` | Sim | | `NULL` | Número da nota fiscal. |
| `observacoes` | `TEXT` | Sim | | `NULL` | Observações sobre o pagamento. |
| `created_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data de criação do registro. |
| `updated_at` | `DATETIME` | Sim | | `CURRENT_TIMESTAMP` | Data da última atualização do registro. |

---

**Fim do Dicionário de Dados**
