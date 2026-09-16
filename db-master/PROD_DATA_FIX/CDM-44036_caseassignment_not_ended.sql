/*
   Issue Description: CDM-44036
   Category/ Module  :Assignments
   Root cause:  End date family assignment.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
/*
select enddate,startdate,* from caseassignment where caseassignmentid = '40ecfe05-ce41-4a9d-b95f-48380c9b3d52' and activeflag = 1;
*/
update caseassignment
set enddate='2025-01-22',updatedby='CDM-44036', updatedon=now()
where caseassignmentid='40ecfe05-ce41-4a9d-b95f-48380c9b3d52' and activeflag=1;