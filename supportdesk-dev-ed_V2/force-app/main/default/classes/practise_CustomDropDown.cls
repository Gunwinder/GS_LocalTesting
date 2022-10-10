public class practise_CustomDropDown {
// define getter + setters to be used later
    public String selectedCountry1{get;set;}
    public String selectedCountry2{get;set;}
    public practise_CustomDropDown(){
        // nothing here
    }
    
    public LIST<SelectOption> getCountryOptions(){
     LIST<SelectOption> CountryOptions = new LIST<SelectOption>();   
    	CountryOptions.add(new SelectOption('','-None-'));
        CountryOptions.add(new SelectOption('INDIA','-India-'));
        CountryOptions.add(new SelectOption('USA','-America-'));
        return CountryOptions;    
    }
    public PageReference save(){
        return null;
    }
}