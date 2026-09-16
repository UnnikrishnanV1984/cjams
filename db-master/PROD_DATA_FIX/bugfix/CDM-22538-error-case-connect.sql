/*
--CDM-22538-error-case-connect

-- Issue Description: 
 Delete the error case as requested 
-- Root cause: case is connecte with a different user
-- Pull request# 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update servicecasedisposition 
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-22538'
where servicecasedispositionid = '308282be-8959-4e94-befc-5c63d3524c9b';

update intakeservicerequest 
set servicecaseid = null,
updatedon = now(),
updatedby = 'CDM-22538'
where intakeserviceid = 'ea929896-1f48-4f85-90a2-30640d0061e0';