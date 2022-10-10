public class prac_MyController {

   /* public String getName() {
	return 'prac_MyController'; 
} */
    
    string name='test';
    public prac_MyController()
    {
       getAccount12();
    }
	public Account getAccount12() {
	
        return [select id, name from Account where id = :ApexPages.currentPage().getParameters().get('id')];
}

}