/*
    Issue no: CDM-16566
    Issue: Adoption planning info is not populating in the screen after saved
    Root cause: The client actor role has been changed and the actor id in the adoptionplanning table is having active falg as 0 in intakeservicerequestactor table   
*/
update adoptionplanning
set intakeservicerequestactorid = '19619450-5033-48ef-9fb0-fe7c005b446a',
	updatedby = 'CDM-16566',
	updatedon = now()
where intakeservicerequestactorid = 'c573f814-0d71-4241-8d66-443dd57b9aa1' and permanencyplanid = '589d4866-8c13-4750-ba40-95b2e4974f94';