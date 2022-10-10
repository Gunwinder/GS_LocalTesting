Trigger cresateOpp on Account (after insert) {
list<opportunity> opplist = new List<Opportunity> ();
list<contact> conlist = new List<Contact> ();

    for (Account acc: trigger.new) {
    Opportunity opp = new Opportunity();
    
    opp.Name = acc.Name;
    opp.StageName = 'Qualification';
    opp.closedate = date.today()+14;
    opp.Accountid = acc.id;
    
    opplist.add(opp); // add all the feild values within the FOR loop.
    
    contact con = new Contact();
    con.lastname = 'Manwinder Singh';
    con.accountid = acc.id;
    conlist.add(con);
    }
    
    insert opplist;
    insert conlist;
}