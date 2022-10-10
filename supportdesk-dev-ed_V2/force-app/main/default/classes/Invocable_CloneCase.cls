/* https://www.youtube.com/watch?v=Rm3a_lWqPTI */

global class Invocable_CloneCase{
    
    @InvocableMethod(label='Send email to Contact....')
    global static void createTicket(List<id> CaseIds){
     
    list<case> testCaseList = [SELECT ID from CASE WHERE id IN :CaseIds];
    delete testCaseList;
    
    }
}