trigger createoppcont on Account (after insert){

//using lists to bulkify the code.

list<opportunity> opplist = new List <Opportunity>();
list<Contact> conlist = new List <Contact>();

for(Account acc: trigger.new){
opportunity opp = new Opportunity();
opp.Name= acc.Name;
opp.StageName = 'Qualification';
opp.closedate = date.today() + 14;
opp.Accountid = acc.id; // add opportunity within the loop

opplist.add(opp);

contact con = new contact();
con.lastname = 'LastName';
con.accountid = acc.id;
conlist.add(con);  // add contact within the loop
}

insert opplist;  // commit the items added to list to DB
insert conlist; // commit the items added to list to DB

}