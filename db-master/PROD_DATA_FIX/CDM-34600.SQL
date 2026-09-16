/* 
    Issue Description: CDM-34600
   Category/ Module  : Child Removal
   Root cause: user wants to delete  duplicate child removal. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

UPDATE intakeservreqchildremoval 
SET activeflag = 0,
updatedby ='CDM-34600',
updatedon = now()
WHERE intakeservreqchildremovalid = '0d20ceea-ea2d-451d-af68-c7013bb51261' AND activeflag=1;


UPDATE intakeservreqchildremoval_history 
SET activeflag = 0,
updatedby ='CDM-34600',
updatedon = now()
WHERE intakeservreqchildremovalid = '0d20ceea-ea2d-451d-af68-c7013bb51261' AND activeflag=1;