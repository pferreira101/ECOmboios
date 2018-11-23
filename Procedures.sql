

-- CLIENTE

DELIMITER $$
CREATE PROCEDURE historico_viagens(IN id_cliente INT)
BEGIN
	SELECT v.data_partida AS 'Data de Partida', eo.nome AS 'Origem', v.data_chegada  AS 'Data de Chegada', ed.nome AS 'Destino'
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
	SELECT v.data_partida AS 'Data de Partida', eo.nome AS 'Origem', v.data_chegada AS 'Data de Chegada', ed.nome AS 'Destino', v.duracao AS 'Duração', b.preco AS 'Preço', b.classe AS 'Classe', b.numero AS 'Lugar'
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
	SELECT v.id_viagem AS 'ID', v.data_partida AS 'Data de Partida', v.data_chegada AS 'Data de Chegada', v.duracao AS 'Duração'
    FROM viagem AS v
	WHERE v.data_partida > data_inicio AND v.data_chegada < data_fim
		  AND v.origem = id_estacao_o AND v.destino = id_estacao_d;
END $$

CALL viagens_between(1, 2, '2018-01-01 00:00:00', '2018-12-01 00:00:00'); 



DELIMITER $$
CREATE PROCEDURE lugares_livres(IN id_viagem INT)
BEGIN
	SELECT l.classe AS 'Classe', l.numero AS 'Lugar'
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


-- Devia ser v.data_partida > NOW()
DELIMITER $$
CREATE PROCEDURE horario_partida_estacao(IN id_estacao INT)
BEGIN
	SELECT v.data_partida AS 'Data de Partida', d.nome AS 'Destino'
    FROM estacao AS e INNER JOIN viagem AS v
					  ON e.id_estacao = v.origem
                      INNER JOIN Estacao AS D
                      ON v.destino = d.id_estacao
	WHERE e.id_estacao = id_estacao
		AND v.data_partida > NOW();
END $$

CALL horario_partida_estacao(1);


-- Devia ser v.data_chegada > NOW()
DELIMITER $$
CREATE PROCEDURE horario_chegada_estacao(IN id_estacao INT)
BEGIN
	SELECT v.data_chegada AS 'Data de Chegada', d.nome AS 'Origem'
    FROM estacao AS e INNER JOIN viagem AS v
					  ON e.id_estacao = v.destino
                      INNER JOIN Estacao AS D
                      ON v.destino = d.id_estacao
	WHERE e.id_estacao = id_estacao
		AND v.data_chegada > NOW();
END $$

CALL horario_chegada_estacao(2);




-- ADMIN

DELIMITER $$
CREATE PROCEDURE viagens_comboio_between(id_comboio INT, data_inicio DATETIME, data_fim DATETIME)
BEGIN
	SELECT eo.nome AS 'Origem', v.data_partida AS 'Data de Partida', ed.nome AS 'Destino', v.data_chegada AS 'Data de Chegada'
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


DELIMITER $$
CREATE PROCEDURE clientes_na_viagem(IN id_viagemp INT)
BEGIN
	SELECT c.nome AS Nome, c.id_cliente AS ID
		FROM Bilhete b, Cliente c
        WHERE b.viagem = id_viagemp
			AND b.cliente = c.id_cliente;
END $$
