# gRPC Task Scheduler

Este projeto é uma implementação de um sistema de agendamento de tarefas usando gRPC, consistindo em dois serviços principais: um API Gateway e um Engine de Agendamento.

## Sobre gRPC

gRPC é um framework moderno de chamada de procedimento remoto (RPC) desenvolvido pelo Google. Ele utiliza HTTP/2 para transporte e Protocol Buffers como linguagem de definição de interface. Algumas características principais:

- Comunicação bidirecional e streaming
- Alta performance e baixa latência
- Suporte a múltiplas linguagens
- Geração automática de código cliente/servidor
- Tipagem forte

## Arquitetura do Projeto

O projeto é composto por três componentes principais:

1. **Proto Definitions** (`/proto`)
   - Define a interface do serviço usando Protocol Buffers
   - Contém as mensagens e serviços disponíveis

2. **Scheduler API** (`/scheduler-api`)
   - API Gateway que expõe endpoints REST
   - Converte requisições HTTP em chamadas gRPC
   - Implementado em Node

3. **Scheduler Engine** (`/scheduler_engine`)
   - Serviço gRPC que gerencia o agendamento de tarefas
   - Implementa a lógica de negócio
   - Implementado em Elixir

### Fluxo de Dados

```
Cliente HTTP -> Scheduler API (REST) -> Scheduler Engine (gRPC)
```

## Serviços Disponíveis

O serviço gRPC expõe os seguintes métodos:

- `ScheduleTask`: Agenda uma nova tarefa
- `ListTasks`: Lista todas as tarefas agendadas

O Scheduler API estará rodando na porta 3000.

## Exemplos de Uso

### Agendar uma Tarefa

```bash
curl -X POST http://localhost:3000/tasks \
  -H "Content-Type: application/json" \
  -d '{
    "id": "task1",
    "task_name": "Backup Diário",
    "execute_at": "2024-04-15T15:00:00Z"
  }'
```

### Listar Tarefas

```bash
curl http://localhost:3000/tasks
```

## Estrutura do Projeto

```
.
├── proto/
│   └── scheduler.proto        # Definições do Protocol Buffer
├── scheduler-api/
├── scheduler_engine/
└── README.md
```

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request 