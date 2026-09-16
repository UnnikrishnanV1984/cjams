/*
   Issue Description: CDM-33078
   Category/ Module  : Person  
   Root cause: User requested to update the initialresponse value 
  Fix Provided: Did data fix to update the initialresponse value 
*/


-- To update initialresponse as Yes (CDM-33078)
select personroleid, personid, initialresponse, updatedby, updatedon  
	from personrole 
where intakeserviceid = '14073a18-ed88-43be-95da-274715c9969f'
	and activeflag  = 1
	and initialresponse = 0 ;

  update personrole
set initialresponse = 1,
	updatedby = 'CDM-33078', 
	updatedon = now()
where intakeserviceid = '14073a18-ed88-43be-95da-274715c9969f'
	and activeflag  = 1
	and initialresponse = 0 ;

  -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020571304'
	and activeflag = 1 ;

select * 
from cjams.cpsresponsetimerupdate( '14073a18-ed88-43be-95da-274715c9969f'::uuid, 'CDM-33078'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020571304'
	and activeflag = 1 ;