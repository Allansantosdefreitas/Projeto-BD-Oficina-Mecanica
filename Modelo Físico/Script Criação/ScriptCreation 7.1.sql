CREATE DATABASE OficinaMecanica;
USE OficinaMecanica;
/* Creating TABLES ------------------------------------------------------------------*/

-- Endereco --------------------------
CREATE TABLE Endereco(
	Codigo INT NOT NULL,
    LogradouroNome VARCHAR(45) NOT NULL,
    Numero INT NOT NULL,
	Complemento VARCHAR(45),
    CEP VARCHAR(9) NOT NULL, 
    Bairro VARCHAR(45) NOT NULL,
    Cidade VARCHAR(45) NOT NULL,
    Estado CHAR(2) NOT NULL,
		PRIMARY KEY(Codigo)
);

-- Cliente --------------------------
CREATE TABLE Cliente(
	Codigo INT NOT NULL,
	Nome VARCHAR(45) NOT NULL,
	DataNascimento DATE,
	EnderecoCodigo INT NOT NULL,
		PRIMARY KEY(Codigo),
		FOREIGN KEY(EnderecoCodigo)
			REFERENCES Endereco (Codigo)
);


-- Mecanico --------------------------
CREATE TABLE Mecanico(
	Codigo INT NOT NULL,
	Nome VARCHAR(45) NOT NULL,
	DataNascimento DATE,
	Especialidade VARCHAR(45) NOT NULL,
	EnderecoCodigo INT NOT NULL,
		PRIMARY KEY(Codigo),
		FOREIGN KEY(EnderecoCodigo)
			REFERENCES Endereco (Codigo)
);


-- Telefone --------------------------
CREATE TABLE Telefone (
    Codigo INT NOT NULL,
    DDD CHAR(3) NOT NULL,
    Numero CHAR(19) NOT NULL,
		PRIMARY KEY(Codigo)
);

-- Cliente_has_telefone --------------------------
CREATE TABLE Cliente_has_telefone(
	Codigo INT NOT NULL,
    ClienteCodigo INT NOT NULL,
	TelefoneCodigo INT NOT NULL,
		PRIMARY KEY(Codigo),
		FOREIGN KEY (TelefoneCodigo)
			REFERENCES Telefone (Codigo),
		FOREIGN KEY (ClienteCodigo)
			REFERENCES Cliente (Codigo)
);

-- Mecanico_has_telefone --------------------------
CREATE TABLE Mecanico_has_telefone(
	Codigo INT NOT NULL,
    MecanicoCodigo INT NOT NULL,
	TelefoneCodigo INT NOT NULL,
		PRIMARY KEY(Codigo),
		FOREIGN KEY (TelefoneCodigo)
			REFERENCES Telefone (Codigo),
		FOREIGN KEY (MecanicoCodigo)
			REFERENCES Mecanico (Codigo)
);

-- Servico --------------------------
CREATE TABLE Servicos(
	Codigo INT NOT NULL,
	Valor NUMERIC(7,2) NOT NULL,
	Descricao VARCHAR(45) NOT NULL,
		PRIMARY KEY(Codigo)
);


-- Equipe --------------------------
CREATE TABLE Equipe(
	Codigo INT NOT NULL,
	Nome VARCHAR(45),
		PRIMARY KEY(Codigo)
);

-- OrdemDeServico --------------------------
CREATE TABLE OrdemDeServico(
	Codigo INT NOT NULL,
	Valor DECIMAL(8,2) NOT NULL,
	DataEmissao DATE NOT NULL,
	DataConclusao DATE NOT NULL,
	ClienteCodigo INT NOT NULL,
	EquipeCodigo INT NOT NULL,
		PRIMARY KEY(Codigo),
		FOREIGN KEY(ClienteCodigo)
			REFERENCES Cliente (Codigo),
		FOREIGN KEY(EquipeCodigo)
			REFERENCES Equipe (Codigo)
);

-- Mecanico_has_equipe --------------------------
CREATE TABLE Mecanico_has_equipe(
	Codigo INT NOT NULL,
	MecanicoCodigo INT NOT NULL,
	EquipeCodigo INT NOT NULL,
		PRIMARY KEY(Codigo),
		FOREIGN KEY(MecanicoCodigo)
			REFERENCES Mecanico (Codigo),
		FOREIGN KEY(EquipeCodigo)
			REFERENCES Equipe (Codigo)
);

-- OrdemDeServico_has_servicos --------------------------
CREATE TABLE OrdemDeServico_has_servicos(
	Codigo INT NOT NULL,
    OrdemDeServicoCodigo INT NOT NULL,
	ServicosCodigo INT NOT NULL,
		PRIMARY KEY(Codigo),
		FOREIGN KEY(OrdemDeServicoCodigo)
			REFERENCES OrdemDeServico (Codigo),
		FOREIGN KEY(ServicosCodigo)
			REFERENCES Servicos (Codigo)
);

-- Fabricante --------------------------
CREATE TABLE Fabricante(
	Codigo INT NOT NULL,
	Nome VARCHAR(45) NOT NULL,
		PRIMARY KEY(Codigo)
);

-- Veiculo --------------------------
CREATE TABLE Veiculo(
	Codigo INT NOT NULL,
	Placa CHAR(7) NOT NULL,
	Modelo VARCHAR(45) NOT NULL,
	AnoFabricacao YEAR,
	ClienteCodigo INT NOT NULL,
	FabricanteCodigo INT NOT NULL,
		PRIMARY KEY(Codigo),
		FOREIGN KEY(ClienteCodigo)
			REFERENCES Cliente (Codigo),
		FOREIGN KEY(FabricanteCodigo)
			REFERENCES Fabricante (Codigo)
);
-- Peças --------------------------
CREATE TABLE Pecas(
	Codigo INT NOT NULL,
	Descricao VARCHAR(45) NOT NULL,
	Valor NUMERIC(7,2) NOT NULL,
	Lote VARCHAR(45) NOT NULL,
	DataVencimento DATE NOT NULL,
	FabricanteCodigo INT NOT NULL,
	PRIMARY KEY(Codigo),
	FOREIGN KEY(FabricanteCodigo)
		REFERENCES Fabricante (Codigo)
);
-- OrdemDeServico_has_precas --------------------------
CREATE TABLE OrdemDeServico_has_pecas(
	Codigo INT NOT NULL,
    OrdemDeServicoCodigo INT NOT NULL,
	PecasCodigo INT NOT NULL,
		PRIMARY KEY(Codigo),
		FOREIGN KEY(OrdemDeServicoCodigo)
			REFERENCES OrdemDeServico (Codigo),
		FOREIGN KEY(PecasCodigo)
			REFERENCES Pecas (Codigo)
);

/* Creating PROCEDURES ------------------------------------------------------------------*/

-- 1)  Procedure OSsDeCliente para saber as Ordens de Serviço que determinado cliente fez
delimiter $$
CREATE PROCEDURE OSsDeCliente (IN nome varchar(20))
	BEGIN
		SELECT Os.Valor "Valor", Os.DataEmissao "Data de Emissão", Os.DataConclusao "Data de Conclusao", 
		Cli.Nome "Nome do Cliente" FROM OrdemDeServico OS, Cliente Cli
			WHERE Cli.Codigo = Os.ClienteCodigo AND
				Cli.Nome LIKE nome;
	END $$
delimiter ;

-- 2)  Procedure para calcular o somatório das OSs cujas datas de entrega terminam na data especificada

DELIMITER $$
CREATE PROCEDURE SomaValorOsData(IN DataConclusaoOS DATE)
	BEGIN
		SELECT SUM(Valor) AS 'Valor a receber', DataConclusao AS 'DataConclusao'
			FROM OrdemDeServico
				WHERE DataConclusao LIKE DataConclusaoOS;
	END
    $$
    DELIMITER ;
    
/* Creating VIEWS ------------------------------------------------------------------*/

-- 1)  VIEW ClienteMaiorValorOS para saber qual cliente fez a OS de maior valor
CREATE VIEW ClienteMaiorValorOS AS
	SELECT Cli.Nome AS "Nome do Cliente", MAX(Os.Valor) "Valor" 
				FROM Cliente Cli, OrdemDeServico Os
					WHERE Cli.Codigo = Os.ClienteCodigo;
                    

-- 2) Fabricante de veículo e suas respectivas quantidade de veículos cadastrados
CREATE VIEW VeiculosPorFabricante AS
	SELECT F.Nome "Fabricante Veículos", COUNT(V.FabricanteCodigo) AS "Quantidade"
		FROM Fabricante F, Veiculo V
			WHERE F.Codigo = V.FabricanteCodigo
				GROUP BY V.FabricanteCodigo;
            
-- 3) Fabricante com mais veículos            
CREATE VIEW FabricanteMaisVeiculos AS
	SELECT Fab.Nome AS "Fabricante", MAX(Quantidade) "Quantidade de Veículos" 
		FROM VeiculosPorFabricante VPF, Fabricante Fab;
        

