// (RE1)

var id = 1;
var data_partida = "2018-12-01T00:00:00.000+0000";
var data_chegada = "2018-12-10T00:00:00.000+0000";


function get_results (result) {
    print(tojson(result));
}



db.Cliente.find(
    { 
        "$and" : [
            {
                "_id" : id
            }, 
            {
                "bilhetes.data_partida" : {
                    "$gte" : ISODate(data_partida),
                    "$lte" : ISODate(data_chegada)
                }
            }
        ]
    }, 
    { 
        "bilhetes.origem" : 1.0, 
        "bilhetes.destino" : 1.0,
        "bilhetes.data_partida" : 1.0,
        "bilhetes.data_chegada" : 1.0
    }
).forEach(get_results);
