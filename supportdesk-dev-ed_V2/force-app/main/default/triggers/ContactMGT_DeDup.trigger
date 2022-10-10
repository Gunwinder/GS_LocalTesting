trigger ContactMGT_DeDup on Contact (before insert) {
String urlInstance = String.valueof(System.URL.getSalesforceBaseURL()).replace('Url:[delegate=','').replace(']','');
    string cid;
set <string> conlst = new set <string>(); // empty set
    for (contact c :trigger.new){ conlst.add(c.FirstName);
                                 cid=c.id;
                                  }  // get FirstNames in empty set
    
    
    list<contact> targetCon = [SELECT id,FirstName from Contact where FirstName IN: conlst]; // SOQL to get relevant contacts
    map<string,Contact> mapContact = new map<string,Contact> (); // empty map
    
    for(contact c2 : targetCon){ mapContact.put(c2.FirstName,c2);} // get FirstNames in empty map identified in SOQL 
    
     for (contact c :trigger.new){ 
         system.debug(mapContact.get(c.Id));
         if(mapContact.get(c.FirstName)!=NULL){
             c.adderror(UserInfo.getFirstName()+', We have found a Duplicate Contact in Salesforce, please refine your search and try again');
             c.adderror('click on the link :' +urlInstance+'\\'+c.Id);
             system.debug('Cid'+cid);
        //     String link = '<a href="'\ + System.URL.getSalesforceBaseUrl().toExternalForm() 	+ '/' + c.Id + '" target="_blank">sObject Link</a>';
             c.adderror('click on the link : <font color="pink"> <a href=\'https://supportdesk-dev-ed.my.salesforce.com/c.id\'>FirstName</a></font>', false);
             
         }
     }  // get FirstNames in empty set
    
}