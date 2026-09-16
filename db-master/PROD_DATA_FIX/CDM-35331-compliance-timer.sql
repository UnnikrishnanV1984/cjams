/*
   Issue Description: CDM-35331
   Category/ Module  : Person
   Root cause: Answer to "was this child an active member of the household at the start of the case but left out of original referral" needs to be changed to "YES" 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-35331', 
	updatedon = now()
where personroleid in ('a2095f9a-1583-451a-ac18-bab6126f5a31','ed630d2a-5600-45ad-825b-8ad50aabdb7f')
	and activeflag  = 1
	and initialresponse = 0 ;
	

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021284712'
	and activeflag = 1 ;
	


select * 
from cjams.cpsresponsetimerupdate( '309d406d-9b7d-4406-a7c9-c6888d7e6ef3'::uuid, 'CDM-35331'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021284712'
	and activeflag = 1 ;
	