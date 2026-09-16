/*
   Issue Description: CDM-40383
   Category/ Module : Case Assignment and dashboard
   Root cause: Program assignment
   Fix Provided: Did data fix to remove family assignment
*/

update caseassignment
set activeflag=0, updatedby='CDM-40383', updatedon=now()
where caseassignmentid='79f85132-232c-4bb6-84ff-7bf224df1d96' and activeflag=1;