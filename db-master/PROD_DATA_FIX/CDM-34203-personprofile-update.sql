/*
   Issue Description: CDM-34203
   Category/ Module  : Person
   Root cause: Answer to "was this child an active member of the household at the start of the case but left out of original referral" needs to be changed to "YES" 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-34203', 
	updatedon = now()
where personroleid = '7c65a3d7-bed8-4ec7-9a11-3fe88cab63de'
	and activeflag  = 1
	and initialresponse = 0 ;

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021007326'
	and activeflag = 1 ;


select * 
from cjams.cpsresponsetimerupdate( 'd190df05-7a6d-4ec9-ac44-d7add7a99972'::uuid, 'CDM-34203'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021007326'
	and activeflag = 1;