/*
   Issue Description: CDM-34852
   Category/ Module  : Person
   Root cause: Answer to "was this child an active member of the household at the start of the case but left out of original referral" needs to be changed to "YES" 
   Pull request# for code fix: 
   Reason why no related code fix:  code fix done 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CDM-34852', 
	updatedon = now()
where personroleid in ('4d6d14f5-9ce0-41c7-8193-ec4b26384b23','428514d4-bbcf-4216-a88b-143bcf6f8905','e8afe9b6-2e9e-4bc8-9b88-f8d0295a55bc')
	and activeflag  = 1
	and initialresponse = 0 ;
	

    -- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021263172'
	and activeflag = 1 ;
	


select * 
from cjams.cpsresponsetimerupdate( 'daea7928-d297-4148-9b89-d9525a6fc553'::uuid, 'CDM-34852'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231021263172'
	and activeflag = 1 ;
	