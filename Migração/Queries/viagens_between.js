// (RE4)

var data_inicio = "2018-11-14T00:00:00Z";
var data_fim = "2019-12-16T00:00:00Z"; 
var origem = "Braga";
var destino = "Porto";

function get_results (result) {
    print(tojson(result));
}


db.getCollection("Viagem").find(
    { 
        "$and" : [
            {
                "data_partida" : ISODate(data_inicio)
            }, 
            {
                "data_chegada" : ISODate(data_fim)
            }, 
            {
                "origem" : origem
            }, 
            {
                "destino" : destino
            }
        ]
    }, 
    { 
        "preco_base" : 1.0, 
        "data_partida" : 1.0, 
        "data_chegada" : 1.0, 
        "duracao" : 1.0, 
        "origem" : 1.0, 
        "destino" : 1.0
    }
).forEach(get_results);