import oracle.kv.*;

import java.sql.*;
import java.util.Arrays;
import java.util.Map;

/**
 * Created by efb4 on 5/11/2017.
 * LoadDB - Pulls data from the OracleXE IMDB Movie, Actor and Role tables respectively, and pairs them with their ID numbers
 * Key-Value structures are created for each table to support the queries. I think query the tables for their respective values
 * from the other Java files created.
 *
 */
public class loadDB {

    private static KVStore store;
    private static Connection jdbcConnection;

    public static void main(String[] args) throws SQLException {
        store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");

        getMovies();
        getActors();
        getRoles();

        jdbcConnection.close();
        store.close();
    }

    public static void getMovies() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie");
        while (resultSet.next()) {
            Integer movieID = resultSet.getInt(1);
            String rank = resultSet.getString(4);

            //create key-value pair
            Key nameKey = Key.createKey(Arrays.asList("movie", movieID.toString()), Arrays.asList("name"));
            Value nameValue = Value.createValue(resultSet.getString(2).getBytes());
            store.put(nameKey, nameValue);

            Key yearKey = Key.createKey(Arrays.asList("movie", movieID.toString()), Arrays.asList("year"));
            Value yearValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(yearKey, yearValue);

            Key rankKey = Key.createKey(Arrays.asList("movie", movieID.toString()), Arrays.asList("rank"));
            Value rankValue = Value.createValue("".getBytes());
            if (rank != null) { //check for null ranks
                rankValue = Value.createValue(rank.getBytes());
            }
            store.put(rankKey, rankValue);
        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void getActors() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, firstName, lastName FROM Actor");
        while (resultSet.next()) {
            Integer actorID = resultSet.getInt(1);

            Key fnameKey = Key.createKey(Arrays.asList("actor", actorID.toString()), Arrays.asList("firstName"));
            Value fnameValue = Value.createValue(resultSet.getString(2).getBytes());
            store.put(fnameKey, fnameValue);

            Key lnameKey = Key.createKey(Arrays.asList("actor", actorID.toString()), Arrays.asList("lastName"));
            Value lnameValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(lnameKey, lnameValue);
        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void getRoles() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT actorId, movieId, role FROM Role");
        while (resultSet.next()) {
            Key roleKey = Key.createKey(Arrays.asList("role", resultSet.getString(2)), Arrays.asList(resultSet.getString(3)));
            Value roleValue = Value.createValue(resultSet.getString(1).getBytes());
            store.put(roleKey, roleValue);

            Map<Key, ValueVersion> fields = store.multiGet(roleKey, null, null);
            for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
                String fieldName = field.getKey().getMinorPath().get(0);
                String fieldValue = new String(field.getValue().getValue().getValue());
                System.out.println("\t" + fieldName + "\t: " + fieldValue);
            }
        }
        resultSet.close();
        jdbcStatement.close();
    }
}
