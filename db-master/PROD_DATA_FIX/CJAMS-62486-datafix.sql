-- CJAMS-62486 - person role not populating
/*
-- Issue Description: 
-- :CJams will not keep Initial contact caregiver under casehaed after I save

-- Category/ Module: Person profile
-- Root cause: wrong actorid was mapped
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--intakeservicerequestactor
update intakeservicerequestactor
set actorid = '91b78ab3-cfd1-4b70-928d-b63def3c7217', updatedby ='CJAMS-62486', updatedon = now()
where intakeservicerequestactorid = '44e79719-6f2e-4721-9142-9739ef82e615' and actorid = 'bebcf3fe-0393-4b9b-9390-ded834343c78' 
and activeflag = 1;
--actor
update actor 
set updatedon = now(), activeflag = 0, updatedby ='CJAMS-62486'
where actorid  = 'bebcf3fe-0393-4b9b-9390-ded834343c78' and activeflag = 1;