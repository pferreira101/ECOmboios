// (RE1)

 
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


db.eval(
    function(id, partida, chegada){
        var x = db.getCollection("Cliente").find(
                    { 
                        "$and" : [
                            {
                                "_id" : id
                            }, 
                            {
                                "bilhete.data_partida" : {
                                    "$gte" : ISODate(partida)
                                }
                            }, 
                            {
                                "bilhete.data_chegada" : {
                                    "$lte" : ISODate(chegada)
                                }
                            }
                        ]
                    }, 
                    { 
                        "bilhete.origem" : 1.0, 
                        "bilhete.destino" : 1.0
                    }
                );
        
        return x;
    }, 1.0, "2018-12-01T00:00:00.000+0000", "2018-12-10T00:00:00.000+0000"
);