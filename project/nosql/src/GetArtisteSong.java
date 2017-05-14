import oracle.kv.*;

import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by efb4 on 5/11/2017.
 * returns the song of an artiste, when then artiste ID is put in
 */
public class GetArtisteSong {
    public static void main(String[] args) {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Scanner input = new Scanner(System.in);
        System.out.print("Enter artiste ID: ");
        Integer artisteName = input.nextInt();

        System.out.print(artisteName + "'s song(s): ");

        // multivalue get
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("song", artisteName.toString()));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
        store.close();
    }
}
