// This class makes use of Page reference to redirect to same page. Here we get open and closed opportunities.

public class practise_oppEx2 {
	LIST <Opportunity> opp; //blank
    
    public LIST<Opportunity> getOpp(){ //contructor, reserves memory for the LIST
        return Opp;
    }
        
    
    public PageReference OpenOpps(){
        opp=[SELECT ID,Name,StageName from Opportunity WHERE StageName !='Closed Lost'];
        return NULL;
    }
    
    public PageReference ClosedOpps(){
        opp=[SELECT ID,Name,StageName from Opportunity WHERE StageName ='Closed Lost'];
        return NULL;
    }
    
        public void spin() {
        long now = datetime.now().gettime();
        while(datetime.now().gettime()-now<5000); // Busy loop for 5000 ms
    }
    
    
}