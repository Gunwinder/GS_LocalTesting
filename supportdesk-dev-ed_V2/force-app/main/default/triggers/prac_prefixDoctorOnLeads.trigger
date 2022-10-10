/*Prefixes the first name with Doctor on all leads*/

trigger prac_prefixDoctorOnLeads on Lead (before insert,before update) {
    list <lead> templist = trigger.new;
    for(lead l :templist){
        if(l.FirstName.contains('Doctor') ){
            l.FirstName=l.FirstName.replace('Doctor','');
        }
        else{
        l.FirstName='Doctor. '+l.FirstName;    
        }
        
    }
    
}