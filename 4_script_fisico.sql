-- =========================================================
-- Script DDL - Banco de Dados: Clínica Veterinária
-- Versão adaptada para MySQL Workbench
-- =========================================================

CREATE DATABASE IF NOT EXISTS clinica_veterinaria
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_general_ci;

USE clinica_veterinaria;

-- ---------------------------------------------------------
-- Tabela: Cliente
-- ---------------------------------------------------------
CREATE TABLE Cliente (
    cpf         VARCHAR(11)     NOT NULL,
    nome        VARCHAR(100)    NOT NULL,
    telefone    VARCHAR(15)     NULL,
    email       VARCHAR(100)    NULL,
    PRIMARY KEY (cpf)
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Tabela: Animal
-- ---------------------------------------------------------
CREATE TABLE Animal (
    cod_animal      INT             NOT NULL AUTO_INCREMENT,
    nome            VARCHAR(60)     NOT NULL,
    ano_nascimento  INT             NULL,
    especie         VARCHAR(40)     NOT NULL,
    raca            VARCHAR(60)     NULL,
    cpf_cliente     VARCHAR(11)     NOT NULL,
    PRIMARY KEY (cod_animal),
    CONSTRAINT fk_animal_cliente
        FOREIGN KEY (cpf_cliente) REFERENCES Cliente (cpf)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Tabela: Veterinario
-- ---------------------------------------------------------
CREATE TABLE Veterinario (
    crmv            VARCHAR(15)     NOT NULL,
    nome            VARCHAR(100)    NOT NULL,
    data_admissao   DATE            NOT NULL,
    especialidade   VARCHAR(80)     NULL,
    salario         DECIMAL(10,2)   NOT NULL,
    PRIMARY KEY (crmv)
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Tabela: Consulta
-- ---------------------------------------------------------
CREATE TABLE Consulta (
    cod_consulta        INT             NOT NULL AUTO_INCREMENT,
    data                DATE            NOT NULL,
    hora                TIME            NOT NULL,
    motivo              VARCHAR(200)    NULL,
    crmv_veterinario    VARCHAR(15)     NOT NULL,
    cod_animal          INT             NOT NULL,
    PRIMARY KEY (cod_consulta),
    CONSTRAINT fk_consulta_veterinario
        FOREIGN KEY (crmv_veterinario) REFERENCES Veterinario (crmv)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_consulta_animal
        FOREIGN KEY (cod_animal) REFERENCES Animal (cod_animal)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------------------------------------------------------
-- Índices auxiliares
-- ---------------------------------------------------------
CREATE INDEX idx_animal_cliente ON Animal (cpf_cliente);
CREATE INDEX idx_consulta_veterinario ON Consulta (crmv_veterinario);
CREATE INDEX idx_consulta_animal ON Consulta (cod_animal);

-- ---------------------------------------------------------
-- Dados de exemplo (opcional - descomente para testar)
-- ---------------------------------------------------------
-- INSERT INTO Cliente (cpf, nome, telefone, email) VALUES
--     ('11122233344', 'Mariana Silva', '(18) 99999-1111', 'mariana@email.com'),
--     ('22233344455', 'Carlos Oliveira', '(18) 98888-2222', 'carlos@email.com');
--
-- INSERT INTO Animal (nome, ano_nascimento, especie, raca, cpf_cliente) VALUES
--     ('Thor', 2021, 'Cachorro', 'Labrador', '11122233344'),
--     ('Luna', 2023, 'Gato', 'SRD', '22233344455');
--
-- INSERT INTO Veterinario (crmv, nome, data_admissao, especialidade, salario) VALUES
--     ('CRMV-SP-0001', 'Dra. Ana Martins', '2022-02-14', 'Clínica Geral', 6800.00);
--
-- INSERT INTO Consulta (data, hora, motivo, crmv_veterinario, cod_animal) VALUES
--     ('2026-09-10', '14:30:00', 'Consulta de rotina', 'CRMV-SP-0001', 1);
