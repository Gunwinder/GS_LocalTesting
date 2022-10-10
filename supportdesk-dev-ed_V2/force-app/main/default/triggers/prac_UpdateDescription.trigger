trigger prac_UpdateDescription on Contact (before insert,before update)
{
    for (Contact c:Trigger.new){
        if(trigger.isInsert)
        {
            c.Description='Code executed from Isnew block';
        }
        else if(trigger.isUpdate)
        {
             c.Description='Code executed from isUpdate block';
        }
        }
}