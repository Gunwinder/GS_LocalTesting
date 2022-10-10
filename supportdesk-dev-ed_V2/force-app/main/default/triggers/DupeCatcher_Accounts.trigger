trigger DupeCatcher_Accounts on Account (before insert, After insert) {
       //Preparing Account names in Set from trigger.new
        Set<String> nameSet = new Set<String>();
        String sBreak = '</br>';
   
        for(Account acc : trigger.new){
            nameSet.add(acc.name);
        }

        // getting the list of accounts in database  with the account name we entered ( trigger.new)
 Account[] accList = [select id,name from Account where name in: nameSet];

        for(Account a : trigger.new){
            if(accList.size() > 0 )
                for(Integer i=0;i<accList.size();i++)
            {
               
           
                a.addError('Account already exists in your Organization with name '+a.name+sBreak+'Existing records:'+'<a href=\'https://supportdesk-dev-ed.my.salesforce.com/'  + accList[i].id + '\'>' + accList[i].Name + '</a>',false);
            }
        }
}