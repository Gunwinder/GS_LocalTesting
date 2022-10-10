public class InsertSurvey {
    public Survey__c sur {get; set;}     
 // constructor
 public InsertSurvey(){ sur = new Survey__c(); }
 // action method
 
    public PageReference insertMe(){
        insert sur;
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Thank you, Survey Saved !.'));
        return null;
    }
    
}