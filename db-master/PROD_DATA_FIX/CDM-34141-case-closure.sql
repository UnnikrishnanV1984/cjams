/*
   Issue Description: CDM-34141
   Category/ Module  : Person tab
   Root cause:Unable to close case , as the Alleged VIctim   is not identified as an active member of the household at the start of the case.
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-34141', 
	updatedon = now()
where personroleid = '1720675c-6391-4697-9246-74ee7cc91328'
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020543748'
	and activeflag = 1 ;


select * 
from cjams.cpsresponsetimerupdate( '8dff44c8-405a-426e-8e26-20ed9ff87591'::uuid, 'CDM-34141'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020543748'
	and activeflag = 1;