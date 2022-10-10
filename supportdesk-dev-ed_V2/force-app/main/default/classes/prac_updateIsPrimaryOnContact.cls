public class prac_updateIsPrimaryOnContact {
  list <contact> conList = new list <contact>();// empty list to store all contacts
  contact[] getconList = [Select Id from Contact WHERE IsPrimary__c=FALSE];

    
}