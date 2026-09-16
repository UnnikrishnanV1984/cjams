/*
   Issue Description: CDM-35130
   Category/ Module  : Person
   Root cause: Answer to "was this child an active member of the household at the start of the case but left out of original referral" needs to be changed to "YES" 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-35130', 
	updatedon = now()
where personroleid ='05e25fa6-43d2-4210-b6ca-49cc30ddbd82'
	and activeflag  = 1
	and initialresponse = 0 ;
	

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021179758'
	and activeflag = 1 ;
	


select * 
from cjams.cpsresponsetimerupdate( 'b3c139ca-120c-4ba4-ba4f-f1b8224b2b33'::uuid, 'CDM-35130'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021179758'
	and activeflag = 1 ;
	