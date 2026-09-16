/*
   Issue Description: CDM-35955
   Category/ Module  : Person
   Root cause: Answer to "was this child an active member of the household at the start of the case but left out of original referral" needs to be changed to "YES" 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-35955', 
	updatedon = now()
where personroleid in ('70dad2c3-7867-4cf9-9a17-29e6ce74a01f')
	and activeflag  = 1
	and initialresponse = 0 ;
	

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021271763'
	and activeflag = 1 ;
	


select * 
from cjams.cpsresponsetimerupdate( '92647421-1983-44e3-bdfa-db2bb24da4de'::uuid, 'CDM-35955'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021271763'
	and activeflag = 1 ;
	