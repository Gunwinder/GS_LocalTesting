trigger CaseMGT_DuplicateSubjectPrefix on Case (before insert) {
    list <string> caseSubject = new list <string>(); // empty string to store ticket subject 
    list <case> existingTx = [Select ID, subject from Case]; 
    
	for(case c: existingTx){  // loop and store all subject for all tickets.
		caseSubject.add(c.Subject);
         }
    
    for (case cs:Trigger.new){
        if (caseSubject.contains(cs.subject)){
            cs.subject='[Loop Protection]-' + cs.subject;
        }
    }
}