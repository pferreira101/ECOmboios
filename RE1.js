

// RE1 - (id, data_partida, data_chegada)
 
db.getCollection("Cliente").find(
    { 
        "$and" : [
            {
                "_id" : 1.0
            }, 
            {
                "bilhete.data_partida" : {
                    "$gte" : ISODate("2018-12-01T00:00:00.000+0000")
                }
            }, 
            {
                "bilhete.data_chegada" : {
                    "$lte" : ISODate("2018-12-10T00:00:00.000+0000")
                }
            }
        ]
    }, 
    { 
        "bilhete.origem" : 1.0, 
        "bilhete.destino" : 1.0
    }
);



// RE3 - (id)

db.getCollection("Cliente").find(
    { 
        "bilhetes._id" : 1.0
    }, 
    { 
        "bilhetes._id" : 1.0, 
        "bilhetes.origem" : 1.0, 
        "bilhetes.destino" : 1.0, 
        "bilhetes.duracao" : 1.0, 
        "bilhetes.preco" : 1.0, 
        "bilhetes.numero" : 1.0, 
        "bilhetes.classe" : 1.0, 
        "bilhetes.data_partida" : 1.0
    }
);



// RE4 - (data_partida, data_chegada, origem, destino)

db.getCollection("Viagem").find(
    { 
        "$and" : [
            {
                "data_partida" : ISODate("2018-12-01T00:00:00.000+0000")
            }, 
            {
                "data_chegada" : ISODate("2018-12-01T00:00:00.000+0000")
            }, 
            {
                "origem" : "Porto"
            }, 
            {
                "destino" : "Braga"
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
);


// RE6 - (origem, data_partida)

db.getCollection("Viagem").find(
    { 
        "$and" : [
            {
                "origem" : "Braga"
            }, 
            {
                "data_partida" : {
                    "$gte" : ISODate("2018-10-01T00:00:00.000+0000")
                }
            }
        ]
    }, 
    { 
        "bilhetes" : 0.0
    }
);


// RE8 - (comboio, data_partida, data_chegada)
db.getCollection("Viagem").find(
    { 
        "$and" : [
            {
                "comboio" : 1.0
            }, 
            {
                "data_partida" : {
                    "$gte" : ISODate("2018-11-11T00:00:00.000+0000")
                }
            }, 
            {
                "data_chegada" : {
                    "$lte" : ISODate("2019-01-01T00:00:00.000+0000")
                }
            }
        ]
    }, 
    { 
        "comboio" : 0.0, 
        "bilhetes" : 0.0
    }
);


// RE9 - (origem, destino, data_partida, data_chegada)
db.getCollection("Cliente").find(
    { 
        "$and" : [
            {
                "bilhetes.origem" : "Braga"
            }, 
            {
                "bilhetes.destino" : "Porto"
            }, 
            {
                "bilhetes.data_partida" : {
                    "$gte" : ISODate("2018-01-01T00:00:00.000+0000")
                }
            }, 
            {
                "bilhetes.data_chegada" : {
                    "$lte" : ISODate("2019-01-01T00:00:00.000+0000")
                }
            }
        ]
    }, 
    { 
        "nome" : 1.0
    }
);