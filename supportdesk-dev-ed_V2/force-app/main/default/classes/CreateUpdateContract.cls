public class CreateUpdateContract {
    
    public void CreateUpdateContracts (string CId){
        
        list <Opportunity> oppList = new list <Opportunity> ();
        list <Contract> conList = new list <Contract> ();
        
        list <Opportunity> SourceoppList = [SELECT id, Name, StageName,AccountId from Opportunity WHERE StageName!='Closed Won' and Id=:CId];
        list <Contract> CountContracts = [SELECT Id, AccountId FROM Contract WHERE AccountId=:SourceoppList[0].AccountId];  // always enter colon on stored variables.
        for (Opportunity o: SourceoppList)
        {
           
            If (CountContracts.size()>0 && CountContracts!=NULL)
            {
                Contract CN= new Contract();
                
                    CN.Name='Addendum-'+o.Name;
                    CN.AccountId=o.AccountId;
                    CN.Status='Draft';
                    CN.StartDate=System.Today();
                    CN.ContractTerm=12;
					insert CN; 
                	system.debug('New Addendum Contract ='+CN.Id);
                } else{
                    Contract CN= new Contract();
                    CN.Name=o.Name;
                    CN.AccountId=o.AccountId;
                    CN.Status='Draft';
                    CN.StartDate=System.Today();
                    CN.ContractTerm=12;
					insert CN; 
                    system.debug('New Contract ='+CN.Id);
                }
            }
        }
    }