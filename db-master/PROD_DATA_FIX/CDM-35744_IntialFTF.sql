-- CDM-35744 - Initial face to face contact/ response timer
/* Issue Description:The response timer continues to say overdue although 3 entries were made with initial face to face # 231021183172

-- Person ID: 35c1d34d-22fe-46ce-9032-31ee87f2b6d6
-- Intake Service Id: 0d2d70f4-66aa-4678-a32a-1c2989e9e33c

-- Category/ Module: Contacts: Notes 

-- Root cause: The response timer continues to say overdue although 3 entries were made with initial face to face # 231021183172
-- Fix Provided: Datafix has been provided to update initialresponse on personrole for 35c1d34d-22fe-46ce-9032-31ee87f2b6d6
-- Pull request# N/A

*/

select initialresponse,* 
from personrole 
where intakeserviceid='0d2d70f4-66aa-4678-a32a-1c2989e9e33c' and activeflag=1 and personid='35c1d34d-22fe-46ce-9032-31ee87f2b6d6';

update personrole
set initialresponse= 1,
	updatedon = now(), 	
	updatedby = 'CDM-35744'
where intakeserviceid='0d2d70f4-66aa-4678-a32a-1c2989e9e33c' and activeflag=1 and personid='35c1d34d-22fe-46ce-9032-31ee87f2b6d6';

-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021183172'
	and activeflag = 1 ;

select * 
from cjams.cpsresponsetimerupdate( '0d2d70f4-66aa-4678-a32a-1c2989e9e33c'::uuid, 'CDM-35744'::character varying ) ;

-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021183172'
	and activeflag = 1 ;