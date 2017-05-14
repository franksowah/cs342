import oracle.kv.*;

import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by efb4 on 5/11/2017.
 * provides information about an artiste
 */
public class GetTableValues {
    public static void main(String[] args) {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Scanner input = new Scanner(System.in);
        System.out.print("Enter Database Table: ");
        String table = input.next();

        System.out.print("Enter artiste ID: ");
        Integer id = input.nextInt();

        // multivalue get
        Key majorKeyPathOnly = Key.createKey(Arrays.asList(table, id.toString()));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldValue);
        }
        store.close();
    }
}