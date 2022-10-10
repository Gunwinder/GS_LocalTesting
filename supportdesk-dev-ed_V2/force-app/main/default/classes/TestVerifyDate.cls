@isTest
public class TestVerifyDate {
    @isTest static void test1(){
        date date1 = VerifyDate.CheckDates(system.today(),system.today()+10);
        system.assertEquals(system.today()+10, date1);
    }
    
    @isTest static void test2(){
        date date2 = VerifyDate.CheckDates(system.today(),system.today()+15);
        date startDate = System.Date.today().toStartOfMonth(); 
        System.assertEquals(startDate.addMonths(1).addDays(-1), date2);
    }
}