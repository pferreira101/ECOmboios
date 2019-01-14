// (RE1)


var id1 = 1.0;
var data1 = "2018-12-01T00:00:00.000+0000";
var data2 = "2018-12-10T00:00:00.000+0000";

function get_results (result) {
    print(tojson(result));
}


db.Cliente.find(
    {
        "$and" : [
            {
                "_id" : id1
            },
            {
                "bilhete.data_partida" : {
                    "$gte" : ISODate(data1)
                }
            },
            {
                "bilhete.data_chegada" : {
                    "$lte" : ISODate(data2)
                }
            }
        ]
    },
    {
        "bilhete.origem" : 1.0,
        "bilhete.destino" : 1.0
    }
).forEach(get_results);
