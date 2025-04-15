# Scheduler API (Node.js REST Service)

## Descrição
O Scheduler API é um serviço REST desenvolvido em Node.js que fornece uma interface HTTP para interagir com o Scheduler Engine (serviço gRPC em Elixir). Este serviço é parte de um PoC (Proof of Concept) que demonstra a comunicação entre serviços usando gRPC, com Node.js atuando como uma camada de API REST.

## Motivação
Este projeto foi desenvolvido para explorar e demonstrar:
- Integração entre serviços REST e gRPC
- Desenvolvimento de APIs em Node.js
- Comunicação entre diferentes tecnologias (Node.js e Elixir)
- Boas práticas de desenvolvimento de APIs REST

## Tecnologias Utilizadas
- **Node.js** - Runtime JavaScript para a API REST
- **Express** - Framework web para Node.js
- **gRPC** - Framework para comunicação com o serviço Elixir
- **Protobuf** - Formato de serialização de dados

### Bibliotecas Principais
- `@grpc/grpc-js` - Cliente gRPC para Node.js
- `@grpc/proto-loader` - Carregador de arquivos .proto
- `express` - Framework web
- `express-validator` - Validação de requisições
- `uuid` - Geração de IDs únicos

## Estrutura do Projeto
```
scheduler-api/
├── src/
│   ├── index.js            # Ponto de entrada da aplicação
│   └── protos/             # Definições Protocol Buffers
├── package.json            # Configuração do projeto
└── README.md               # Este arquivo
```

## Pré-requisitos
- Node.js 16 ou superior
- npm (gerenciador de pacotes do Node.js)
- Servidor gRPC em Elixir rodando (scheduler-engine)

## Como Executar

1. Instale as dependências:
```bash
npm install
```

2. Inicie o servidor:
```bash
npm run dev
```

O servidor REST estará disponível na porta 3000.

## Endpoints da API

### Criar uma Tarefa
```bash
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "task_name": "Testar API",
    "execute_at": "2025-04-15T00:10:23.220644Z"
  }'
```

### Listar Tarefas
```bash
curl http://localhost:3000/tasks
```

## Validações
- `task_name`: Campo obrigatório
- `execute_at`: Deve ser uma data válida no formato ISO8601

## Observações
- Este é um PoC simples, sem persistência de dados
- A API depende do serviço gRPC em Elixir estar rodando
- As tarefas são gerenciadas pelo serviço Elixir