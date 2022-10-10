Trigger populateDemoContacts on Account (After Insert) {
Contact c = new Contact ();
c.LastName = Trigger.New[0].name;
c.Accountid = Trigger.New[0].Id;
insert c;
}