DROP TABLE IF EXISTS tb_tarefa;


CREATE DATABASE IF NOT EXISTS gerenciador_tarefas;

 USE gerenciador_tarefas;

 CREATE TABLE tarefas (

id INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(255) NOT NULL,
descricao TEXT,
criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
DESCRIBE tarefas;

SELECT  * FROM tarefas;