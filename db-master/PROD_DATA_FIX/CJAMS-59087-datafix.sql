/*
   Issue Description: CJAMS-59087
   Category/ Module  : Assignments
   Root cause: User is requested to updated the Contact with Alleged Victim 
   Completed dropdown value from Data entry error but face to face met
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VFCM',
    updatedby ='CJAMS-59087',
    updatedon =now()
where intakeserviceid = '7adc3ead-5875-4364-a0f6-2b5884652115'
and cpsresponsetimeractionsid = 'd62e5d60-b11e-4af5-a201-6954733c7b21'
and activeflag = 1;
