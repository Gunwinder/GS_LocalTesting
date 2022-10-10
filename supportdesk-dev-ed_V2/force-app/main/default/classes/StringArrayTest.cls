public class StringArrayTest {
     
   /* public static List<string> generateStringArray(Integer num)

    {
        List<String> strlist=new list<String>();
   		for(Integer k=0;k<num;k++)
        {
          strlist.add('Test '+k);  
        }
        

        return strlist;
} */
    
   /* public static string[] generateStringArray(Integer num)
    {
        string[] test=new String[num]; // declare
        for(Integer k=0;k<num;k++){
            test[k]='Test-'+k;            
        }
        system.debug('value of '+ test);
        return test;
    }*/
    
    public static list<string> fruits(Integer x){
        
        list<string> fruits =new list<string>(); //
        
        fruits.add('Mango');
        fruits.add('Orange');
        fruits.add('M1');
        fruits.add('O1');
        fruits.add('Ma1');
        fruits.add('Ora1');
        
        for(Integer d=0;d<x;d++){
        system.debug('fruits name'+ fruits);    
        }
          
        return fruits;
    }
}