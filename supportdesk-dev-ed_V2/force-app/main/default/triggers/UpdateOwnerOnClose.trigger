trigger UpdateOwnerOnClose on Case (before update) {
for (case c: trigger.new){
if(c.Status=='Escalated') {
c.OwnerId=c.LastModifiedById;
}
}}