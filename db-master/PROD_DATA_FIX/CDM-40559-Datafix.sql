/*
  Issue Description:  CDM-40559
   Category/ Module  :  Contact Notes
   Root cause: User request to Initial face to face from no to yes
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-40559', 
	updatedon = now()
where personid ='5dab81c7-e88e-4b00-9118-53fca268b147'
	and activeflag  = 1
	and initialresponse = 0;

select * 
from cjams.cpsresponsetimerupdate( '2b9297f3-69e4-4b02-9c40-09d535e5c6a3'::uuid, 'CDM-40559'::character varying );