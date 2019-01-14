import com.mongodb.BasicDBObject;
import com.mongodb.BulkWriteOperation;
import com.mongodb.BulkWriteResult;
import com.mongodb.Cursor;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;
import com.mongodb.ParallelScanOptions;
import com.mongodb.ServerAddress;

import java.lang.reflect.Array;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import static java.util.concurrent.TimeUnit.SECONDS;

class Cliente{

    int id;
    String nome;
    String email;
    int nif;
    String password;
    List<Bilhete> bilhetes = new ArrayList<>();

}

class Bilhete{
    int id;
    float preco;
    LocalDate aquisicao;
    char classe;
    int numero;
    int cliente;
    int viagem;
    LocalDate partida;
    LocalDate chegada;
    String origem;
    String destino;
    LocalDate duracao;
}

class Comboio{
    int id;
    List<Lugar> lugares = new ArrayList<>();
}

class Lugar{
    int comboio;
    char classe;
    int numero;
}

class Viagem{
    int id;
    LocalDate partida;
    LocalDate chegada;
    LocalDate duracao;
    float preco_base;
    int comboio;
    String origem_nome;
    String destino_nome;
}


public class Test {

    static MongoClient mongoClient = new MongoClient("localhost", 27017);


    private static void loadComboios() throws SQLException {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/ecomboios", "root", "12345");

        PreparedStatement st;
        st = con.prepareStatement("SELECT * FROM comboio;");

        ResultSet rs = st.executeQuery();
        while(rs.next()) {
            Comboio c = new Comboio();
            c.id = rs.getInt("id_comboio");

            PreparedStatement aux = con.prepareStatement("SELECT DISTINCT l.* " +
                                                         "FROM comboio AS c INNER JOIN lugar AS l " +
                                                                            "ON ? = l.comboio;");
            aux.setInt(1, c.id);

            ResultSet rs_aux = aux.executeQuery();
            while (rs_aux.next()){
                Lugar l = new Lugar();
                l.comboio = c.id;
                l.numero = rs_aux.getInt("numero");
                l.classe = rs_aux.getString("classe").charAt(0);
                c.lugares.add(l);
            }

            mongoAddComboio(c);
        }
    }

    private static void mongoAddComboio(Comboio c) {
        DB db = mongoClient.getDB("ecomboios");
        DBCollection coll = db.getCollection("Comboio");

        List<BasicDBObject> lugares = new ArrayList<>();
        for(Lugar l : c.lugares){
            BasicDBObject b = new BasicDBObject("classe", l.classe)
                                        .append("numero", l.numero);

            lugares.add(b);
        }
        DBObject doc = new BasicDBObject("_id", c.id)
                                      .append("lugar", lugares);

        coll.insert(doc);
    }


    private static void loadClientes() throws Exception {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/ecomboios", "root", "12345");

        PreparedStatement st;
        st = con.prepareStatement("SELECT * FROM cliente;");

        ResultSet rs = st.executeQuery();
        while(rs.next()) {
            Cliente c = new Cliente();
            c.id = rs.getInt("id_cliente");
            c.nome = rs.getString("nome");
            c.email = rs.getString("email");
            c.nif = rs.getInt("nif");
            c.password = rs.getString("password");

            PreparedStatement aux = con.prepareStatement("SELECT b.*, v.*, eo.nome AS 'origem_nome', ed.nome AS 'destino_nome' " +
                    "FROM cliente AS c INNER JOIN bilhete AS b " +
                    "ON c.id_cliente = b.cliente " +
                    "                  INNER JOIN viagem as v " +
                    "                  ON b.viagem = v.id_viagem " +
                    "                  INNER JOIN estacao AS eo " +
                    "ON v.origem = eo.id_estacao " +
                    "                  INNER JOIN estacao AS ed " +
                    "                  ON v.destino = ed.id_estacao " +
                    "WHERE b.cliente = ?;");

            aux.setInt(1, c.id);

            ResultSet rs_aux = aux.executeQuery();
            while (rs_aux.next()){
                Bilhete b = new Bilhete();
                b.id = rs_aux.getInt("id_bilhete");
                b.preco = (float) rs_aux.getDouble("preco");
                b.aquisicao = rs_aux.getDate("data_aquisicao").toLocalDate();
                b.classe = rs_aux.getString("classe").charAt(0);
                b.numero = rs_aux.getInt("numero");
                b.viagem = rs_aux.getInt("viagem");
                b.partida = rs_aux.getDate("data_partida").toLocalDate();
                b.chegada = rs_aux.getDate("data_chegada").toLocalDate();
                b.duracao = rs_aux.getDate("duracao").toLocalDate();
                b.origem = rs_aux.getString("origem_nome");
                b.destino = rs_aux.getString("destino_nome");

                c.bilhetes.add(b);
            }

            mongoAddCliente(c);

        }

        con.close();
    }

    private static void mongoAddCliente(Cliente c) {
        DB db = mongoClient.getDB("ecomboios");
        DBCollection coll = db.getCollection("Cliente");

        List<BasicDBObject> bilhetes = new ArrayList<>();
        for(Bilhete b : c.bilhetes){
            BasicDBObject obj = new BasicDBObject("_id", b.id)
                                            .append("preco", b.preco)
                                            .append("data_aquisicao", b.aquisicao)
                                            .append("classe", b.classe)
                                            .append("numero", b.numero)
                                            .append("data_partida", b.partida)
                    .append("data_chegada", b.chegada)
                    .append("duracao", b.duracao)
                    .append("origem", b.origem)
                    .append("destino", b.destino);


            bilhetes.add(obj);
        }

        BasicDBObject doc = new BasicDBObject("_id", c.id)
                                    .append("nome", c.nome)
                                    .append("email", c.email)
                                    .append("nif", c.nif)
                                    .append("password", c.password)
                                    .append("bilhete", bilhetes);

        coll.insert(doc);
    }

    private static void loadBilhetes() {

    }


    private static void loadViagem() throws SQLException {
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost/ecomboios", "root", "12345");

        PreparedStatement st;
        st = con.prepareStatement("SELECT * " +
                                  "FROM viagem AS v INNER JOIN estacao AS eo " +
                                                    "ON v.origem = eo.id_estacao " +
                                                    "INNER JOIN estacao AS ed " +
                                                    "ON v.destino = ed.id_estacao;");

        ResultSet rs = st.executeQuery();
        while(rs.next()) {
            Viagem v = new Viagem();
            v.id = rs.getInt("id_viagem");
            v.partida = rs.getDate("data_partida").toLocalDate();
            v.chegada = rs.getDate("data_chegada").toLocalDate();
            v.duracao = rs.getDate("duracao").toLocalDate();
            v.preco_base = rs.getFloat("preco_base");
            v.comboio = rs.getInt("comboio");
            v.origem_nome = rs.getString(10);
            v.destino_nome = rs.getString(12);

            List<Bilhete> bilhetes = new ArrayList<>();

            PreparedStatement st_aux = con.prepareStatement("SELECT b.* " +
                                                            "FROM viagem as v INNER JOIN bilhete as b " +
                                                                             "ON b.viagem = v.id_viagem " +
                                                            "WHERE v.id_viagem = ?;");
            st_aux.setInt(1, v.id);

            ResultSet rs_aux = st_aux.executeQuery();
            while(rs_aux.next()){
                Bilhete b = new Bilhete();
                b.id = rs_aux.getInt("id_bilhete");
                b.preco = rs_aux.getFloat("preco");
                b.aquisicao = rs_aux.getDate("data_aquisicao").toLocalDate();
                b.classe = rs_aux.getString("classe").charAt(0);
                b.numero = rs_aux.getInt("numero");
                b.cliente = rs_aux.getInt("cliente");

                bilhetes.add(b);
            }


            mongoAddViagem(v, bilhetes);
        }
    }

    private static void mongoAddViagem(Viagem v, List<Bilhete> bilhetes){
        DB db = mongoClient.getDB("ecomboios");
        DBCollection coll = db.getCollection("Viagem");


        List<BasicDBObject> bilhetes_obj = new ArrayList<>();
        for(Bilhete b : bilhetes){
            BasicDBObject x = new BasicDBObject("_id", b.id)
                                        .append("preco", b.preco)
                                        .append("data_aquisicao", b.aquisicao)
                                        .append("classe", b.classe)
                                        .append("numero", b.numero)
                                        .append("cliente", b.cliente);

            bilhetes_obj.add(x);
        }

        BasicDBObject obj = new BasicDBObject("_id", v.id)
                                      .append("preco_base", v.preco_base)
                                      .append("data_partida", v.partida)
                                      .append("data_chegada", v.chegada)
                                      .append("duracao", v.duracao)
                                      .append("comboio", v.comboio)
                                      .append("origem", v.origem_nome)
                                      .append("destino", v.destino_nome)
                                      .append("bilhetes", bilhetes_obj);



        coll.insert(obj);
    }


    public static void main(String args[]) throws Exception {


        loadClientes();
        loadBilhetes();
        loadComboios();
        loadViagem();





/*
        List<BasicDBObject> array = new ArrayList<>();

        BasicDBObject b = new BasicDBObject("id", c.id)
                .append("preco", c.nome);

        array.add(b);

        //DBObject myDoc = coll.findOne();
        //System.out.println(myDoc);

        DBCursor cursor = coll.find();
        try {
            while(cursor.hasNext()) {
                System.out.println(cursor.next());
            }
        } finally {
            cursor.close();
        }*/
    }




}
