trigger DeleteContactsWithSameACName on Account (before insert) {
    set <string> lstAccSet = new set<string> ();
    
    for (account a : trigger.new){
        lstAccSet.add(a.name);
    }
    
    list<contact> conLst = [SELECT Id,name from contact where name in: lstAccSet ];
    if (conLst.size()> 0 && conLst !=NULL){
        DELETE conLst;        
    }

}