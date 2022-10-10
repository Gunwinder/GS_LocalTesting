trigger PasswordReminder on User (before insert,before update) {
list <Project_Resource__c> ProjReslist = new list<Project_Resource__c>(); // empty list to store user id
list <Project_Resource__c> ExistingProjReslist = [SELECT Id,User__c from Project_Resource__c]; // empty list
    
 /*   for (Project_Resource__c PRes:ExistingProjReslist){
        ProjReslist.add(PRes.User__c);
    } */
 
    for(user u:trigger.new){    
       
        if(u.PM_User__c==TRUE){            
            Project_Resource__c PR_Rec = new Project_Resource__c();
                PR_Rec.name='ProjRes'+u.FirstName+''+u.LastName;
            	PR_Rec.User__c=u.Id;
            ProjReslist.add(PR_Rec);
        }
    }
     
    insert ProjReslist;
}