@RestResource(urlMapping='/v2/AccountManager/*')
global class REST_AccountManager {

    @httpGet
    global Static InformationWrapper AccountInformation(){
            //define global method
            RestRequest request = RestContext.request;
            string requestURI = request.requestURI;
            string accountId = requestURI.subStringAfterLast('/');
            
            // find the account details
            list<account> accList = [SELECT id, name from Account WHERE id =:accountId ];
            
            //find all contacts where accountid matches
            list<contact> conList =[Select id, email, accountId from CONTACT WHERE AccountId =:accountId];
            
            //find all cases where accountid matches
            list<case> caseList =[Select id, casenumber from CASE WHERE AccountId =:accountId];
            
            
            //create a object of wrapper class
            
            InformationWrapper wrapper = new InformationWrapper();
            if(!accList.isEmpty()){
                system.debug('Not empty');
                wrapper.accountRecord=accList.get(0);
                wrapper.conList=conList;
                wrapper.caseList=caseList;
                
           }    
   return wrapper;
    }     
    
    // defination of wrapper class
    global class InformationWrapper {
    global account accountRecord;
    global List<account> accountList;
    global List<contact> conList;
    global List<case> caseList;
    }
  }