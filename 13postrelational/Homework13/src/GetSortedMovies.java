import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by efb4 on 5/11/2017.
 */
public class GetSortedMovies {
    public static void main(String[] args) throws SQLException {
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        Statement jdbcStatement = jdbcConnection.createStatement();
        ResultSet resultSet = jdbcStatement.executeQuery("SELECT year, id, name  FROM Movie ORDER BY YEAR ASC ");
        while (resultSet.next()) {
            System.out.println(resultSet.getInt(1) + "\t" + resultSet.getString(2) + "\t"
                    + resultSet.getString(3));
        }
        resultSet.close();
        jdbcStatement.close();
        jdbcConnection.close();
    }
}
