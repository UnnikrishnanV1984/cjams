/*
   Issue Description: CDM-44041
   Category/ Module  :Assignments
   Root cause:  End date family assignment.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
/*
select enddate,startdate,updatedby,* from caseassignment where caseassignmentid = 'b26c8422-89a2-4900-8697-2f6fa953d540' and activeflag = 1;
*/

update caseassignment
set enddate='2024-12-26',updatedby='CDM-44041', updatedon=now()
where caseassignmentid='b26c8422-89a2-4900-8697-2f6fa953d540' and activeflag=1;