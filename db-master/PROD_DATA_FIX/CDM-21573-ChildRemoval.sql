/*
   Issue Description: CDM-21573
   Category/ Module  : Child Removal
   Root cause: user wants to child removal from removal history
   Pull request# for code fix: 5198
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/


UPDATE intakeservreqchildremoval 
SET exitdate = null, activeflag = 0,
        updatedby = 'CDM-21573',
        updatedon = now()
WHERE intakeservreqchildremovalid = 'a48bcb87-ae77-4ea9-8d1c-9b5e038074a7';