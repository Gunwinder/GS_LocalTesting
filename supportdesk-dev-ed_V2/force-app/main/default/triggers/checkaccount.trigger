trigger checkaccount on contact(before insert, before update){
    for(contact con : trigger.new){
        if(con.accountId != null){
            Id a = con.accountId;
            list<contact> cList = [SELECT Id, IsPrimary__c FROM Contact where IsPrimary__c = true and AccountId = :a];
            if(cList.size() > 0){
                con.addError('no more primary contacts');
            }
        }
    }
}