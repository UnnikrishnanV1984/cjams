/*
   Issue Description: CDM-34201
   Category/ Module  : Person
   Root cause: Answer to "was this child an active member of the household at the start of the case but left out of original referral" needs to be changed to "YES" 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-34201', 
	updatedon = now()
where personroleid = 'e7ccc189-3b28-4ff4-8557-65f2bae4ee2d'
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021030085'
	and activeflag = 1 ;


select * 
from cjams.cpsresponsetimerupdate( '0674b4a0-2877-4536-a98e-2d03091c5f74'::uuid, 'CDM-34201'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021030085'
	and activeflag = 1;