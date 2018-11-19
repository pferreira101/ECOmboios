-- Todos os lugares de uma viagem
SELECT v.id_viagem, l.classe, l.numero
FROM VIagem AS v 
			INNER JOIN Comboio AS c
			ON v.comboio = c.id_comboio
					INNER JOIN Lugar AS l
					ON c.id_comboio = l.comboio;
                    
-- Lugares ja ocupados numa viagem
SELECT  v.id_viagem, l.classe, l.numero
FROM Viagem AS v
			INNER JOIN Bilhete as b
			ON v.id_viagem = b.viagem
					INNER JOIN LugarBilhete as lb
                    ON b.id_bilhete = lb.bilhete_id
							INNER JOIN Lugar as l
							ON lb.lugar_id = l.id_lugar;
                            
-- Lugares livres numa viagem
SELECT v.id_viagem, l.classe, l.numero
FROM VIagem AS v 
			INNER JOIN Comboio AS c
			ON v.comboio = c.id_comboio
					INNER JOIN Lugar AS l
					ON c.id_comboio = l.comboio 
WHERE (v.id_viagem, l.classe, l.numero) NOT IN (
	SELECT  v.id_viagem, l.classe, l.numero
	FROM Viagem AS v
			INNER JOIN Bilhete as b
			ON v.id_viagem = b.viagem
					INNER JOIN LugarBilhete as lb
                    ON b.id_bilhete = lb.bilhete_id
							INNER JOIN Lugar as l
							ON lb.lugar_id = l.id_lugar);  
   
                                                   
                            

