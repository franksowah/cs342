import oracle.kv.*;

import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by efb4 on 5/11/2017.
 */
public class GetMovieActors {
    public static void main(String[] args) {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Scanner input = new Scanner(System.in);
        System.out.print("Enter MovieID: ");
        Integer movieId = input.nextInt();


        // multivalue get
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("role", movieId.toString()));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String roleName = field.getKey().getMinorPath().get(0);
            String actorId = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + actorId + "\t" +getActorNames(actorId, store) + "\t"+"\t" + roleName);
        }
        store.close();
    }

    public static String getActorNames(String actorId, KVStore store) {
        String fullname = " ";
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("actor", actorId));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()){
            fullname += " " + new String(field.getValue().getValue().getValue());
        }
        return fullname;
    }
}
