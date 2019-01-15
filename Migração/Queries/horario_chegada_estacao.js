// (RE6)(2)

var destino = "Porto";
var data_chegada = "2019-12-12T00:00:00Z";

function get_results (result) {
    print(tojson(result));
}


db.getCollection("Viagem").find(
    { 
        "$and" : [
            {
                "destino" : destino
            }, 
            {
                "data_chegada" : {
                    "$gte" : ISODate(data_chegada)
                }
            }
        ]
    }, 
    { 
        "bilhetes" : 0.0
    }
).forEach(get_results);