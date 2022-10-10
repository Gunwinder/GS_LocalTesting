Trigger AutoCloseChildCases1 on Case (after update) {
  Case[] casesToUpdate = new Case[0];
  
Set<Id>CaseSet = new Set<Id>();

for (Integer c=0;c<Trigger.size;c++) {  
    if ((Trigger.old[c].Status.contains('Closed')== false) && (Trigger.new[c].Status.contains('Closed')== true)) {
  CaseSet.add(Trigger.New[c].Id);
  }
  }
 
  If(CaseSet.Size()>0){
  Case[] cases = [select Id, Status, ParentId from Case where ParentId in:CaseSet];
 
  for (Integer i=0;i<Trigger.size;i++) {
    if ((Trigger.old[i].Status.contains('Closed')== false) && (Trigger.new[i].Status.contains('Closed')== true)) {
      for (Integer j=0;j<cases.size();j++) {
        if (cases[j].ParentId == Trigger.new[i].Id) {
          if(cases[j].Status.contains('Closed')==false)
          {
          cases[j].Status = 'Closed';
          casesToUpdate.add(cases[j]);
          }
        } //end if
      } //end for
    } //end if
  } //end for
} //update the list
if(casesToUpdate.size()>0){
  update casesToUpdate;
  }
} //end trigger