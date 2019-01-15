// (RE6)(1)

var origem = "Braga"
var data_partida = "2019-12-12T00:00:00Z";

function get_results (result) {
    print(tojson(result));
}


db.getCollection("Viagem").find(
    { 
        "$and" : [
            {
                "origem" : origem
            }, 
            {
                "data_partida" : {
                    "$gte" : ISODate(data_partida)
                }
            }
        ]
    }, 
    { 
        "bilhetes" : 0.0
    }
).forEach(get_results);