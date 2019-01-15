// (RE2)

var id = 1.0;
var data_inicio = "2018-11-01T00:00:00.000+0000";
var data_fim = "2018-12-10T00:00:00.000+0000";

function get_results (result) {
    print(tojson(result));
}


db.Cliente.aggregate(
	[
		{
			$unwind: "$bilhetes"
		},
		{
			$match: {
				"$and" : [
					{"bilhetes.data_aquisicao":  {"$gte" : ISODate(data_inicio)}},
					{"bilhetes.data_aquisicao":  { "$lte": ISODate(data_fim)}},
					{"_id" : id}]
			}
		},
		{
			$group: {
				_id: "$nome",
				Valor: {
					$sum: "$bilhetes.preco"
				}
			}
		}
	]
).forEach(get_results)
