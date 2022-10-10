trigger Utility_ContactUpdates on Contact (before insert, before update) {
    
    list <string> rawContacts = new list <string> ();
    list <string> finalContacts = new list <string> ();
    for (contact con : trigger.new){
        rawContacts.add(con.Id);
    }
    
    for (Contact con: [SELECT Id,IsPrimary__c from Contact where email in: rawContacts]){
       // finalContacts.add(IsPrimary__c);
    }
}