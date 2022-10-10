public Class TestContactInsert{
    
    public string FirstName{get;set;}  // get set is used as information will be passed from a vfp
    public string LastName{get;set;}   // get set is used as information will be passed from a vfp 
    public string Email{get;set;}      // get set is used as information will be passed from a vfp    
    
    
    public List<Contact> newContacts{get;set;}     // declare
    
    public TestContactInsert(){
        newContacts = new List<Contact> ();  // constructor
    }
    
    public void zzTestCreateContacts() {        
        
        Account acc = [SELECT Id from account WHERE Name='ABC']; 
        
        Contact con = new Contact();            // object declared 
        
        con.FirstName=FirstName;
        con.LastName=LastName;
        con.Email=Email;
        con.AccountId=acc.id;      
        newContacts.add(con);
    
        FirstName=NULL;  // for resetting the form element on vfp
        LastName=NULL;   // for resetting the form element on vfp
        Email=NULL;      // for resetting the form element on vfp 
             
      
    }
    
    public void zzSaveContacts() { 
        try{
            insert newContacts;
            
        }
        catch (DmlException e) {
    		System.debug('A DML exception has occurred: ' + e.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Error Message.'));

        }
 		 
              
    }
    
}