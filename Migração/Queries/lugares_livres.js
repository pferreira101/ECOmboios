// (RE5)
 
var id_viagem = 1;

function get_results (result) {
   print(tojson(result));
}

db.Viagem.aggregate(
	[
		{
			$match: {
				"_id": id_viagem
			}
		},
		{
			$unwind: 
				"$bilhetes"
		},
		{
			$match: {
				"bilhetes.data_aquisicao": null
			}
		}, 
		{
			$project: {
				"bilhetes.classe":1,
				"bilhetes.numero":1
			}
		}
	]
).forEach(get_results)