public class listcontacts {
private string sortOrder = 'LastName';    // create  a variable called "LastName" of type string.

// Create a public method "getContacts" to return the list of contact.
// When we call this method in VFP then we will refer to as Contacts not getContacts.


        public List<contact> getContacts (){
            // define a variable called "results" of type List
            // use the Database.query method to fetch records. This method takes a string and performs a query.
            List<Contact> results = Database.query(
            'SELECT Id, FirstName, LastName, Title FROM Contact' + 
            ' ORDER BY ' + sortOrder + ' ASC ' +
            ' LIMIT 10 '           
            );   
            return results;                     
        }
}