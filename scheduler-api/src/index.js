const express = require('express');
const { loadPackageDefinition, credentials } = require('@grpc/grpc-js');
const { loadSync } = require('@grpc/proto-loader');
const { body, validationResult } = require('express-validator');
const { v4: uuidv4 } = require('uuid');

const app = express();
app.use(express.json());

// Carregando o arquivo proto
const PROTO_PATH = __dirname + '/protos/scheduler.proto';
console.log('Loading proto file from:', PROTO_PATH);

const packageDefinition = loadSync(PROTO_PATH, {
  keepCase: true,
  longs: String,
  enums: String,
  defaults: true,
  oneofs: true
});

console.log('Package definition loaded successfully');

const schedulerProto = loadPackageDefinition(packageDefinition).scheduler;
console.log('Scheduler proto loaded:', schedulerProto);

const client = new schedulerProto.TaskScheduler('localhost:50051', credentials.createInsecure());
console.log('gRPC client initialized');

// Middleware de validação
const validateTask = [
  body('task_name').notEmpty().withMessage('Task name is required'),
  body('execute_at').isISO8601().withMessage('Invalid date format. Use ISO8601 format')
];

// Rota para criar uma nova tarefa
app.post('/tasks', validateTask, async (req, res) => {
  console.log('Received POST /tasks request');
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { task_name, execute_at } = req.body;
  const id = uuidv4();

  try {
    console.log('Attempting to schedule task:', { id, task_name, execute_at });
    await new Promise((resolve, reject) => {
      client.scheduleTask({ id, task_name, execute_at }, (error, response) => {
        if (error) {
          console.error('Error in scheduleTask:', error);
          reject(error);
        } else {
          console.log('Task scheduled successfully:', response);
          resolve(response);
        }
      });
    });

    res.status(201).json({
      id,
      task_name,
      execute_at,
      status: 'scheduled'
    });
  } catch (error) {
    console.error('Error scheduling task:', error);
    res.status(500).json({ error: 'Failed to schedule task' });
  }
});

// Rota para listar todas as tarefas
app.get('/tasks', async (req, res) => {
  console.log('Received GET /tasks request');
  try {
    const tasks = await new Promise((resolve, reject) => {
      client.listTasks({}, (error, response) => {
        if (error) {
          console.error('Error in listTasks:', error);
          reject(error);
        } else {
          console.log('Tasks retrieved successfully:', response);
          resolve(response.tasks);
        }
      });
    });

    res.json(tasks);
  } catch (error) {
    console.error('Error listing tasks:', error);
    res.status(500).json({ error: 'Failed to list tasks' });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
}); 