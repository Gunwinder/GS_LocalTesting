trigger AutoCreateContactnOpp on Account (after insert) {

    for (account acc: trigger.new){
        opportunity o = new opportunity();
        contact c = new contact();
        c.firstname='Das';
        c.lastname='Gunwinder';
        c.accountid=acc.id;
        
        o.AccountId=acc.id;
        o.Name=o.Name+'- Opp';
        o.CloseDate=system.Today()+30;
        o.StageName='Closed Won';
        insert c;
        insert o;
    }
        
    
}