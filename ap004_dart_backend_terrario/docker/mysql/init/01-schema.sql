CREATE DATABASE IF NOT EXISTS terrarios

USE terrarios;

CREATE TABLE IF NOT EXISTS terrarios(
    id INT NOT NULL AUTO_INCREMENT,
    apelido VARCHAR(80) NOT NULL,
    bioma ENUM('tropical', 'desertico', 'temperado', 'musgo') NOT NULL,
    umidade_alvo TINYINT UNSIGNED NOT NULL,
    volume_litros DECIMAL(7,2) NOT NULL,
    data_montagem DATE NOT NULL,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY uk_terrarios_apelido(apelido),
    KEY idx_terrarios_bioma (bioma),
    CONSTRAINT ck_terrarios_umidade CHECK (umidade_alvo BETWEEN 0 AND 100),
    CONSTRAINT ck_terrarios_volume CHECK (volume_litros > 0)
)

INSERT INTO terrarios(
    apelido, bioma, umidade_alvo, volume_litros, data_montagem
)
VALUES
('Vale das Samambaias', 'tropical', 85,12.50,'2026-03-14'),
('Duna de Bolso', 'desertico', 20,4.00,'2026-01-08'),
('Bosque de Musgo', 'musgo', 92,7.25,'2025-11-30'),
('Clareira Fria', 'temperado', 60,18.00,'2026-05-02');
