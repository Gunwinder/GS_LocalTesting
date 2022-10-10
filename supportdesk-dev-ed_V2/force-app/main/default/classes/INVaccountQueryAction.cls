public class INVaccountQueryAction {
@InvocableMethod(label='Get Account names' description='Returns account names')

public static LIST<string> getAccountNames(LIST<ID> ids){
 LIST<string> accountNames = new LIST<string>();
 LIST<Account> accounts = [SELECT Name from Account where Id in :ids];
 for (Account account: accounts){
 accountNames.add(account.Name);
 }
 return accountNames;
}
}