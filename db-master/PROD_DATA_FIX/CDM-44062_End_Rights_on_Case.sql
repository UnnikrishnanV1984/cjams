/*
   Issue Description: CDM-44062
   Category/ Module  :  Assignment
   Root cause:  cannot end date rights on this closed case. 
    Fix Provided: Did data fix to remove the casessignment from the assignment tab
*/

/*
select updatedby,startdate,enddate,* from caseassignment where caseassignmentid = '7f73967a-dc12-413d-afb0-6f332390c8b7'
*/
update caseassignment
set updatedby = 'CDM-44062',
	updatedon = now(),
	activeflag = 0
where caseassignmentid = '7f73967a-dc12-413d-afb0-6f332390c8b7'	
and activeflag=1;