
/*
   Issue Description: CDM-27980
   Category/ Module  : Prod data fix To remove draft Removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    intakeservreqchildremoval
set
    activeflag = 0,
    updatedby = 'CDM-27980',
    updatedon = now()
where
    intakeservreqchildremovalid = 'db67e432-b3b1-40cd-af41-ec94c6273e64';