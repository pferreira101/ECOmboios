// (RE10)

var id = 1;

function get_results (result) {
    print(tojson(result));
}

db.Viagem.aggregate([
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
	   $match: {"bilhetes.data_aquisicao": {$ne: null}}
   },
   {
	   $project: {
		   "bilhetes.cliente":1
	   }
   }
]).forEach(get_results)
