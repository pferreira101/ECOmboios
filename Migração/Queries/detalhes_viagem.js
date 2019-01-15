// (RE3)

var id = 1;

function get_results (result) {
    print(tojson(result));
}


db.Cliente.find(
    { 
        "bilhetes._id" : id
    }, 
    {   
        "bilhetes.$" : 1,
        "_id" : 0,
        "bilhetes._id" : 1.0, 
        "bilhetes.origem" : 1.0, 
        "bilhetes.destino" : 1.0, 
        "bilhetes.duracao" : 1.0, 
        "bilhetes.preco" : 1.0, 
        "bilhetes.numero" : 1.0, 
        "bilhetes.classe" : 1.0, 
        "bilhetes.data_partida" : 1.0
    }
).forEach(get_results);