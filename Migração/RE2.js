var id1 = 1.0;
var data1 = "2018-11-01T00:00:00.000+0000";
var data2 = "2018-12-10T00:00:00.000+0000";

function get_results (result) {
    print(tojson(result));
}


db.Cliente.aggregate(
	[
		{
			$match: {
				"$and" : [
		            {"bilhete.data_aquisicao":  {"$gte" : ISODate(data1)}},
		            {"bilhete.data_aquisicao":  { "$lte": ISODate(data2)}},
		            {"_id" : id1}]
			}
		},
		{
			$unwind: "$bilhete"
		},
		{
			$group: {
				_id: "$nome",
				Valor: {
					$sum: "$bilhete.preco"
				}
			}
		}
	]
).forEach(get_results)
