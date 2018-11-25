
SELECT * FROM mysql.utlizador;
DESC mysql.utlizador;


-- ADMIN
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON ecomboios.* TO 'admin'@'localhost';


-- GESTOR
CREATE USER 'gestor'@'localhost' IDENTIFIED BY 'gestor';
GRANT SELECT (id_cliente, nome, email, nif) ON ecomboios.cliente TO 'gestor'@'localhost';
GRANT SELECT ON ecomboios.bilhete TO 'gestor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON ecomboios.viagem TO 'gestor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON ecomboios.estacao TO 'gestor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON ecomboios.comboio TO 'gestor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON ecomboios.lugar TO 'gestor'@'localhost';


-- UTILIZADOR
CREATE USER 'utlizador'@'localhost' IDENTIFIED BY 'utlizador';
GRANT INSERT ON ecomboios.cliente TO 'utlizador'@'localhost';
GRANT SELECT, INSERT ON ecomboios.bilhete TO 'utlizador'@'localhost';
GRANT SELECT ON ecomboios.viagem TO 'utlizador'@'localhost';
GRANT SELECT ON ecomboios.estacao TO 'utlizador'@'localhost';
GRANT SELECT ON ecomboios.lugar TO 'utlizador'@'localhost';



FLUSH PRIVILEGES;