trigger updatestatus on Case (before update) {
    for (case c : trigger.new){
    c.status = 'Working' ;
    }
}