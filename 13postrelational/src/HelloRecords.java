import oracle.kv.*;


import java.util.Arrays;
import java.util.Map;

/**
 * Created by efb4 on 5/5/2017.
 */
public class HelloRecords {

    public static void main(String[] args) {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // C(reate)
        // This initializes an arbitrary key-value pair and stores it in KVLite.
        // The key-value structure is /helloKey : $value
        String keyString = "movie", valueString = "Dr. StrangeLove";
        String keyString2 = "92616";
        String keyString3 = "name";
        String keyString4 = "year", valueYear = "1964";
        String keyString5 = "rating", valueRating = "8.7";
//        Key key = Key.createKey(Arrays.asList(keyString, keyString2), Arrays.asList(keyString3));
//        Key key2 = Key.createKey(Arrays.asList(keyString, keyString2), Arrays.asList(keyString4));
//        Key key3 = Key.createKey(Arrays.asList(keyString, keyString2), Arrays.asList(keyString5));
//        Value value = Value.createValue(valueString.getBytes());
//        Value value2 = Value.createValue(valueYear.getBytes());
//        Value value3 = Value.createValue(valueRating.getBytes());
//        store.put(key, value);
//        store.put(key2, value2);
//        store.put(key3, value3);


        // R(ead)
        // This queries KVLite using the same key.
        // The result, a byte array, is converted into a string.
//        String result = new String(store.get(key).getValue().getValue());
//        String result2 = new String(store.get(key2).getValue().getValue());
//        String result3 = new String(store.get(key3).getValue().getValue());
//        System.out.println("New movie record: ");
//        System.out.println(key.toString() + " : " + result);
//        System.out.println(key2.toString() + " : " + result2);
//        System.out.println(key3.toString() + " : " + result3);

        Key majorKeyPathOnly =  Key.createKey(Arrays.asList(keyString, keyString2));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }

        store.close();
    }

}
