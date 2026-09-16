 /*  Issue Description: CDM-29583
   Category/ Module  :  Approval name change
   Root cause: Userwants to change the supervisor name change in notification
   Pull request# for code fix: i
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update usernotificationmap set updatedby = 'CDM-29583', updatedon = now(),
fromsecurityusersid = '9496daef-d05f-4677-835d-bb560e12e145' 
where usernotificationid = '458bfd44-21e8-46b9-8a05-00266a293a03';
