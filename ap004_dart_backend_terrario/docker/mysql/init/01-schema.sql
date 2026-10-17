-- Executado automaticamente pelo contêiner MySQL na primeira inicialização.

-- Cria o banco, se ainda não existir.
-- CORRIGIDO: faltava o `;` no fim desta linha e no fim do CREATE TABLE.
CREATE DATABASE IF NOT EXISTS terrarios;

-- Passa a usar esse banco nos comandos seguintes.
USE terrarios;

CREATE TABLE IF NOT EXISTS terrarios (
    id INT NOT NULL AUTO_INCREMENT,                       -- Chave gerada automaticamente.
    apelido VARCHAR(80) NOT NULL,                         -- Nome do terrário (até 80 caracteres).
    bioma ENUM('tropical', 'desertico', 'temperado', 'musgo') NOT NULL, -- Só esses valores.
    umidade_alvo TINYINT UNSIGNED NOT NULL,               -- Inteiro pequeno, sem sinal.
    volume_litros DECIMAL(7,2) NOT NULL,                  -- Até 99999.99, valor exato.
    data_montagem DATE NOT NULL,                          -- Só a data, sem hora.
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Preenchido na inserção.
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,                      -- Atualizado em todo UPDATE.

    PRIMARY KEY (id),                                     -- Identificador único.
    UNIQUE KEY uk_terrarios_apelido (apelido),            -- Não permite apelidos repetidos.
    KEY idx_terrarios_bioma (bioma),                      -- Índice p/ filtrar por bioma.
    CONSTRAINT ck_terrarios_umidade CHECK (umidade_alvo BETWEEN 0 AND 100), -- 0 a 100%.
    CONSTRAINT ck_terrarios_volume CHECK (volume_litros > 0) -- Volume positivo.
);

-- Dados de exemplo.
INSERT INTO terrarios (apelido, bioma, umidade_alvo, volume_litros, data_montagem)
VALUES
    ('Vale das Samambaias', 'tropical', 85, 12.50, '2026-03-14'),
    ('Duna de Bolso', 'desertico', 20, 4.00, '2026-01-08'),
    ('Bosque de Musgo', 'musgo', 92, 7.25, '2025-11-30'),
    ('Clareira Fria', 'temperado', 60, 18.00, '2026-05-02');
