import oracle.kv.*;

import java.util.Arrays;
import java.util.Map;
import java.util.Scanner;

/**
 * Created by efb4 on 5/11/2017.
 */
public class GetMovieActorRoles {
    public static void main(String[] args) {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        Scanner input = new Scanner(System.in);
        System.out.print("Enter Movie ID: ");
        Integer movieId = input.nextInt();

        System.out.print("Enter actor ID: ");
        Integer actorId = input.nextInt();

        // multivalue get
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("role", movieId.toString()));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String roleName = field.getKey().getMinorPath().get(0);
            String actorvalue = new String(field.getValue().getValue().getValue());
            if (actorvalue.equals(actorId.toString()))
            System.out.println("\t" + roleName);
        }
        store.close();
    }
}
