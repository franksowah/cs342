import oracle.kv.*;

import java.sql.SQLException;
import java.util.*;

/**
 * Created by efb4
 * Groups artistes according to their year in college
 * */
public class GetSortedArtistes {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        HashMap<String, List<List<String>>> artisteData = new HashMap<>();
        List<String> list_years = new ArrayList<>();

        Key key = Key.createKey(Arrays.asList("artiste"));
        Iterator<KeyValueVersion> it = store.storeIterator(Direction.UNORDERED, 0, key, null, null);

        while (it.hasNext()) {
            List<String> currentData = new ArrayList<>();
            KeyValueVersion kv = it.next();
            if (kv.getKey().getMinorPath().get(0).equals("year")) {
                String movieId = kv.getKey().getMajorPath().get(1);
                String year = new String(kv.getValue().getValue());
                currentData.add(movieId);
                currentData.add(getArtsisteName(movieId, store));
                if (!list_years.contains(year)) {
                    list_years.add(year);
                }
                if (artisteData.containsKey(year)) {
                    artisteData.get(year).add(currentData);
                } else {
                    List<List<String>> extra = new ArrayList<>();
                    extra.add(currentData);
                    artisteData.put(year, extra);
                }
            }
        }

        Collections.sort(list_years);

        for (String year : list_years) {
            for(List<String> movieInfo : artisteData.get(year)) {
                System.out.print(year + "\t");
                for (String data : movieInfo) {
                    System.out.print(data + "\t");
                }
                System.out.print("\n");
            }
        }

        store.close();
    }

    public static String getArtsisteName(String movieId, KVStore store) {
        String temp = "";
        Key majorKeyPath = Key.createKey(Arrays.asList("artiste", movieId));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPath, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            if (field.getKey().getMinorPath().get(0).equals("name")) {
                temp = new String(field.getValue().getValue().getValue());
            }
        }
        return temp;
    }
}