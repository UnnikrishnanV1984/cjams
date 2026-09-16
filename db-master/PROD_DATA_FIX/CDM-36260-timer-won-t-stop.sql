/*
   Issue Description: CDM-36260
   Category/ Module  :  child welfare/ Person
   Root cause: This error occurred due to selected the option "No" instead of "Yes"
   Fix Provided: did data fix to updated the value to Yes  
*/

-- CJAMS PID: 201157267
-- CJAMS PID: 201157269

-- Backup
select personroleid, intakeserviceid, personid, initialresponse, updatedby, updatedon  
	from personrole 
where personroleid in ('aab9a047-9179-4031-b946-e56f43d62eb0', '7fa9828f-fc62-44bf-a6c1-019a1e62e605' )
	and activeflag  = 1 
	and initialresponse = 0 ;

-- Update
update personrole
set initialresponse = 1,
	updatedby = 'CDM-36260', 
	updatedon = now()
where personroleid in ( 'aab9a047-9179-4031-b946-e56f43d62eb0', '7fa9828f-fc62-44bf-a6c1-019a1e62e605' )
	and activeflag  = 1
	and initialresponse = 0 ;
	
-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021605059'
	and activeflag = 1 ;

select * 
from cjams.cpsresponsetimerupdate( 'ae72bb6e-f520-497f-928d-bb019198bef5'::uuid, 'CDM-36260'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021605059'
	and activeflag = 1 ;