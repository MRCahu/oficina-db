# Projeto de Banco de Dados para Oficina de Automóveis (MySQL)

Este repositório contém um projeto lógico completo de um banco de dados para uma **oficina de automóveis multiserviços**, desenvolvido em MySQL. O modelo foi projetado para ser robusto, escalável e normalizado (3FN), seguindo as melhores práticas de modelagem relacional.

## 1. Visão Geral do Modelo

O banco de dados suporta as principais funcionalidades de uma oficina moderna, incluindo:

- **Gestão de Clientes e Veículos**: Cadastro completo de clientes (PF/PJ), seus veículos e histórico.
- **Ordem de Serviço (OS)**: Controle de serviços, desde a abertura até a conclusão.
- **Gestão de Peças e Estoque**: Cadastro de peças, controle de estoque mínimo e associação com fornecedores.
- **Mão de Obra**: Rastreamento de mecânicos por serviço e horas trabalhadas.
- **Agendamentos**: Sistema para marcar serviços futuros.
- **Faturamento**: Geração de pagamentos e controle de status.
- **Relatórios Gerenciais**: Queries prontas para análise de desempenho, receita e eficiência.

## 2. Estrutura do Projeto

O projeto está organizado nos seguintes arquivos para garantir clareza e manutenibilidade:

```
/oficina-db
├── README.md                               # Documentação principal (este arquivo)
├── 01_analise_requisitos_er.md             # Análise de requisitos e esquema conceitual
├── 02_schema_oficina.sql                   # Script de criação de todas as 13 tabelas
├── 03_dados_exemplo.sql                    # Script para popular o banco com dados para teste
├── 04_queries_complexas.sql                # 20+ exemplos de queries complexas para análise
├── dicionario_dados.md                     # Documentação detalhada de cada tabela e coluna
├── diagrama_er.txt                         # Diagrama Entidade-Relacionamento em formato textual
```

## 3. Como Utilizar

Siga os passos abaixo para recriar e popular o banco de dados em seu ambiente MySQL local.

### Passo 1: Criação do Schema

Execute o primeiro script para criar o banco de dados e todas as tabelas, chaves e constraints.

```bash
# Exemplo de execução via linha de comando
mysql -u seu_usuario -p < 02_schema_oficina.sql
```

### Passo 2: Inserção de Dados de Exemplo

Após a criação da estrutura, execute o segundo script para popular as tabelas com dados realistas. Isso permitirá testar as consultas e entender o funcionamento do modelo.

```bash
# Exemplo de execução via linha de comando
mysql -u seu_usuario -p oficina_db < 03_dados_exemplo.sql
```

### Passo 3: Explorando as Consultas

O arquivo `04_queries_complexas.sql` contém mais de 20 exemplos de consultas prontas para uso. Você pode executá-las em seu cliente MySQL preferido (DBeaver, MySQL Workbench, etc.) para explorar os dados e responder a perguntas de negócio.

## 4. Documentação

- **Dicionário de Dados**: Para entender o propósito de cada tabela e coluna, consulte o arquivo `dicionario_dados.md`.
- **Diagrama ER**: Para uma visão geral dos relacionamentos, veja o `diagrama_er.txt`.
- **Análise de Requisitos**: Para compreender as escolhas técnicas por trás do modelo, leia o `01_analise_requisitos_er.md`.

## 5. Frameworks e Boas Práticas Aplicadas

Este projeto foi construído com base em frameworks consolidados no mercado de dados:

- **Fundação Estrutural (Thomas Nield)**: O modelo foi projetado com foco em normalização (3FN) para garantir consistência, evitar redundância e otimizar a manutenção dos dados.
- **Observabilidade (Barr Moses)**: As tabelas incluem campos como `created_at` e `updated_at` para garantir a rastreabilidade e o frescor (freshness) dos dados. As constraints (`CHECK`, `UNIQUE`) garantem a qualidade e o schema.
- **Análise de Negócio (Cathy Tanimura)**: O arquivo `04_queries_complexas.sql` transforma dados brutos em insights de negócio, com exemplos de análise de receita, desempenho de mecânicos e histórico de manutenção.
- **Storytelling com Dados (Cole Knaflic)**: A estrutura do projeto e a clareza da documentação foram pensadas para facilitar a comunicação e o entendimento do modelo, focando na "Grande Ideia" de cada artefato.

Este projeto serve como uma base sólida e um recurso de aprendizado para qualquer pessoa que deseje construir ou entender a arquitetura de dados de um sistema de oficina.
