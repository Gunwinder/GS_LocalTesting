trigger CaseMGT_ChangeOnwer on Case (before insert,before update) {
 
    /* Non bulkified code 
    for (case c : trigger.new){
       if (c.status=='Action - Automated Escalation'){
            c.ownerid='00528000001WXwVAAW';
           c.status='Escalated';
           c.subject='[Escalated by Trigger ]'+c.subject;    
        } 
    }  */
        
}