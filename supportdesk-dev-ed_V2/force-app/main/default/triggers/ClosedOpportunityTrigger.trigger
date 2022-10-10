trigger ClosedOpportunityTrigger on Opportunity (after update, after insert) {

//List<Opportunity> oppList = new List<Opportunity>();
List<Task> tasks = new List<Task>(); 
//iterate over opprotunities with the stage of 'Closed Won

List<Opportunity> Opps = Trigger.new; 
 for (Opportunity Opp : Opps ) { 
                                 if (Opp.StageName == 'Closed Won')
                                 {
                                Task tsk = new Task(whatID = Opp.ID, Ownerid = Opp.OwnerId,Subject = 'Follow Up Test Task'); 
                                tasks.add(tsk);
                                }
                               } 
 insert tasks;

}