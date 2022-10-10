trigger AccountMGT_CopyDescription on Account (before update) {

list <contact>  conlist = new list<contact>();  
    for(account a:trigger.new){
        list<contact> con = [SELECT id, name, accountid, description FROM Contact where accountid =: a.id];
        
        if (con.size() > 0 && con!=NULL) {
       	  for(contact c:con){
            c.description=a.Description;
            conlist.add(c); 	
        }	     
        }
      
    }
update conlist;
}