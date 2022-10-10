trigger CreateChildOpp on Opportunity (after update) {

    list<opportunity> opplst = new list <opportunity> ();
    
    for (opportunity o : trigger.new){
        if(trigger.oldmap.get(o.id).StageName!='Closed Won'&& o.StageName=='Closed Won'){
            opportunity newopp= new opportunity();
            
            newopp.Name='Child Opp'+o.Name;
            newopp.CloseDate=o.CloseDate+77;
            newopp.StageName='Prospecting';
            newopp.AccountId=o.AccountId;
            opplst.add(newopp);
           
        }
    }
insert opplst;


}