trigger IdenitfyGender on Contact (before update) {
        for (contact c : trigger.new){
                If (c.Male__c == True){
                c.Gender__C='Male';
                }
                else if (c.Male__c == FALSE && c.Male__c == TRUE) { c.Gender__C = 'Female'; }
                else if (c.Male__c == FALSE && c.Male__c == FALSE) { c.Gender__C = ''; }
                else { c.Gender__C = ''; }

}
}