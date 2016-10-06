/* Script of DESTRUCTION: TABLES, PROCEDURES and FUNCTIONS ----------------------------------------------------------*/

/* Destroying Tables ------------------------------------------------------------------*/

/* Dica: "Sair apagando as tabelas aleatoriamente? Pode isso Arnaldo? - Pergunto eu.
A Regra é clara: Se uma tabela tem uma chave primária (PK) sua adotada como chave estrangeira (FK) em outra tabela 
qualquer do banco de dados, ela não poderá ser excluída - Respondeu Arnaldo
E se o banco estiver complicado? - Replico eu.
Comece pelas tabelas auxiliares (Resultantes de relacionamentos N para N no MER), porque todas elas poderão ser 
deletadas primeiro, visto que elas não possuem PK adotadas como FK em outras tabelas. 
Em outras palavras, ninguém faz referência a elas (ninguém depende delas), antes, são elas que 
referenciam outras (dependem de outras)."*/

-- Dica: Usar o delimiter para dropar tudo de uma vez

DROP TABLE Cliente_has_telefone; -- Cliente_has_telefone --------------------------
DROP TABLE Mecanico_has_telefone; -- Mecanico_has_telefone --------------------------
DROP TABLE OrdemDeServico_has_servicos; -- OrdemDeServico_has_servicos --------------------------
DROP TABLE Mecanico_has_equipe; -- Mecanico_has_equipe --------------------------
DROP TABLE OrdemDeServico_has_pecas; -- OrdemDeServico_has_precas -------------------------- ??????
DROP TABLE OrdemDeServico; -- OrdemDeServico --------------------------
DROP TABLE Equipe; -- Equipe --------------------------
DROP TABLE Pecas; -- Peças --------------------------
DROP TABLE Servicos; -- Servicos --------------------------
DROP TABLE Mecanico; -- Mecanico --------------------------
DROP TABLE Telefone; -- Telefone --------------------------
DROP TABLE Veiculo; -- Veiculo --------------------------
DROP TABLE Fabricante; -- Fabricante --------------------------
DROP TABLE Cliente; -- Cliente --------------------------
DROP TABLE Endereco; -- Endereco --------------------------

/* Destroying PROCEDURES ------------------------------------------------------------------*/

DROP PROCEDURE OSsDeCliente;
DROP PROCEDURE SomaValorOsData;


/* Destroying VIEWS ------------------------------------------------------------------*/
DROP VIEW ClienteMaiorValorOS;
DROP VIEW VeiculosPorFabricante;
DROP VIEW FabricanteMaisVeiculos;