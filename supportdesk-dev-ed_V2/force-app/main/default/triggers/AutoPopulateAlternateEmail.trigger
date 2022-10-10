trigger AutoPopulateAlternateEmail on Case (before insert, before update) {
    for(case c: trigger.new){
        c.Alternate_Email__c='gary_singh@campuseai.org';
        }
}