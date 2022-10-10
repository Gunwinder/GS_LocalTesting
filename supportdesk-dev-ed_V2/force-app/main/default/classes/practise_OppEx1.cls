public class practise_OppEx1 {
    LIST <Opportunity> Opp = [SELECT Id, Name, Amount, CloseDate,ExpectedRevenue from Opportunity];

// define a public method
	public LIST<Opportunity> getOpp(){
    return Opp;
	}
}