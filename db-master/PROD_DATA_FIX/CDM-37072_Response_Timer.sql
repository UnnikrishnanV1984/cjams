/*
   Issue Description: CDM-37072
   Category/ Module  : Response Timer
   Case: 241021896294 (c0c37478-b3db-4c2c-9576-b62a6e34c146)
   Root cause: Response Timer didn't stop even after meeting all conditions
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '241021896294'
	and activeflag = 1 ;
	
select * 
from cjams.cpsresponsetimerupdate( 'c0c37478-b3db-4c2c-9576-b62a6e34c146'::uuid, 'CDM-37072'::character varying ) ;

-- After 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '241021896294'
	and activeflag = 1 ;