/*
   Issue Description: CDM-36000
   Category/ Module  : Person
   Root cause: Answer to "was this child an active member of the household at the start of the case but left out of original referral" needs to be changed to "YES" 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-36000', 
	updatedon = now()
where personroleid in ('e5f9a33d-82e6-4d31-9403-edf67c91b252')
	and activeflag  = 1
	and initialresponse = 0 ;
	

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021287111'
	and activeflag = 1 ;
	


select * 
from cjams.cpsresponsetimerupdate( 'c443f4c2-a08d-4e5d-ae0c-f0cf2c060d96'::uuid, 'CDM-36000'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021287111'
	and activeflag = 1 ;
	