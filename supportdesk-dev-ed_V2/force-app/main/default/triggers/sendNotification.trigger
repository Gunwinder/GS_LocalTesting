trigger sendNotification on Project_Resource__c (after insert) {
  Project_Resource__c inquery = trigger.new[0]; 
  //String[] toAddresses = new String[] {inquery.; 
  Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

  mail.setTargetObjectId(inquery.OwnerID);
  mail.setSenderDisplayName('Salesforce Support');
  mail.setUseSignature(false);
  mail.setBccSender(false);
  mail.setSaveAsActivity(false);

 if (Trigger.isInsert) { 
    
          EmailTemplate et=[Select id from EmailTemplate where DeveloperName=:'SupportCaseResponse'];
          mail.setTemplateId(et.id);
          Messaging.SendEmailResult [] r = 
    	  Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});   
       
   
   }
}