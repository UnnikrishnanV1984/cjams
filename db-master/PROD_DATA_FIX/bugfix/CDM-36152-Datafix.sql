/*
  Issue Description: CDM-36152
  Root cause: Timer not turning off
  Fix provided : 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-36152', 
	updatedon = now()
where personroleid = '618072d7-5862-44ed-9940-e81a7013fc6a'
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021596769'
	and activeflag = 1 ;


select * 
from cjams.cpsresponsetimerupdate( '972f54a6-7af8-421b-aa28-7c1da7d06293'::uuid, 'CDM-36152'::character varying );
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021596769'
	and activeflag = 1;