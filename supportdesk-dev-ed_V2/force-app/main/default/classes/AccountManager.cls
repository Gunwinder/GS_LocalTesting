@RestResource(urlMapping='/v1/Account/*')
global with Sharing class AccountManager {
    
    @httppatch
    global static Account UpdateAccount(string rating, string AccNumber, string description){
     //get the Id from URI
     RestRequest request = RestContext.request;
       STRING requestURI = request.requestURI;
       system.debug('requestURI '+requestURI);
       STRING accountId = requestURI.subStringAfterLast('/');
       
       // query account before updating and to bypass No Results found error. 
       list <Account> accListCheck = [SELECT Id from Account WHERE id =:accountId];
       // NULL check 
       Account newAcc; // blank record
       if (accListCheck!=NULL && accListCheck.size()>0){
           // prepare account record. 
           newAcc = new Account(
           Id = accountId,
           Rating = rating,
           AccountNumber = AccNumber,
           Description = description       
           );
           update newAcc;           
       }      
       return newAcc;
    }
    
    @httpDelete
    global static STRING postDeleteAccount (){
    RestRequest request = RestContext.request;
       STRING requestURI = request.requestURI;
       system.debug('requestURI '+requestURI);
       STRING accountId = requestURI.subStringAfterLast('/');
       
       LIST<Account> accListtoDelete = [Select Id FROM Account WHERE id =:accountId]; 
       
       if (accListtoDelete!= NULL && accListtoDelete.size() > 0){ // check 
       try{
       Delete accListtoDelete;
       return '{"message":"Account record deleted!"}'; 
       }Catch(system.exception ex){
       STRING errorMessage = ex.getMessage();
       return '{"message":'+errorMessage +' }';
           }      
       } else{
       return '{"message":"Account record not found !!"}';   
       }
    }
    
    
    @httpPost 
    global static Account postAccount (String accName, String accNumber){
    Account accountRecord = new Account(Name =accName, AccountNumber=accNumber);
    insert accountRecord;
    return accountRecord;
    }
    
    @httpGet /* */
    global static AccountWrapper accountInformation(){
       RestRequest request = RestContext.request;
       String requestURI = request.requestURI;
      // String accountId  = requestURI.substringAfter('/');
         String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

        
       LIST<Account> accountList = [SELECT Id,Name,Rating,Industry,Description,Phone,Fax 
                                    FROM Account where Id =:accountId]; 
       
      LIST<Contact> contactList  = [SELECT Id, name, FirstName, LastName, Email, Phone 
                                    FROM Contact WHERE AccountId =: accountId];  
        
       LIST<case> caseList       = [SELECT Id, CaseNumber, Subject, Description, Status, Owner.name
                                    From Case WHERE AccountId =: accountId];
        
     AccountWrapper wrapper = new AccountWrapper(); // created a wrapper class object
        if (!accountList.isEmpty()){
            wrapper.accountRecord = accountList.get(0);
            wrapper.contactList = contactList;
            wrapper.caseList = caseList;
        }
        return wrapper;
    }
    
    global class AccountWrapper{  // wrapper class to.....
        global Account accountRecord;
        global LIST<Account> accountList;
        global LIST<Contact> contactList;
        global LIST<case> caseList;
    }
}