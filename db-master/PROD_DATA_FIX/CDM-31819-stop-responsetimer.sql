/*
   Issue Description: CDM-31819
   Category/ Module  : Response Timer
   Root cause: Reaponse timer not stopped 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-31819', 
	updatedon = now()
where personroleid = '8e6a192d-728d-4ee0-8abe-6b47fe82ff05'
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020552931'
	and activeflag = 1 ;


select * 
from cjams.cpsresponsetimerupdate( '5a2ffaee-30ec-48a3-b81e-2f0578dd5acc'::uuid, 'CDM-31819'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020552931'
	and activeflag = 1;