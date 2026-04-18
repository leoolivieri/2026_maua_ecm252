require( 'dotenv').config()
const express = require('express');
const mysql2 = require('mysql2/promise');
const app = express();
app.use(express.json());

let conexao; 

const conectar = async () => {
  try {
    // CORREÇÃO 1: Você precisa do 'await' aqui para esperar o banco responder
    // CORREÇÃO 2: Você precisa atribuir o resultado à variável 'conexao'
    conexao = await mysql2.createConnection({
      host: process.env.HOST.trim(),
      user: process.env.USUARIO,
      password: process.env.PASSWORD,
      database: process.env.DATABASE,
      port: process.env.PORT,
      ssl: {
        rejectUnauthorized: false
      }
    });
    
    console.log('Conectado ao MySQL com sucesso!');
  } catch (erro) {
    console.error('Erro ao conectar ao MySQL:', erro.message);
  }
};

conectar();

//fazer uma rota para cadastrar uma tarefa
//suponha que o cliente vai enviar título e descrição por meio da requisição
//dica: use req.body
app.post('/tarefas', async (req, res) => {
  try {
    // Desestruturação dos dados vindos do corpo da requisição (JSON) - isso é mais limpo do que acessar req.body.titulo e req.body.descricao
    const { titulo, descricao } = req.body;

    // Montagem da query SQL usando Template Strings ou concatenação
    const sql = 'INSERT INTO tarefas (titulo, descricao) VALUES (?, ?)';

    // Execução da query usando Prepared Statements (os "?" evitam SQL Injection)
    const [resultado] = await conexao.query(sql, [titulo, descricao]);

    // Retorno de sucesso (Status 201: Created)
    res.status(201).json({
      id: resultado.insertId,
      titulo,
      descricao
    });

  } catch (erro) {
    // Tratamento de erro caso algo falhe no banco
    console.error(erro);
    res.status(500).json({
      erro: 'Erro ao criar tarefa'
    });
  }
});

// Obter lista de tarefas
app.get('/tarefas', async (req, res) => {
  try {
    // Proteção: verifica se a conexão existe antes de fazer a query
    if (!conexao) {
      return res.status(500).json({ error: "Banco não conectado" });
    }
    
    const [linhas] = await conexao.query('SELECT * FROM tarefas');
    res.json(linhas); // Envia o resultado para o cliente
  } catch (erro) {
    res.status(500).json({ error: erro.message });
  }
});

// ROTA PARA ATUALIZAR (PUT)
app.put('/tarefas/:id', async (req, res) => { // Adicionado :id
  try {
    const { id } = req.params; // Pega o ID da URL
    const { titulo, descricao } = req.body;

    const sql = 'UPDATE tarefas SET titulo = ?, descricao = ? WHERE id = ?';
    
    // A ordem no array deve bater com os "?" no SQL
    const [resultado] = await conexao.query(sql, [titulo, descricao, id]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ erro: 'Tarefa não encontrada' });
    }

    res.status(200).json({ id, titulo, descricao });
  } catch (erro) {
    console.error(erro);
    res.status(500).json({ erro: 'Erro ao atualizar tarefa' });
  }
});

// ROTA PARA DELETAR (DELETE)
app.delete('/tarefas/:id', async (req, res) => { // Adicionado :id
  try {
    const { id } = req.params;

    const sql = 'DELETE FROM tarefas WHERE id = ?';
    const [resultado] = await conexao.query(sql, [id]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ erro: 'Tarefa não encontrada' });
    }

    res.status(200).json({ mensagem: `Tarefa ${id} removida com sucesso!` });
  } catch (erro) {
    console.error(erro);
    res.status(500).json({ erro: 'Erro ao deletar tarefa' });
  }
});



app.get('/', (req, res) => {
  res.json({ message: 'Servidor OK!' });
});

const port = 3000;
app.listen(port, () => {
  console.log(`Servidor rodando na porta ${port}`);
});