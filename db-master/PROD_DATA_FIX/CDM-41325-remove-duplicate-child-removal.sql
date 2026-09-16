/*
   Issue Description: CDM-41325 Duplicate Persons-Trying to Close Case
   Category/ Module  :Child Removal
   Root cause: Data fix needed to duplicate child removal for the duplicate person with cjamspid 4325737 as the client is coming in monthly ACQI report as removed.
   Fix provided : Data fix has been done to remove the child removal record for the duplicate child.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

UPDATE intakeservreqchildremoval 
SET activeflag = 0, 
updatedby = 'CDM-41325', 
updatedon = now() 
WHERE intakeservreqchildremovalid IN ('47a7ecc8-04d1-4dcb-8433-2f2e462d8035');

update intakeservreqchildremoval_history
set activeflag = 0,
updatedby = 'CDM-41325', 
updatedon = now() 
WHERE intakeservreqchildremovalid IN ('47a7ecc8-04d1-4dcb-8433-2f2e462d8035');

