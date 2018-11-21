

-- CLIENTE

DELIMITER $$
CREATE PROCEDURE historico_viagens(IN id_cliente INT)
BEGIN
	SELECT v.data_partida, eo.nome, v.data_chegada, ed.nome
    FROM bilhete AS b INNER JOIN viagem AS v
					  ON b.viagem = v.id_viagem
							INNER JOIN estacao AS eo
                            ON v.origem = eo.id_estacao
                            INNER JOIN estacao AS ed
                            ON v.destino = ed.id_estacao
	WHERE b.cliente = id_cliente;
END $$

CALL historico_viagens(1);



DELIMITER $$
CREATE PROCEDURE detalhes_viagem(IN id_bilhete INT)
BEGIN
	SELECT v.data_partida, eo.nome, v.data_chegada, ed.nome, v.duracao, b.preco, b.classe, b.numero
    FROM bilhete AS b INNER JOIN viagem AS v
					  ON b.viagem = v.id_viagem
							INNER JOIN estacao AS eo
                            ON v.origem = eo.id_estacao
                            INNER JOIN estacao AS ed
                            ON v.destino = ed.id_estacao
	WHERE b.id_bilhete = id_bilhete;
END $$

CALL detalhes_viagem(2);



DELIMITER $$
CREATE PROCEDURE viagens_between(IN id_estacao_o INT, id_estacao_d INT, data_inicio DATETIME, data_fim DATETIME)
BEGIN
	SELECT v.id_viagem, v.data_partida, v.data_chegada, v.duracao
    FROM viagem AS v
	WHERE v.data_partida > data_inicio AND v.data_chegada < data_fim
		  AND v.origem = id_estacao_o AND v.destino = id_estacao_d;
END $$

CALL viagens_between(1, 2, '2018-01-01 00:00:00', '2018-12-01 00:00:00'); 



DELIMITER $$
CREATE PROCEDURE lugares_livres(IN id_viagem INT)
BEGIN
	SELECT l.classe, l.numero
	FROM Viagem AS v INNER JOIN Comboio AS c
					 ON v.comboio = c.id_comboio
						INNER JOIN Lugar AS l
						ON c.id_comboio = l.comboio 
	WHERE (l.classe, l.numero) NOT IN (
		SELECT l.classe, l.numero
		FROM Viagem AS v
				INNER JOIN Bilhete as b
				ON v.id_viagem = viagem
					INNER JOIN lugar AS l
					ON (b.numero = l.numero AND b.classe = l.classe))
		  AND v.id_viagem = id_viagem;
END $$

CALL lugares_livres(1);



DELIMITER $$
CREATE PROCEDURE horario_partida_estacao(IN id_estacao INT)
BEGIN
	SELECT v.data_partida
    FROM estacao AS e INNER JOIN viagem AS v
					  ON e.id_estacao = v.origem
	WHERE e.id_estacao = id_estacao;
END $$

CALL horario_partida_estacao(1);



DELIMITER $$
CREATE PROCEDURE horario_chegada_estacao(IN id_estacao INT)
BEGIN
	SELECT v.data_chegada
    FROM estacao AS e INNER JOIN viagem AS v
					  ON e.id_estacao = v.destino
	WHERE e.id_estacao = id_estacao;
END $$

CALL horario_chegada_estacao(2);




-- ADMIN

DELIMITER $$
CREATE PROCEDURE viagens_comboio_between(id_comboio INT, data_inicio DATETIME, data_fim DATETIME)
BEGIN
	SELECT eo.nome AS 'Origem', v.data_partida, ed.nome AS 'Destino', v.data_chegada 
    FROM viagem AS v INNER JOIN comboio AS c
					 ON v.comboio = c.id_comboio
                     INNER JOIN estacao AS eo
                     ON v.origem = eo.id_estacao
                     INNER JOIN estacao AS ed
                     ON v.destino = ed.id_estacao
	WHERE (v.data_partida > data_inicio AND v.data_chegada < data_fim AND c.id_comboio = id_comboio);
END $$

CALL viagens_comboio_between(1, '2018-01-01 00:00:00', '2018-12-01 00:00:00');



DELIMITER $$
CREATE PROCEDURE clientes_between_estacoes(IN id_estacao_o INT, id_estacao_d INT, data_inicio DATETIME, data_fim DATETIME)
BEGIN
	SELECT c.id_cliente, c.nome, count(c.id_cliente) AS 'Número de bilhetes'
    FROM cliente AS c INNER JOIN bilhete AS b
					  ON c.id_cliente = b.cliente
						INNER JOIN viagem AS v
                        ON b.viagem = v.id_viagem
	WHERE v.data_partida > data_inicio AND v.data_chegada < data_fim
		  AND v.origem = id_estacao_o AND v.destino = id_estacao_d
	GROUP BY c.id_cliente;
END $$

CALL clientes_between_estacoes(1, 2, '2018-01-01 00:00:00', '2018-12-01 00:00:00');

