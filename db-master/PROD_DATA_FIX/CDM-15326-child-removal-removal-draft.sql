/*
   Issue Description: CDM-15326
   Category/ Module  :  Placement child removal approval
   Root cause: there is another removal in draft status created for the same time which is creting the problem
   Pull request# for code fix: 
   Reason why no related code fix: 
    One of issue, code is working fine, gave a data fix to remove the duplicate record.
*/

update intakeservreqchildremoval
set 
activeflag = 0,
updatedby = 'CDM-15326',
updatedon = now()
where
intakeservreqchildremovalid = '3386f732-138c-461b-825e-de931245849b';