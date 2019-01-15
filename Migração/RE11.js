var data_inicio = "2018-11-14T00:00:00Z";
var data_fim = "2018-11-16T00:00:00Z";

function get_results (result) {
    print(tojson(result));
}


db.Viagem.aggregate(
	[ 
		{ 
			$match: { 
					"bilhetes.data_aquisicao": 
						{
							$gte: ISODate(data_inicio), 
							$lte: ISODate(data_fim)
						}
					}
		}, 
		{
			$unwind: "$bilhetes"
		}, 
		{ 
			$group: 
				{ 
					_id: null, 
					num_bilhetes: { 
					$sum: 1 } 
				} 
			}
	]
).forEach(get_results)