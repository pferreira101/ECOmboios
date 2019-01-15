// (RE8)

var comboio = 1;
var data_inicio = "2018-11-14T00:00:00Z";
var data_fim = "2019-12-16T00:00:00Z";


function get_results (result) {
    print(tojson(result));
}


db.getCollection("Viagem").find(
    { 
        "$and" : [
            {
                "comboio" : 1.0
            }, 
            {
                "data_partida" : {
                    "$gte" : ISODate(data_inicio)
                }
            }, 
            {
                "data_chegada" : {
                    "$lte" : ISODate(data_fim)
                }
            }
        ]
    }, 
    { 
        "comboio" : 0.0, 
        "bilhetes" : 0.0
    }
).forEach(get_results);