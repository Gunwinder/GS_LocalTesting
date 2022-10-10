trigger IdentifyIsPrimary on Contact (before insert, before update) {

List<Contact> listPrimaryContact= [SELECT Id,Name,IsPrimary__C FROM Contact WHERE IsPrimary__C=TRUE];

    If( listPrimaryContact.size() > 0 ){
        for (Contact c: trigger.new) {
        c.IsPrimary__C = FALSE;
    }
}

}