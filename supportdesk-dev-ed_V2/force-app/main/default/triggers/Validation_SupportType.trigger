trigger Validation_SupportType on Case (before insert,before update) {
    for (case c: trigger.new){
        
    if(c.Support_Type__c==NULL && c.Status=='Action - Automated Escalation'){
        c.adderror('You must select a value in Support type when you are escalating a ticket');
    }
  //  elseif(c.Support_Type__c.isempty() && c.Status='Action - Automated Escalation')    
   //        {
     //          c.adderror('You must clear the value of support type field unless you are escalating the ticket');
     //      }
    }
    
}