trigger CreatePMRecord on User (before update) {
    
Integer randomNumber = Integer.valueof((Math.random() * 10));
    
list <string> lst = new list <string>(); // temp list to get all user Ids

    
    for(user u:trigger.new) // iterate over all users
    {
        if (u.PM_User__c==true){
            lst.add(u.Id); // store user Ids in lst list
        }
    }
    
    list <Project_Resource__c> projreslst = [Select Id from Project_Resource__c where user__c=:lst];    
    
    for(user uf:trigger.new){
        if(uf.PM_User__c==TRUE)            
        {
            if (!(projreslst.size()>0))
            {
			Project_Resource__c pr = new Project_Resource__c();
            pr.name = uf.FirstName+uf.LastName;
            pr.User__c=uf.Id;
            insert pr;                
            }
            else{
                uf.adderror('Project Resource already exists'+uf.id);
            }
            
        }
        
    }

        
    }