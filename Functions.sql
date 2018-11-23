
DELIMITER $$
CREATE FUNCTION total_gasto(id_cliente INT)
	   RETURNS FLOAT DETERMINISTIC
BEGIN
	RETURN (SELECT sum(b.preco)
			FROM bilhete as b
			WHERE b.cliente = id_cliente);

END $$

SELECT total_gasto(2);

DELIMITER $$
CREATE FUNCTION total_bilhetes_vendidos(d_inicio DATETIME,d_fim DATETIME)
	   RETURNS FLOAT DETERMINISTIC
BEGIN
	RETURN (SELECT count(b)
			FROM bilhete as b
			WHERE b.data_aquisicao >= d_inicio
				AND b.data_aquisicao <= d_fim);
END $$


DELIMITER $$
CREATE FUNCTION total_faturado(d_inicio DATETIME,d_fim DATETIME)
	   RETURNS FLOAT DETERMINISTIC
BEGIN
	RETURN (SELECT sum(b.preco)
			FROM bilhete as b
			WHERE b.data_aquisicao >= d_inicio
				AND b.data_aquisicao <= d_fim);
END $$


