
CREATE VIEW proxima_viagens AS SELECT o.nome as Origem, v.data_partida as 'Data Partida', d.nome as Destino, v.data_chegada as 'Data Chegada' FROM Viagem as V INNER JOIN Estacao as O
	ON v.origem = o.id_estacao
    INNER JOIN Estacao as D
		ON v.destino = d.id_estacao
	WHERE v.data_partida >= now()
    ORDER BY v.data_partida ASC;



CREATE VIEW estacoes_existentes AS
SELECT nome
FROM estacao;

SELECT * FROM estacoes_existentes;
