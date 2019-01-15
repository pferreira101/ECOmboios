// (RE9)

var origem = "Braga";
var destino = "Porto";
var data_partida = "2018-11-14T00:00:00Z";
var data_chegada = "2019-12-16T00:00:00Z";


function get_results (result) {
    print(tojson(result));
}


db.getCollection("Cliente").find(
    { 
        "$and" : [
            {
                "bilhetes.origem" : origem
            }, 
            {
                "bilhetes.destino" : destino
            }, 
            {
                "bilhetes.data_partida" : {
                    "$gte" : ISODate(data_partida)
                }
            }, 
            {
                "bilhetes.data_chegada" : {
                    "$lte" : ISODate(data_chegada)
                }
            }
        ]
    }, 
    { 
        "nome" : 1.0
    }
).forEach(get_results);