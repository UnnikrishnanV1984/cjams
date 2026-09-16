/*
-- CDM-37954 - Permanency Plans
-- Category / Module: Permanency Plans
-- Root cause: 3193054:This permanency plan was completed in MD CHESSIE but was not suppose to be APPLA since the child was only 8. 
			   We need this PP deleted since it was in error and all other ones were completed as the correct PP Adoption.
-- Fix Provided: Datafix has been done.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from permanencyplan where servicecaseid = '3610be68-5ece-43f4-95b2-37216a2bd9e2';

update permanencyplan 
set activeflag = 0, 
	updatedby = 'CDM-37954', 
	updatedon = now()
where permanencyplanid = '01aa9806-d566-4eb2-84fc-1666374c3445';

update routing
set activeflag = 0, 
	updatedby = 'CDM-37954', 
	updatedon = now()
where objectid = '01aa9806-d566-4eb2-84fc-1666374c3445';