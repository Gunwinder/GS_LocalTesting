trigger Status on Case (before update){
    for(case c:trigger.new)
    {
        if (c.recordTypeId == '01228000000ASP4') {
            c.status='Escalated';
       }
    }
}