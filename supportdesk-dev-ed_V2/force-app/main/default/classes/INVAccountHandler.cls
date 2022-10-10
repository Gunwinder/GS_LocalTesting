/*
https://github.com/Ansh1414/InvocableApex-Class/blob/master/AccountHandler

Account Handler class which will add contact with created Account 
*/
global class INVAccountHandler {
    global class addNewClassWithNewInvocableVariables{
        @InvocableVariable(required=true)
        global String accIds;
        @InvocableVariable
        global Integer Empnumber;
        //now very important:->You can fix any value in process builder for this variable
    }
    //InvocableApex
     @InvocableMethod(label='Insert Accounts')
    public static void insertNewAccount(List<addNewClassWithNewInvocableVariables> accIds){
        //List<Account> accList=new List<Account>([Select id,Name from Account where id IN :accIds]);
        //NumberOfEmployees
        System.debug('accIds of addNewClassWithNewInvocableVariables'+accIds);
        List<Contact> con=new List<Contact>();
        for(addNewClassWithNewInvocableVariables addIds:accIds){
            Contact acct = new Contact(LastName='contactBy Invocable AccountHandler');
            acct.AccountId=addIds.accIds;
            con.add(acct);
         }
         System.debug('con of addNewClassWithNewInvocableVariables'+con);
       
        Insert con;
    }
}