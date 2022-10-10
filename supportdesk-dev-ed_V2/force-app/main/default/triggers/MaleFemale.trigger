trigger MaleFemale on Contact (before insert,before update) {
    for (contact c : trigger.new){

        if (c.male__c=TRUE) {  c.Salutation='Mr'; c.Female__c=FALSE; }
        if (c.female__c=TRUE) {  c.Salutation='Ms.';  c.Male__c=FALSE;}   
        if ((c.Female__c=TRUE) && (c.Male__c=TRUE)) {c.Salutation=''; c.Female__c=FALSE; c.Male__c=FALSE;}
        
    }
    }