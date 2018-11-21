USE comboios;

-- CLIENTES
INSERT INTO cliente(nome, email, nif, password)
VALUES ('Alberto Caeiro', 'albertinho1@gmail.com', 111111111, 'heteronimo'),
	   ('Ricardo Reis', 'reidistotudo@hotmail.com', 222222222, 'souMedico'),
	   ('Álvaro de Campos', 'alvarinho@tinto.com', 333333333, 'EngenheiroSouEu');
       
SELECT * FROM cliente;
                  
                  
                  
-- ESTACAO
INSERT INTO estacao(nome)
VALUES ('Braga'), ('Porto'), ('Lisboa');

SELECT * FROM estacao;



-- COMBOIO (executar uma vez para adicionar um comboio)
INSERT INTO comboio
VALUES ();

SELECT * FROM comboio;


-- LUGAR
INSERT INTO lugar(classe, numero, comboio)
VALUES ('P', 1, 1),
	   ('P', 2, 1),
       ('P', 3, 1),
       ('P', 4, 1),
       ('P', 5, 1),
       ('P', 6, 1),
       ('P', 7, 1),
       ('P', 8, 1),
       ('E', 1, 1),
       ('E', 2, 1),
       ('E', 3, 1),
       ('E', 4, 1),
       ('E', 5, 1),
       ('E', 6, 1),
       ('E', 7, 1),
       ('E', 8, 1);
       
SELECT * FROM lugar ORDER BY classe;

-- VIAGEM
INSERT INTO viagem(data_partida, data_chegada, preco_base, comboio, origem, destino)
VALUES ('2018-11-19 13:00:00', '2018-11-19 13:20:00', 10.00, 1, 1, 2),
	   ('2018-11-19 14:00:00', '2018-11-19 15:15:00', 25.00, 2, 3, 2);

SELECT * FROM viagem;

SELECT v.data_partida, v.data_chegada, v.duracao, eo.nome AS origem, ed.nome AS destino
FROM viagem AS v INNER JOIN estacao AS eo
				 ON v.origem = eo.id_estacao
                 INNER JOIN estacao AS ed
                 ON v.destino = ed.id_estacao;
                 
                 
                 
-- BILHETE
INSERT INTO bilhete(data_aquisicao, classe, numero, cliente, viagem)
VALUES ('2018-11-05 11:27:36', 'P', 2, 1, 1),
	   (now(), 'E', 2, 2, 1);
       
SELECT * FROM bilhete;

SELECT c.nome, eo.nome AS origem, ed.nome AS destino, v.duracao, b.preco, b.classe, b.numero
FROM cliente AS c INNER JOIN bilhete AS b
				  ON c.id_cliente = b.cliente
					INNER JOIN viagem AS v
                    ON b.viagem = v.id_viagem
						INNER JOIN estacao AS eo
                        ON v.origem = eo.id_estacao
                        INNER JOIN estacao AS ed
                        ON v.destino = ed.id_estacao;
				
				