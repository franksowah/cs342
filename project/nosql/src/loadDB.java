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
                "jdbc:oracle:thin:@localhost:1521:xe", "efb4", "MonkeyHat8");

        getArtistes();
        getMentors();
        getSongs();
        getPerformances();

        jdbcConnection.close();
        store.close();
    }

    public static void getArtistes() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year, email FROM Artiste");
        while (resultSet.next()) {
            Integer artisteID = resultSet.getInt(1);

            //create key-value pair
            Key nameKey = Key.createKey(Arrays.asList("artiste", artisteID.toString()), Arrays.asList("name"));
            Value nameValue = Value.createValue(resultSet.getString(2).getBytes());
            store.put(nameKey, nameValue);

            Key yearKey = Key.createKey(Arrays.asList("artiste", artisteID.toString()), Arrays.asList("year"));
            Value yearValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(yearKey, yearValue);

            Key emailKey = Key.createKey(Arrays.asList("artiste", artisteID.toString()), Arrays.asList("email"));
            Value emailValue = Value.createValue(resultSet.getString(4).getBytes());
            store.put(emailKey, emailValue);

//            System.out.println(resultSet.getInt(1) + "\t" + resultSet.getString(2) + "\t"
//                    + resultSet.getString(3) + "\t" + resultSet.getString(4));
        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void getMentors() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name FROM Mentor");
        while (resultSet.next()) {
            Integer mentorID = resultSet.getInt(1);

            Key nameKey = Key.createKey(Arrays.asList("mentor", mentorID.toString()), Arrays.asList("name"));
            Value nameValue = Value.createValue(resultSet.getString(2).getBytes());
            store.put(nameKey, nameValue);

//            System.out.println(resultSet.getInt(1) + "\t" + resultSet.getString(2));

        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void getSongs() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, title, genre, lyrics FROM Song");
        while (resultSet.next()) {

            Integer songID = resultSet.getInt(1);

            Key lyricsgKey = Key.createKey(Arrays.asList("song", songID.toString()), Arrays.asList("lyrics"));
            Value lyricsValue = Value.createValue(resultSet.getString(4).getBytes());
            store.put(lyricsgKey, lyricsValue);

            Key titleKey = Key.createKey(Arrays.asList("song",songID.toString()), Arrays.asList("title"));
            Value titleValue = Value.createValue(resultSet.getString(2).getBytes());
            store.put(titleKey, titleValue);

            Key genreKey = Key.createKey(Arrays.asList("song", songID.toString()), Arrays.asList("genre"));
            Value genreValue = Value.createValue(resultSet.getString(3).getBytes());
            store.put(genreKey, genreValue);

            Map<Key, ValueVersion> fields = store.multiGet(titleKey, null, null);
            for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
                String fieldName = field.getKey().getMinorPath().get(0);
                String fieldValue = new String(field.getValue().getValue().getValue());
                System.out.println("\t" + fieldName + "\t: " + fieldValue);
            }
        }
        resultSet.close();
        jdbcStatement.close();
    }

    public static void getPerformances() throws SQLException {
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, venue, pDate FROM Performances");
        while (resultSet.next()) {
            Integer performanceID = resultSet.getInt(1);

            Key venueKey = Key.createKey(Arrays.asList("performances", performanceID.toString()), Arrays.asList("venue"));
            Value venueValue = Value.createValue(resultSet.getString(2).getBytes());
            store.put(venueKey, venueValue);

            Key pdateKey = Key.createKey(Arrays.asList("performances", performanceID.toString()), Arrays.asList("pDate"));
            Value pdateValue = Value.createValue(resultSet.getString(2).getBytes());
            store.put(pdateKey, pdateValue);


//            System.out.println(resultSet.getInt(1) + "\t" + resultSet.getString(2) + "\t" + resultSet.getString(3));

        }
        resultSet.close();
        jdbcStatement.close();
    }
}