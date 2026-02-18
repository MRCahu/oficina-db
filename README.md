# 🚗 Projeto de Banco de Dados para Oficina de Automóveis (MySQL)

<p align="center">
  <img src="https://img.shields.io/badge/MySQL-8.0%2B-blue?logo=mysql&logoColor=white" alt="MySQL 8.0+"/>
  <img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT"/>
  <img src="https://img.shields.io/badge/Status-Completo-brightgreen" alt="Status: Completo"/>
  <img src="https://img.shields.io/badge/Queries-20%2B-blueviolet" alt="Queries: 20+"/>
</p>

Este repositório contém um projeto lógico completo de um banco de dados para uma **oficina de automóveis multiserviços**, desenvolvido em MySQL. O modelo foi projetado para ser robusto, escalável e normalizado (3FN), seguindo as melhores práticas de modelagem relacional para um sistema de gestão de oficina (Workshop Management System).

---

## ✨ Funcionalidades Principais

O modelo de dados suporta um ecossistema completo para a gestão de uma oficina moderna, cobrindo desde o relacionamento com o cliente até a análise de performance do negócio.

| Módulo | Funcionalidades Cobertas |
| :--- | :--- |
| 👥 **Gestão de Clientes** | Cadastro detalhado de clientes (PF/PJ), múltiplos endereços e contatos. |
| 🚗 **Gestão de Veículos** | Registro de veículos por cliente, com informações de placa, chassi, marca, modelo e ano. |
| 📋 **Ordens de Serviço (OS)** | Controle completo de serviços, desde a abertura, diagnóstico, execução até a conclusão e faturamento. |
| 📦 **Peças e Estoque** | Cadastro de peças, associação com fornecedores, controle de estoque mínimo e custo/preço de venda. |
| 🛠️ **Mão de Obra** | Rastreamento de mecânicos por serviço, horas trabalhadas e especialidades. |
| 🗓️ **Agendamentos** | Sistema para marcar serviços futuros, associando cliente, veículo e mecânico. |
| 💰 **Faturamento** | Geração de pagamentos por serviço, controle de status (pago, pendente) e formas de pagamento. |
| 📊 **Relatórios Gerenciais** | Queries prontas para análise de receita, desempenho de mecânicos, histórico de manutenção e mais. |

---

## 🚀 Como Utilizar (3 Passos)

Siga os passos abaixo para recriar e popular o banco de dados em seu ambiente MySQL local.

### 1. Criar o Schema

Execute o primeiro script para criar o banco de dados e todas as 13 tabelas, com suas chaves e constraints.

```bash
# Exemplo de execução via linha de comando
mysql -u seu_usuario -p < 02_schema_oficina.sql
```

### 2. Inserir Dados de Exemplo

Após a criação da estrutura, execute o segundo script para popular as tabelas com dados realistas. Isso permitirá testar as consultas e entender o funcionamento do modelo.

```bash
# Exemplo de execução via linha de comando
mysql -u seu_usuario -p oficina_db < 03_dados_exemplo.sql
```

### 3. Explorar as Consultas

O arquivo `04_queries_complexas.sql` contém mais de 20 exemplos de consultas prontas para uso. Execute-as em seu cliente MySQL preferido (DBeaver, MySQL Workbench, etc.) para explorar os dados e responder a perguntas de negócio.

---

## 🏗️ Estrutura do Banco de Dados

O esquema é composto por 13 tabelas normalizadas (3FN) que se interligam para formar o sistema de gestão.

| Tabela | Propósito |
| :--- | :--- |
| `cliente` | Armazena os dados dos clientes (PF e PJ). |
| `endereco` | Múltiplos endereços por cliente. |
| `telefone` | Múltiplos telefones por cliente. |
| `veiculo` | Veículos pertencentes aos clientes. |
| `mecanico` | Dados dos mecânicos da oficina. |
| `tipo_servico` | Catálogo de serviços oferecidos. |
| `fornecedor` | Fornecedores de peças e materiais. |
| `peca` | Peças e materiais com controle de estoque. |
| `servico` | Registra cada ordem de serviço realizada. |
| `servico_peca` | Tabela de junção para peças usadas em um serviço (N:M). |
| `mecanico_servico` | Tabela de junção para mecânicos que trabalharam em um serviço (N:M). |
| `agendamento` | Agendamentos futuros de serviços. |
| `pagamento` | Registros de faturamento e pagamentos dos serviços. |

---

## 📚 Documentação e Arquivos

O projeto está organizado para garantir clareza e manutenibilidade.

| Arquivo | Descrição |
| :--- | :--- |
| `README.md` | Documentação principal do projeto (este arquivo). |
| `01_analise_requisitos_er.md` | Análise de requisitos e o esquema conceitual (ER). |
| `02_schema_oficina.sql` | Script de criação de todas as 13 tabelas. |
| `03_dados_exemplo.sql` | Script para popular o banco com dados para teste. |
| `04_queries_complexas.sql` | 20+ exemplos de queries complexas para análise. |
| `dicionario_dados.md` | Documentação detalhada de cada tabela e coluna. |
| `diagrama_er.txt` | Diagrama Entidade-Relacionamento em formato textual. |

---

## 🧠 Frameworks e Boas Práticas

Este projeto foi construído com base em frameworks consolidados no mercado de dados para garantir um design robusto e profissional.

| Framework | Aplicação no Projeto |
| :--- | :--- |
| **Fundação Estrutural (T. Nield)** | O modelo foi projetado com foco em **normalização (3FN)** para garantir consistência, evitar redundância e otimizar a manutenção dos dados. |
| **Observabilidade (B. Moses)** | As tabelas incluem campos como `created_at` e `updated_at` para garantir a **rastreabilidade** e o frescor (freshness) dos dados. Constraints (`CHECK`, `UNIQUE`) garantem a qualidade e o schema. |
| **Análise de Negócio (C. Tanimura)** | O arquivo `04_queries_complexas.sql` transforma dados brutos em **insights de negócio**, com exemplos de análise de receita, desempenho de mecânicos e histórico de manutenção. |
| **Storytelling com Dados (C. Knaflic)** | A estrutura do projeto e a clareza da documentação foram pensadas para facilitar a **comunicação** e o entendimento do modelo, focando na "Grande Ideia" de cada artefato. |

---

## 💡 Próximas Etapas e Melhorias

Este projeto serve como uma base sólida. Possíveis evoluções incluem:

- **Adicionar Views SQL**: Para simplificar consultas recorrentes e relatórios.
- **Criar Stored Procedures**: Para encapsular lógicas de negócio complexas (ex: `criar_nova_os`).
- **Implementar Triggers**: Para automação e auditoria (ex: `atualizar_estoque_ao_usar_peca`).
- **Expandir o Modelo**: Adicionar tabelas para `garantia`, `feedback_cliente` ou `historico_precos`.

---

<p align="center">
  <em>Este projeto foi gerado e estruturado pela IA Manus, com foco em boas práticas, clareza e profissionalismo para acelerar o desenvolvimento e o aprendizado em modelagem de dados.</em>
</p>
