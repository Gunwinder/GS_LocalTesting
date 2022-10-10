/*
public class prac_NewOppContract {

    public void createContract(string SuppliedOppId){

    list <Opportunity> myOpps = [SELECT Id,Name,StageName,AccountId,CloseDate from Opportunity where Id=:SuppliedOppId];
    list <contract> newContracts = new list <contract>();
    
    for(Opportunity o: myOpps){
        Contract ct=new contract();
        ct.AccountId=o.AccountId;
        ct.Status='Draft';
        ct.StartDate=system.Today();
        ct.ContractTerm=5;
        newContracts.add(ct);
        system.debug('Contacted created='+ct.id);
    }
    
    insert newContracts;
        
    }
} */


public class prac_NewOppContract {

    public void CreateOppContract(id a){   

    list <Opportunity> myOpps = [SELECT AccountId from Opportunity where Id=:a];
    list <account> acclist= [Select Id, Name from Account where Id=:a];    
    list <contract> newContracts = new list <contract>();
    list <contract> Contractslist = [select id from contract where AccountId=:myOpps[0].Id];
    
    for(Opportunity o: myOpps){
        Contract ct=new contract();
        ct.AccountId=o.AccountId;
        ct.Status='Draft';
        ct.StartDate=system.Today();
        ct.ContractTerm=5;
        newContracts.add(ct);        
    }
    
    	insert newContracts;
        system.debug('Contacted created='+newContracts[0].id);
        
    }
}

/*  prac_NewOppContract c = new prac_NewOppContract('0060I00000Y3Hqp');*/