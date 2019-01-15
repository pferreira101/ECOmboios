// (RE10)

var id = 1;

function get_results (result) {
    print(tojson(result));
}

db.getCollection("Viagem").find(
    { 
        "_id" : id
    }, 
    { 
        "bilhetes.cliente" : 1.0
    }
).forEach(get_results);