public with sharing class DisplayOppsinLWC {
    @AuraEnabled(cacheable=true)
    public static LIST<Opportunity> getOpportunities(string accId){
        return [SELECT id, Name, Amount FROM Opportunity WHERE AccountId= : accId];
    }

}