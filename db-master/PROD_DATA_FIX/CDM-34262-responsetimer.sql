/*
   Issue Description: CDM-34262
   Category/ Module  : Person
   Root cause: Answer to "was this child an active member of the household at the start of the case but left out of original referral" needs to be changed to "YES" 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-34262', 
	updatedon = now()
where personroleid = '5c480ca5-8caf-4485-bf32-9aa7c8da92cb'
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021069309'
	and activeflag = 1 ;


select * 
from cjams.cpsresponsetimerupdate( 'fe63608e-552f-4325-9542-214d2fa4187e'::uuid, 'CDM-34262'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021069309'
	and activeflag = 1;