# 🏥 ClinicFlow

**Plataforma SaaS de gestão e agendamento para clínicas multidisciplinares.**

O ClinicFlow é um projeto de desenvolvimento de uma plataforma SaaS B2B voltada à gestão de clínicas e profissionais da área da saúde.

A proposta é centralizar a administração de clínicas, pacientes, profissionais, especialidades e agendamentos em uma única plataforma, oferecendo uma estrutura segura, escalável e preparada para atender diferentes estabelecimentos.

O projeto está sendo desenvolvido com foco em boas práticas de engenharia de software, arquitetura modular, integridade de dados e isolamento de informações entre clínicas.

---

## 🎯 Objetivo do projeto

Desenvolver uma solução que simplifique a rotina administrativa de clínicas multidisciplinares, permitindo:

- Gerenciar diferentes clínicas em uma única plataforma.
- Controlar usuários e permissões de acesso.
- Administrar cadastros de pacientes.
- Gerenciar profissionais que podem atuar em diferentes clínicas.
- Organizar especialidades e vínculos profissionais.
- Disponibilizar uma estrutura para gerenciamento de agendas e agendamentos.
- Automatizar notificações e confirmações de consultas.

## 🏗️ Arquitetura

O ClinicFlow utiliza uma arquitetura de **monólito modular**, organizando o sistema por domínios de negócio.

A estratégia de multi-tenancy adotada utiliza um banco de dados compartilhado, com isolamento lógico dos dados por clínica (`clinic_id`).

Essa abordagem permite que diferentes clínicas utilizem a mesma aplicação, mantendo seus dados isolados.

### Principais módulos

| Módulo | Responsabilidade |
|---|---|
| Tenant | Gerenciamento e identificação das clínicas |
| User | Usuários, papéis e permissões |
| Patient | Cadastro e gerenciamento de pacientes |
| Professional | Cadastro e gerenciamento de profissionais |
| Specialty | Catálogo e associação de especialidades |
| Appointment | Futuro gerenciamento de agendamentos |

### Modelagem de profissionais

Um dos pontos importantes da arquitetura é a separação entre a identidade do profissional e seu vínculo com cada clínica.

Dessa forma, um mesmo profissional pode atuar em diferentes estabelecimentos sem precisar ter seu cadastro pessoal duplicado.

A arquitetura também permite:

- Associar registros profissionais, como CRM, CRO, CRP e COREN.
- Vincular profissionais a múltiplas clínicas.
- Definir especialidades de acordo com a atuação em cada clínica.
- Controlar o status do vínculo profissional em cada estabelecimento.

## 🛠️ Tecnologias utilizadas

### Backend
- Java 21
- Spring Boot
- Spring Data JPA
- Hibernate
- Maven
- Flyway

### Banco de dados
- PostgreSQL 17

### Infraestrutura
- Docker
- Docker Compose

### Frontend
- Next.js
- React
- TypeScript
- Tailwind CSS

### Integrações planejadas
- AWS SNS
- AWS SQS
- Serviços de envio de e-mail, SMS e WhatsApp por provedores externos.

## 🗄️ Banco de dados e migrations

A estrutura do banco de dados é versionada com Flyway, garantindo o controle da evolução do schema.

### Migrations implementadas

| Versão | Descrição |
|---|---|
| V1 | Criação da tabela de clínicas |
| V2 | Criação da tabela de usuários |
| V3 | Criação das tabelas de papéis e permissões |
| V4 | Criação da tabela de pacientes |
| V5 | Criação das tabelas de profissionais, registros profissionais, vínculos com clínicas e especialidades |

As migrations V1 a V5 foram aplicadas e validadas no PostgreSQL.

Os testes de integridade da V5 contemplaram:

- Validação do formato e unicidade do CPF.
- Unicidade dos registros profissionais por conselho, estado e número.
- Prevenção de vínculos duplicados entre profissionais e clínicas.
- Prevenção de associações duplicadas de especialidades.
- Validação de chaves estrangeiras.
- Proteção contra exclusões que violariam os relacionamentos.

## 🔐 Estratégia de multi-tenancy

O sistema utiliza uma abordagem de banco compartilhado com separação lógica por clínica.

Cada usuário pertence a uma clínica, e os dados vinculados aos estabelecimentos são organizados por seus respectivos identificadores.

A estratégia prevê que a identificação da clínica seja determinada pelo contexto autenticado no backend, evitando confiar em identificadores de tenant enviados diretamente pelo frontend.

## 📂 Estrutura do projeto

```text
clinicflow/
├── backend/
│   └── clinic-flow/
│       ├── src/
│       │   ├── main/
│       │   │   ├── java/
│       │   │   │   └── com/clinicflow/
│       │   │   │       └── modules/
│       │   │   │           ├── tenant/
│       │   │   │           ├── user/
│       │   │   │           ├── patient/
│       │   │   │           ├── professional/
│       │   │   │           └── specialty/
│       │   │   └── resources/
│       │   │       └── db/migration/
│       │   └── test/
│       └── pom.xml/
├── frontend/
├── docker-compose.yml
└── .env
```

## 🚀 Execução do projeto

### Pré-requisitos

- Java 21
- Docker
- Docker Compose
- Maven (caso não utilize o Maven Wrapper)
- Node.js (para o frontend)

### Executando o backend e o PostgreSQL

Na raiz do projeto, configure as variáveis de ambiente no arquivo `.env`.

Em seguida, execute:

```powershell
docker compose up -d --build
```

Para verificar os containers:

```powershell
docker compose ps
```

Para acompanhar os logs da API:

```powershell
docker compose logs -f api
```

### Acesso ao PostgreSQL

A configuração local atual utiliza:

- Host: `localhost`
- Porta: `5440`
- Database: `clinicflow`

As credenciais devem ser obtidas no arquivo de ambiente local.

## 📌 Status do desenvolvimento

O ClinicFlow está em desenvolvimento incremental.

### Implementado e validado

- [x] Estrutura inicial do projeto.
- [x] Configuração do Spring Boot.
- [x] Configuração do PostgreSQL com Docker.
- [x] Integração com Flyway.
- [x] Modelagem de clínicas.
- [x] Modelagem de usuários.
- [x] Modelagem de papéis e permissões.
- [x] Modelagem de pacientes.
- [x] Modelagem de profissionais e registros profissionais.
- [x] Relacionamento entre profissionais e múltiplas clínicas.
- [x] Modelagem de especialidades multidisciplinares.
- [x] Validação das constraints e relacionamentos da V5.

### Em desenvolvimento

- [ ] Implementação e validação das entidades JPA.
- [ ] Repositories e camada de persistência.
- [ ] Serviços de negócio.
- [ ] APIs REST para gerenciamento de clínicas, pacientes e profissionais.
- [ ] Autenticação e autorização.
- [ ] Gestão de agendas e agendamentos.
- [ ] Integração com serviços de notificação.

## 🧠 Conceitos e práticas aplicados

Durante o desenvolvimento, são explorados conceitos importantes de engenharia de software:

- Arquitetura de monólito modular.
- Modelagem relacional.
- Multi-tenancy.
- Relacionamentos JPA/Hibernate.
- Integridade referencial.
- Versionamento de banco de dados.
- Containerização.
- Separação de responsabilidades.
- Evolução incremental da arquitetura.

## 👩‍💻 Sobre o projeto

O ClinicFlow é um projeto de portfólio desenvolvido com o objetivo de aprofundar conhecimentos em desenvolvimento backend com Java e Spring Boot, arquitetura de software, bancos de dados relacionais e construção de aplicações SaaS.

O desenvolvimento prioriza decisões arquiteturais fundamentadas, validação das regras de negócio e evolução gradual da solução.

---

**ClinicFlow — Conectando clínicas, profissionais e pacientes.** 💜
