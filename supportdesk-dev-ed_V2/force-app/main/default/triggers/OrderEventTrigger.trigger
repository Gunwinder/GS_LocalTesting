// Trigger for listening to Order events.
trigger OrderEventTrigger on Order_Event__e (after insert) {
  
    // List to hold all tasks to be created.
    List<task> tasks= new List<task>();
    user u = [select Id from user where alias='GSing' limit 1];
    
    // Get queue Id for case owner
    // Group queue = [SELECT Id FROM Group WHERE Name='Regional Dispatch' LIMIT 1];
       
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create Case to dispatch new team.
            Task cs = new Task();
            cs.Priority = 'Medium';
            cs.Status = 'New';
            cs.Subject= 'Follow up on shipped order ' + event.Order_Number__c;
            cs.OwnerId = UserInfo.getUserId();
            tasks.add(cs);
        }
   }
    
    // Insert all tasks corresponding to events received.
    insert tasks;
}