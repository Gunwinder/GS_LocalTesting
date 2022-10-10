trigger TestDeleteValidationOnContact on Contact (before delete) {

    
    for(contact s: trigger.old){
        if(s.FirstName=='Manwinder'){
        s.adderror('This Contact is used in Salesforce JIT automation, you can not delete it.');    
        }
        }
}