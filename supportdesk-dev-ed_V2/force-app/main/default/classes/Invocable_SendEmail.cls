/* https://www.youtube.com/watch?v=Rm3a_lWqPTI */

global class Invocable_SendEmail{
    
    global class DataWrapper{
    
    @InvocableVariable (label='Record Id' required=true)
    public String recordId;
    @InvocableVariable (label='Template Id' required=true)
    public string emailTemplateId;
    }

    @InvocableMethod(label='Send email to Contact....')
    global static void sendMailtoContact(List<DataWrapper> passedData){
    //send email 
    
    for(DataWrapper dw: passedData){
    EmailTemplate selectedTemplate = [SELECT id from EmailTemplate WHERE Id =:dw.emailTemplateId];

    // single email 
    Messaging.SingleEmailMessage mailToSend = new Messaging.SingleEmailMessage();
    mailToSend.setTargetObjectId(dw.recordId);
    mailToSend.setTemplateId(selectedTemplate.Id);

    //store where to send the emails in a list
    List<Messaging.SendEmailResult> sendResults = Messaging.sendEmail(new List<Messaging.Email> {mailToSend});
    system.debug(sendResults[0]);
    }
    
    }
}