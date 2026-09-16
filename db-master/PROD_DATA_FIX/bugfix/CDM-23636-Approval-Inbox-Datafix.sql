/*
   Issue Description: CDM-23636 - No Approval Needed
   Category/ Module  : Approval Inbox
   Root cause: Two cases stuck in Approval Inbox. No approvals needed. User requested to delete from Approval Inbox

   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/

 -- servicerequestnumber = 3072572
 
select	activeflag, routingid, routingstatustypeid, tosecurityusersid, * 
from 	routing 
where 	objectid = '480ae45b-1aa3-4afc-a0b7-4c55e93a6c65';

update 	routing
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-23636'
where 	routingid = 'e55ca34f-18b2-4c50-869a-8e121f1d567b' and activeflag = 1;

-- servicerequestnumber = 3283970

select	activeflag, routingid, routingstatustypeid, tosecurityusersid, * 
from 	routing 
where 	objectid = 'b820bca2-ea69-4069-8819-c7e5acf7e9e9'; 

update 	routing
set 	activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-23636'
where 	routingid = 'c00033c2-b80c-4bb4-bdb2-98e19e1d7b2f' and activeflag = 1;

