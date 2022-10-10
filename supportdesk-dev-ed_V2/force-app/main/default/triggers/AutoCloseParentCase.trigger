trigger AutoCloseParentCase on Case (after insert, after update) {
    Set<Id> parentCaseIds = new Set<Id>();
    
    //Gather up a set of the parent cases.
    //We use Set instead of List because Set will prevent dupes.
    for (Case c:Trigger.new) {
        if (c.ParentId!=null) {
            parentCaseIds.add(c.ParentId);
        }
    }
    
    if (parentCaseIds.size()>0) {
        List<Case> parentCases = [Select c.IsClosed, 
                                    (Select IsClosed From Cases) 
                                    From Case c
                                    Where c.Id in :parentCaseIds];
                                    
        List<Case> parentCasesToUpdate = new List<Case>();
        
        for (Case parent:parentCases) {
            Boolean allChildrenClosed = true;
            //Look through each of the children -- if they're all closed, 
            //then close the parent, otherwise keep it open
            for (Case childCase:parent.Cases) {
                //If any child case is not closed, allChildrenClosed will flip to false
                //and stay that way.
                allChildrenClosed = allChildrenClosed && childCase.IsClosed;
            }
            
            //If the parent's closed status doesn't match its children's then change it
            if (parent.IsClosed!=allChildrenClosed) {
                //INSERT VALID STATUSES FOR YOUR ORG HERE
                parent.Status = allChildrenClosed?'Closed':'New';
                parentCasesToUpdate.add(parent);    
            }
        }
        
        //Now we do our bulk update
        if (parentCasesToUpdate.size()>0) {
            update parentCasesToUpdate;
        }
    }
}