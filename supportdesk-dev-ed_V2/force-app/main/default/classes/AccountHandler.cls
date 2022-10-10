public class AccountHandler {
    
    public string name{set;get;}
    
    public static account insertNewAccount(string name){
        account acc = new account();
        acc.Name=Name;
        try{
        insert acc;
        }
        catch(exception e)
        {
            system.debug('An error occoured:'+ e.getMessage());
            return null;
        }
        return acc;
    }
 
}