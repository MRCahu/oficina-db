# Instruções para GitHub – Oficina DB

## 1. Preparação do Repositório

### 1.1 Criar um novo repositório no GitHub

1. Acesse [GitHub](https://github.com) e faça login em sua conta.
2. Clique em **"New"** para criar um novo repositório.
3. Preencha os campos:
   - **Repository name**: `oficina-db`
   - **Description**: "Projeto lógico de banco de dados MySQL para oficina de automóveis multiserviços com gestão de clientes, veículos, serviços, peças, mecânicos e agendamentos."
   - **Visibility**: Público (para avaliação)
   - **Initialize this repository with**: Deixe desmarcado (vamos fazer isso localmente)
4. Clique em **"Create repository"**.

### 1.2 Clonar o repositório localmente

```bash
# Clonar o repositório
git clone https://github.com/seu_usuario/oficina-db.git
cd oficina-db
```

### 1.3 Adicionar os arquivos do projeto

```bash
# Copiar todos os arquivos para o diretório do repositório
cp -r /home/ubuntu/oficina_db/* .

# Verificar os arquivos
ls -la
```

## 2. Configuração do Git

### 2.1 Configurar identidade (primeira vez)

```bash
git config --global user.name "Seu Nome"
git config --global user.email "seu_email@example.com"
```

### 2.2 Inicializar o repositório local

```bash
# Inicializar Git (se não foi feito automaticamente)
git init

# Adicionar todos os arquivos
git add .

# Criar commit inicial
git commit -m "Projeto inicial: Oficina DB com 13 tabelas, 20+ queries complexas e documentação completa"

# Renomear branch para 'main' (se necessário)
git branch -M main

# Adicionar o repositório remoto
git remote add origin https://github.com/seu_usuario/oficina-db.git

# Fazer push para o GitHub
git push -u origin main
```

## 3. Estrutura de Pastas Recomendada

```
oficina-db/
├── README.md                               # Documentação principal
├── LICENSE                                 # Licença MIT
├── .gitignore                              # Arquivos a ignorar
├── GITHUB_SETUP.md                         # Este arquivo
│
├── 01_analise_requisitos_er.md             # Análise de requisitos
├── 02_schema_oficina.sql                   # Schema do banco
├── 03_dados_exemplo.sql                    # Dados de exemplo
├── 04_queries_complexas.sql                # Queries complexas
│
├── dicionario_dados.md                     # Dicionário de dados
├── diagrama_er.txt                         # Diagrama ER
```

## 4. Commits Recomendados

Após adicionar os arquivos, você pode fazer commits mais específicos:

```bash
# Commit 1: Documentação e análise
git add README.md 01_analise_requisitos_er.md
git commit -m "docs: adicionar análise de requisitos e documentação principal"

# Commit 2: Schema e dados
git add 02_schema_oficina.sql 03_dados_exemplo.sql
git commit -m "feat: adicionar schema com 13 tabelas normalizadas e dados de exemplo"

# Commit 3: Queries
git add 04_queries_complexas.sql
git commit -m "feat: adicionar 20+ queries complexas com SELECT, WHERE, derivados, ORDER BY, HAVING, JOINs"

# Commit 4: Documentação técnica
git add dicionario_dados.md diagrama_er.txt
git commit -m "docs: adicionar dicionário de dados e diagrama ER"

# Fazer push de todos os commits
git push origin main
```

## 5. Adicionar Topics ao Repositório

No GitHub, adicione topics para melhor categorização:

- `mysql`
- `database`
- `oficina`
- `sql`
- `database-design`
- `er-model`
- `normalization`
- `data-modeling`
- `automotive`

## 6. Criar um README Atrativo

O arquivo `README.md` já está bem estruturado. Certifique-se de que inclua:

✅ Visão geral do projeto  
✅ Estrutura do banco de dados  
✅ Como usar (3 passos)  
✅ Documentação  
✅ Frameworks aplicados  

## 7. Adicionar Badge de Status (Opcional)

Você pode adicionar badges ao README para melhorar a apresentação:

```markdown
![License](https://img.shields.io/badge/license-MIT-blue.svg)
![MySQL](https://img.shields.io/badge/MySQL-8.0+-orange.svg)
![Status](https://img.shields.io/badge/status-active-brightgreen.svg)
![Queries](https://img.shields.io/badge/queries-20+-blue.svg)
```

## 8. Criar Issues e Milestones (Opcional)

Para melhorar a organização:

1. Crie **Issues** para melhorias futuras:
   - "Adicionar tabela de histórico de manutenção"
   - "Implementar triggers para auditoria"
   - "Criar views para relatórios gerenciais"

2. Crie **Milestones** para versões:
   - v1.0 - Versão inicial com 13 tabelas
   - v2.0 - Adicionar relatórios avançados e views

## 9. Proteger a Branch Main (Opcional)

No GitHub, vá para **Settings → Branches** e configure:

- ✅ Require pull request reviews before merging
- ✅ Require status checks to pass before merging
- ✅ Require branches to be up to date before merging

## 10. Próximas Etapas

### Melhorias Futuras

1. **Adicionar Views SQL** para relatórios comuns
2. **Criar Stored Procedures** para operações complexas
3. **Adicionar Triggers** para auditoria e validações
4. **Documentar casos de uso** com exemplos práticos
5. **Criar um arquivo CONTRIBUTING.md** para colaboradores

### Exemplos de Melhorias

```sql
-- View: Serviços com detalhes completos
CREATE VIEW v_servicos_detalhes AS
SELECT 
    s.id,
    v.placa,
    CONCAT(v.marca, ' ', v.modelo) AS veiculo,
    ts.nome AS tipo_servico,
    s.custo_total,
    p.status AS status_pagamento
FROM servico s
...

-- Stored Procedure: Criar novo serviço
DELIMITER $$
CREATE PROCEDURE sp_criar_servico(
    IN p_veiculo_id INT,
    IN p_tipo_servico_id INT,
    OUT p_servico_id INT
)
BEGIN
    -- Lógica para criar serviço
END $$
DELIMITER ;
```

## 11. Checklist Final

- [ ] Repositório criado no GitHub
- [ ] Todos os arquivos adicionados
- [ ] Commits realizados com mensagens descritivas
- [ ] Push para a branch main
- [ ] README.md revisado
- [ ] Topics adicionados
- [ ] License configurada
- [ ] .gitignore funcionando
- [ ] Projeto pronto para avaliação

## 12. Compartilhar o Repositório

Copie o link do repositório e compartilhe:

```
https://github.com/seu_usuario/oficina-db
```

---

**Pronto!** Seu projeto está no GitHub e pronto para avaliação. 🚀
