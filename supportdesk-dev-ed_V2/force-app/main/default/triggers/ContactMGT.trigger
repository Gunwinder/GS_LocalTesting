trigger ContactMGT on Contact (before insert,before update) {
 /*   
    for (contact s : trigger.new){
        
        string p1=s.Phone.replace('(','');
        string p2=p1.replace(')','');
        string p3=p2.replace('-','');
        system.debug(p3.trim());
        
        if(s.Phone==NULL){ s.adderror('Phone can not be blank, please enter a valid number'); }
        if (s.Phone_Service__c=='Alltel'){ s.SMS_Link__c=s.phone+'@message.alltel.com'; }
        else if (s.Phone_Service__c=='AT&T'){ s.SMS_Link__c=p3+'@txt.att.net'; }
        else if (s.Phone_Service__c=='Boost Mobile'){ s.SMS_Link__c=p3+'sms.cricketwireless.net'; }
        else if (s.Phone_Service__c=='Cricket Wireless'){ s.SMS_Link__c=p3+'@msg.fi.google.com'; }
        else if (s.Phone_Service__c=='Project Fi'){ s.SMS_Link__c=p3+'@msg.fi.google.com'; }
        else if (s.Phone_Service__c=='Sprint'){ s.SMS_Link__c=p3+'@messaging.sprintpcs.com'; }
        else if (s.Phone_Service__c=='T-Mobile'){ s.SMS_Link__c=p3+'@tmomail.net'; }
        else if (s.Phone_Service__c=='Verizon'){ s.SMS_Link__c=p3+'@vtext.com'; }
        else if (s.Phone_Service__c=='Virgin Mobile'){ s.SMS_Link__c=p3+'@vmobl.co'; }
        else if (s.Phone_Service__c=='Republic Wireless'){ s.SMS_Link__c=p3+'@text.republicwireless.com'; } 
    } */
}