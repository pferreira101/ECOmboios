
SELECT * FROM mysql.user;
DESC mysql.user;


-- ADMIN
CREATE USER 'admin'@'127.0.0.1' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON ecomboios.* TO 'admin'@'127.0.0.1';


-- PROGRAMADOR
CREATE USER 'programador'@'127.0.0.1' IDENTIFIED BY 'programador';
GRANT SELECT (id_cliente, nome, email, nif) ON ecomboios.cliente TO 'programador'@'127.0.0.1';
GRANT SELECT ON ecomboios.bilhete TO 'programador'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON ecomboios.viagem TO 'programador'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON ecomboios.estacao TO 'programador'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON ecomboios.comboio TO 'programador'@'127.0.0.1';
GRANT SELECT, INSERT, UPDATE ON ecomboios.lugar TO 'programador'@'127.0.0.1';


-- USER
CREATE USER 'user'@'127.0.0.1' IDENTIFIED BY 'user';
GRANT INSERT ON ecomboios.cliente TO 'user'@'127.0.0.1';
GRANT SELECT, INSERT ON ecomboios.bilhete TO 'user'@'127.0.0.1';
GRANT SELECT ON ecomboios.viagem TO 'user'@'127.0.0.1';
GRANT SELECT ON ecomboios.estacao TO 'user'@'127.0.0.1';
GRANT SELECT ON ecomboios.lugar TO 'user'@'127.0.0.1';
-- E PARA OS COMBOIOS? O CLIENTE PODE VE-LOS?



FLUSH PRIVILEGES;