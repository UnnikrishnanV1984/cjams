	
        /*
   Issue Description: CDM-32348
   Category/ Module  : User wants to remove this person from case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update cjams.intakeservicerequestactor i 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32348'
where intakeservicerequestactorid in('29971e66-7a1f-4654-880f-30aa9d8240ed') ;
		
update cjams.actor 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32348'
where actorid ='364a5a02-73d0-43cb-a0c1-9d13c1093616';		


update cjams.personrole p  
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32348'
where personroleid  = '08dd531d-cd43-41f9-874f-95d161981361';
	

update cjams.actorrelationship a2 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-32348'
where intakeservicerequestactorid in('29971e66-7a1f-4654-880f-30aa9d8240ed') ;

		
update cjams.personprogramarea set activeflag =0, updatedby ='CDM-32348', updatedon = now()
where personprogramid ='48aa60cd-d3b2-43b9-a00a-449ab23c15a2';