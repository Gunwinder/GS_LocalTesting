public class prac_Cl_GetAccfromPh {

    public static set<string> findAccount(string a){
    	set<string> result = new set<string>(); // empty list to store results from FOR LOOP.
        list<Account> lstAcc = [SELECT Id,Name from Account where phone=:a]; // store results from query    
        
        for (account r:lstAcc)
        {
            string s1=r.Name;
            string s2=r.Id;
        	result.add(s1);
            result.add(s2);
        	r.Name='Prabhjot Singh';
            
        }
        update lstAcc;
        system.debug('The account Id and Name are are='+ result );
        return result;
    }    
}