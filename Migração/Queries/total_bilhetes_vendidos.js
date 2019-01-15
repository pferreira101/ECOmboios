// (RE11)

var data_inicio = "2018-11-16T00:00:00Z";
var data_fim = "2018-11-31T00:00:00Z";

	function get_results (result) {
	    print(tojson(result));

	}

db.Viagem.aggregate([
	{
		$unwind: "$bilhetes"
	},
	{
		$match: {"bilhetes.data_aquisicao": {$ne: null}}
	},
	{
		$match: {
				"bilhetes.data_aquisicao": {
					$gte: ISODate(data_inicio),
					$lte: ISODate(data_fim)}
		}
	},
	{
		$group: {
			_id: null,
			num_bilhetes: {
				$sum: 1 }
			}
	}
]).forEach(get_results)
