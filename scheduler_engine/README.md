# Scheduler Engine (Elixir gRPC Service)

## Descrição
O Scheduler Engine é um serviço gRPC desenvolvido em Elixir que gerencia o agendamento e execução de tarefas em memória. Este serviço é parte de um PoC (Proof of Concept) que demonstra a comunicação entre serviços usando gRPC, com Elixir atuando como o motor de agendamento e Node.js fornecendo uma interface REST.

## Motivação
Este projeto foi desenvolvido para explorar e demonstrar:
- Comunicação entre serviços usando gRPC
- Desenvolvimento de serviços em Elixir
- Integração entre diferentes tecnologias (Elixir e Node.js)
- Boas práticas de arquitetura desacoplada

## Tecnologias Utilizadas
- **Elixir** - Linguagem funcional para o motor de agendamento
- **gRPC** - Framework para comunicação entre serviços
- **Protobuf** - Formato de serialização de dados
- **GenServer** - Para gerenciamento de estado e tarefas em memória

### Bibliotecas Principais
- `grpc` - Implementação gRPC para Elixir
- `protobuf` - Para manipulação de mensagens Protocol Buffers

## Estrutura do Projeto
```
scheduler-engine/
├── lib/
│   └── scheduler/
│       ├── application.ex    # Configuração da aplicação
│       ├── server.ex        # Implementação do servidor gRPC
│       └── task_manager.ex  # Gerenciamento de tarefas
├── proto/                   # Definições Protocol Buffers
└── mix.exs                  # Configuração do projeto
```

## Pré-requisitos
- Elixir 1.17 ou superior
- Mix (gerenciador de pacotes do Elixir)

## Como Executar

1. Instale as dependências:
```bash
mix deps.get
```

2. Compile o projeto:
```bash
mix compile
```

3. Inicie o servidor:
```bash
mix run --no-halt
```

O servidor gRPC estará disponível na porta 50051.

## Funcionalidades
- Agendamento de tarefas
- Listagem de tarefas agendadas
- Execução automática de tarefas no horário especificado

## Observações
- Este é um PoC simples, sem persistência de dados
- As tarefas são armazenadas em memória (GenServer)
- O servidor deve ser reiniciado para limpar as tarefas
