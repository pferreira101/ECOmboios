
DELIMITER $$
CREATE FUNCTION total_gasto(id_cliente INT, data_inicio DATETIME, data_fim DATETIME)
	   RETURNS FLOAT DETERMINISTIC
BEGIN
	RETURN (SELECT sum(b.preco)
			FROM bilhete as b INNER JOIN viagem AS v
							  ON b.viagem = v.id_viagem
			WHERE b.cliente = id_cliente AND v.data_partida >= data_inicio AND v.data_chegada <= data_fim);

END $$

SELECT total_gasto(1, '2018-11-01', '2018-12-31');


DELIMITER $$
CREATE FUNCTION total_bilhetes_vendidos(d_inicio DATETIME, d_fim DATETIME)
	   RETURNS FLOAT DETERMINISTIC
BEGIN
	RETURN (SELECT count(b)
			FROM bilhete as b
			WHERE b.data_aquisicao >= d_inicio
				  AND b.data_aquisicao <= d_fim);
END $$


DELIMITER $$
CREATE FUNCTION total_faturado(d_inicio DATETIME, d_fim DATETIME)
	   RETURNS FLOAT DETERMINISTIC
BEGIN
	RETURN (SELECT sum(b.preco)
			FROM bilhete as b
			WHERE b.data_aquisicao >= d_inicio
				  AND b.data_aquisicao <= d_fim);
END $$


