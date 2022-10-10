/* @restresource(urlmapping='/v1/AccountManagerPATCH/*')
global class REST_AccountManagerPATCH {

    @httpPATCH
    global static responseWrapper UpdateAccount(string rating,string accnumber, string description){
        restrequest request = RestContext.request;
        string requestURI = request.requestURI;
        string accountId = requestURI.subStringAfterLast('/');
        // Fetch the account record to prevent APEX Error = sObject has no row assignment.
        list<account> accList =[SELECT Id FROM Account WHERE Id =:accountId];
        // dummy account
        Account accRecord;	
        responseWrapper wrapperobj = new responseWrapper(); // create instance of wrapper class
        
        // null check 
        if (accList.size() >0 || accList!=null){
        	// prepare the account record        
            accRecord = new account (id= accountId, rating =rating, accountNumber= accnumber, description = description);
            update accRecord;
            wrapperobj.accRecord = accRecord;  
            wrapperobj.operationMessage= 'Account record updated';
        }else{
           wrapperobj.operationMessage= 'Account record not found !'; 
        }
       // return accRecord;
        return wrapperobj; 
    }
    
    global class AccountInformation{
        Account accountRecord {get;set;}
        Contact contactRecord {get;set;}
    }
    // simulating where we pass only one record and fetch all the fields in it. Here we use {get;set;}
    global class responseWrapper{
        global account accRecord;
        global string operationMessage;
    }
----------WORKING CODE-------------------------
*/

@restresource(urlmapping='/v1/AccountManagerPATCH/*')

global class REST_AccountManagerPATCH {
    @httpPATCH
    global static AccountInformation UpdateAccount(AccountInformation information){
        // boilerplate code for a rest request
        restrequest request = RestContext.request;
        string requestURI = request.requestURI;
        string accountId = requestURI.subStringAfterLast('/');
        
        // Fetch the account record to prevent APEX Error = sObject has no row assignment.
        list<account> accList =[SELECT Id FROM Account WHERE Id =:accountId];
        // dummy account
        Account accRecord;	
        // create instance of wrapper class
        responseWrapper wrapperobj = new responseWrapper(); 
        // create instance of wrapper class
        AccountInformation wrapperAccountobj = new AccountInformation(); 
        
        // null check 
        if (accList.size() >0 || accList!=null){
        	// prepare the account record        
            // accRecord = new account (id= accountId, rating =rating, accountNumber= accnumber, description = description);
            // accRecord = new account (information.accountRecord); // Gets error : Type requires name=value pair construction: Account 
            accRecord = information.accountRecord;
            accRecord.id=accountid;
            update accRecord;
            wrapperAccountobj.accRecord = accRecord;  
            wrapperAccountobj.operationMessage= 'Account record updated';
        }else{
           wrapperAccountobj.operationMessage= 'Account record not found !'; 
        }
       // return accRecord;
        return wrapperAccountobj; 
    }
    
    global class AccountInformation{
       global Account accountRecord {get;set;}
       global Contact contactRecord {get;set;}
       global string operationMessage;
       global account accRecord; 
    }
    // simulating where we pass only one record and fetch all the fields in it. Here we use {get;set;}
    global class responseWrapper{
        global account accRecord;
        global string operationMessage;
    }    
}