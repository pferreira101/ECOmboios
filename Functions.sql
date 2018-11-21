
DELIMITER $$
CREATE FUNCTION total_gasto(id_cliente INT)
	   RETURNS FLOAT DETERMINISTIC
BEGIN
	RETURN (SELECT sum(b.preco)
			FROM bilhete as b
			WHERE b.cliente = id_cliente);

END $$

SELECT total_gasto(2);


