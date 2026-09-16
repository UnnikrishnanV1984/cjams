/*
  Issue Description: CDM-32405
  Root cause: AR Summary 
  Fix provided : Unable to submit case for closure
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  

*/
update personrole
set initialresponse = 1,
	updatedby = 'CDM-32405', 
	updatedon = now()
where personroleid = '3da7fe56-b5be-4ded-ad3f-adb07f8c1297'
	and activeflag  = 1
	and initialresponse = 0 ;

-- To Stop the timer
-- Before     

select intakeserviceid, responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020513630';

select * 
from cjams.cpsresponsetimerupdate( '8aa70ab9-ffba-4f89-a68e-9679bfb08d22'::uuid, 'CDM-32405'::character varying ) ;

-- After

select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020513630'
	and activeflag = 1;