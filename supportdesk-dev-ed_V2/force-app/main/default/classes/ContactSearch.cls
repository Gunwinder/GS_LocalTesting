public class ContactSearch {
    
    public static List<Contact> searchForContacts(string x,string y){
       List<contact> ContactList=[SELECT ID,Name from Contact WHERE MailingPostalCode= :y AND LastName= :x]; 
    return ContactList;
    }   
    
}