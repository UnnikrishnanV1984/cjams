/*
   Issue Description: CJAMS-68305
   Category/ Module  : 
   Root cause: Verified in Production and the CPS AR# : 261023816253 has been assigned to Lauren Harbaugh.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 



update intakeservicerequest 
set isrouted=true, updatedby='CJAMS-68305', updatedon=now() 
where servicerequestnumber='261023816253' and activeflag = 1;