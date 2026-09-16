-- CDM-20479-duplicate-clients
/*
-- Issue Description: 
	1.Clients are duplicated
-- Root cause: 
---Fix : Made the active flag to zero for duplicated clients

-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update actorrelationship
set activeflag = 0,
updatedon=now()
where intakeservicerequestactorid 
	in (	
		select intakeservicerequestactorid 
			from intakeservicerequestactor
		where personid in ('dcaa3f4c-fe3e-461f-a756-4acd28b40259' , '92f0134c-c2b5-4e2f-95cb-d2480021f79b', 'b7ce7c13-d264-43c7-a8c4-403dc3de4f59')
			and servicecaseid = '6f88f2a2-6d70-4274-8ed1-9f2c4e0915c4'
		)	
	and activeflag = 1;	


update intakeservicerequestactor	
set activeflag = 0,
updatedon=now()
where personid in ('dcaa3f4c-fe3e-461f-a756-4acd28b40259' , '92f0134c-c2b5-4e2f-95cb-d2480021f79b', 'b7ce7c13-d264-43c7-a8c4-403dc3de4f59')
			and servicecaseid = '6f88f2a2-6d70-4274-8ed1-9f2c4e0915c4'
	and activeflag = 1 ;