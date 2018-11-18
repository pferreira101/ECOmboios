USE comboios;

-- CLIENTES
INSERT INTO cliente(nome, email, nif, password)
VALUES ('Alberto Caeiro', 'albertinho1@gmail.com', 111111111, 'heteronimo'),
	   ('Ricardo Reis', 'reidistotudo@hotmail.com', 222222222, 'souMedico'),
	   ('Álvaro de Campos', 'alvarinho@tinto.com', 333333333, 'EngenheiroSouEu');
       
SELECT * FROM cliente;
       
       
-- TELEMOVEL de CLIENTES
INSERT INTO telemovelcliente 
VALUES (919921332, 1),
	   (931238771, 1),
       (981234702, 2),
       (961238712, 3);
       
SELECT c.nome, tc.telemovel
FROM cliente AS c INNER JOIN telemovelcliente AS tc
				  ON c.id_cliente = tc.cliente_id;
                  
                  
                  
-- ESTACAO
INSERT INTO estacao(nome)
VALUES ('Braga'), ('Porto'), ('Lisboa');

SELECT * FROM estacao;



-- COMBOIO (executar uma vez para adicionar um comboio)
INSERT INTO comboio
VALUES ();

SELECT * FROM comboio;


-- LUGAR
INSERT INTO 


-- VIAGEM
INSERT INTO viagem(data_partida, data_chegada, comboio, origem, destino)
VALUES ('2018-11-18 13:00:00', '2018-11-18 13:20:00', 1, 1, 2)
	   ('2018-11-18 14:00:00', '2018-11-18 15:15:00', 2, 3, 2);

SELECT * FROM viagem;

SELECT v.data_partida, v.data_chegada, v.duracao, eo.nome AS origem, ed.nome AS destino
FROM viagem AS v INNER JOIN estacao AS eo
				 ON v.origem = eo.id_estacao
                 INNER JOIN estacao AS ed
                 ON v.destino = ed.id_estacao;