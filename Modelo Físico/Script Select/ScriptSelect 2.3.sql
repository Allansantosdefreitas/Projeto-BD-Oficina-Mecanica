/* Script of QUERY-----------------------------------------------------------------------------------------*/

-- Os endereços de todos os clientes de fora do estado de Pernambuco
SELECT * FROM Endereco E, Cliente Cli 
	WHERE E.Codigo = Cli.EnderecoCodigo AND 
    E.Estado <> 'PE';
    
-- Nome de todos os fabricantes de veículos, ordenados ascendentemente pelo nome ------------------------
SELECT F.Nome AS "Fabricante Veículos" FROM Fabricante F, Veiculo V
	WHERE F.Codigo = V.FabricanteCodigo
	ORDER BY F.Nome;
    
-- O quantidade total de fabricantes de veículos ------------------------
SELECT COUNT(F.Codigo) AS "Qtde. Fabricante Veículos" FROM Fabricante F, Veiculo V
	WHERE F.Codigo = V.FabricanteCodigo
	ORDER BY F.Nome;
    
-- Nome de todos os fabricantes de peças, ordenados ascendentemente pelo nome ------------------------
SELECT F.Nome AS "Fabricante Peças" FROM Fabricante F, Pecas P
	WHERE F.Codigo =  P.FabricanteCodigo
	ORDER BY F.Nome;
    
-- A Quantidade de fabricantes de peças ------------------------
SELECT COUNT(F.Codigo) AS "Qtd. Fabricantes Peças" FROM Fabricante F, Pecas P
	WHERE F.Codigo = P.FabricanteCodigo;
    
-- Selecionar o nome e número de todos os mecânicos residentes na do Logradouro Rua Charles Babbage.

SELECT mec.nome "Nome do Mecânico ", end.LogradouroNome "Logradouro" , tel.Numero "Número para Contato"
FROM mecanico mec , endereco end, telefone tel, mecanico_has_telefone mt 
WHERE mec.EnderecoCodigo = end.Codigo and mec.codigo = mt.MecanicoCodigo and mt.TelefoneCodigo = tel.Codigo and end.LogradouroNome like 'Rua Charles Babbage' 
ORDER BY mec.Nome;


-- Selecionar o nome da equipe, descrição do serviço e data de conclusão do serviço.
SELECT eq.nome "Nome da Equipe", serv.Descricao "Descrição do Serviço", o.DataConclusao "Data de Conclusão do Serviço "
FROM equipe eq, servicos serv, ordemdeservico o, ordemdeservico_has_servicos os
WHERE eq.Codigo = o.EquipeCodigo and 
o.Codigo = os.OrdemDeServicoCodigo and 
os.ServicosCodigo = serv.Codigo;

-- Selecione as cidades e a quantidade de clientes por cidade

SELECT e.Cidade "Cidade", COUNT(*) "Quantidade de clientes por cidade"
FROM  endereco e, cliente c
WHERE e.Codigo = c.EnderecoCodigo
GROUP BY e.Cidade
ORDER BY e.Cidade;

-- Selecione a Descrição  e Data de vencimento da peça mais cara

SELECT Descricao "Descrição" , DataVencimento "Data de Vencimento"
FROM pecas
WHERE Valor in (SELECT MAX(Valor) FROM pecas);

-- Selecione o serviço a data de inicio e data de conclusão e o valor do serviço.

SELECT s.Descricao "Serviços Entre 1/1/2014 até 30/12/2015" , o.DataEmissao "Data de Inicio" ,o.DataConclusao "Data de Conclusão", s.Valor "Valor do Serviço" 
FROM ordemdeservico o, servicos s, ordemdeservico_has_servicos os
WHERE o.DataConclusao BETWEEN '2014-01-01' AND '2015-12-30';

-- Selecionar o nome e a especialidade de todos os mecanicos da equipe Team One e organizar em ordem alfabética. 

SELECT m.Nome "Nome do Mecanico", m.Especialidade 
FROM equipe e, mecanico m, mecanico_has_equipe me 
WHERE e.Codigo = me.EquipeCodigo and 
me.MecanicoCodigo = m.Codigo and 
e.Nome like 'Team One'
ORDER BY m.Nome;

-- Selecionar o nome do cliente e o modelo do carro dos clientes que possuem modelos fabricados em 2013.

SELECT c.Nome "Nome do cliente" , v.Modelo "Modelo do Carro"
FROM veiculo v, cliente c 
WHERE v.AnoFabricacao = 2013 AND c.codigo= v.ClienteCodigo
ORDER BY c.Nome;

-- Selecionar todas as peças, valor, data de vencimento e nome dos respectivos fabricantes e ordenar pelas peças. 

SELECT p.Descricao "Peça", p.Valor "Valor da Peça", p.DataVencimento "Data vencimento", f.Nome "Nome do fabricante"
FROM pecas p, fabricante f 
WHERE p.FabricanteCodigo = f.Codigo
ORDER BY p.Descricao;

-- Selecionar todas as datas de emissão em que a peça bateria foi usada e ordene pela data de emissão.

SELECT s.Descricao "Descrição do serviço" , o.DataEmissao " Data de Emissão do Serviço dos quais o item Bateria foi usado"
FROM pecas p , servicos s, ordemdeservico o, ordemdeservico_has_pecas op, ordemdeservico_has_servicos os
WHERE s.Codigo = os.ServicosCodigo AND
os.OrdemDeServicoCodigo = o.Codigo AND 
o.Codigo = op.OrdemDeServicoCodigo AND
p.Descricao like 'Bateria'
ORDER BY o.DataEmissao;

-- Selecionar O nome e número para contato de todos os mecanicos. 

SELECT m.Nome "Mecênico",t.DDD "DDD", t.Numero "Telefone"
FROM mecanico m , telefone t, mecanico_has_telefone mt
WHERE m.Codigo = mt.MecanicoCodigo AND 
mt.TelefoneCodigo = t.Codigo
ORDER BY m.Nome;

--  Fabricante de veículo e suas respectivas quantidades de veículos cadastrados.

SELECT *
FROM VeiculosPorFabricante;

-- Cliente que fez a Ordem de Serviço de maior valor.

SELECT *
FROM  ClienteMaiorValorOS;


-- Fabricante com mais veículos  

SELECT *
FROM FabricanteMaisVeiculos;