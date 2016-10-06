/* Script of EXECUTE: PROCEDURES and FUNCTIONS ----------------------------------------------------------*/

-- 1)  Chamada da PROCEDURE OSsDeCliente para saber as Ordens de Serviço que determinado cliente fez
	CALL OSsDeCliente('J%');
-- 2)  Chamada da PROCEDURE para calcular o somatório das OSs cujas datas de entrega terminam na data especificada
	CALL SomaValorOsData('2015-08-28');