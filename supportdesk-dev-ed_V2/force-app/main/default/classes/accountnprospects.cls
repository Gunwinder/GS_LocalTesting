public class accountnprospects{
    List<Account> acts; // declare list of accounts,, helper variable = acts.
    
    public List<Account> getacts(){ // getter method
    return acts;
    }    

    // considering we would want to call this call via a button on VFP we define addtional methods.
    // return NULL is used to redirect the user to the Same page.
    
    public PageReference customer(){
    acts = [SELECT Name, Type, Industry, Phone, Fax from Account WHERE type ='Customer'];
    return NULL;
    }
    
    public PageReference prospect(){
    acts = [SELECT Name, Type, Industry, Phone, Fax from Account WHERE type ='Prospect'];
    return NULL;
    }
}