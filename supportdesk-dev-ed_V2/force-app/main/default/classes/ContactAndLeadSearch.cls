public class ContactAndLeadSearch {
    public static List<List<sObject>>  searchContactsAndLeads (string searchterm){
        
		List<List<sObject>> searchContactsAndLeads = [FIND 'Smith	' IN ALL FIELDS 
                   RETURNING Lead(Name),Contact(FirstName,LastName)];
					
					Lead[] searchLeads = (Lead[])searchContactsAndLeads[0];
					Contact[] searchContacts = (Contact[])searchContactsAndLeads[1];
					
					System.debug('Found the following Leads.');
					for (Lead a : searchLeads) {
						System.debug(a.Name);
					}
					
					System.debug('Found the following contacts.');
					for (Contact c : searchContacts) {
						System.debug(c.LastName + ', ' + c.FirstName);
					}							
    RETURN searchContactsAndLeads;
    }
    
}