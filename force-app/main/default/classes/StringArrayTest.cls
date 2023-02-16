public class StringArrayTest {

    public static List<String> generateStringArray(Integer length) {
  
        List<String> list1 = new List<String>();
     
        for(Integer i=0;i<length;i++) {
    
            list1.add('Test ' + i);
         
            System.debug(list1[i]);
        } 
        return list1;
    }   
 }