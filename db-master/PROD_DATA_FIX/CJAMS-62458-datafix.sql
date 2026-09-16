/*
   Issue Description: CJAMS-62458
   Category/ Module  : User requested to do a data fix to change the value for "Was this child an active 
   member of the household at the start of the case but not included on the referral?*" from No to Yes.
   Root cause: User requested to do a data fix to change the value for "Was this child an active member of the household at the start 
   of the case but not included on the referral?*" from No to Yes.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update personrole
set initialresponse = 1,
	updatedby = 'CJAMS-62458', 
	updatedon = now()
where intakeserviceid = '48698503-55bf-4c36-ae40-cbab72676a1b' 
    and personid = '65048e3e-fb6d-4793-8c7c-04f2690a304a'
	and activeflag  = 1
	and initialresponse = 0;

select * 
from cjams.cpsresponsetimerupdate( '48698503-55bf-4c36-ae40-cbab72676a1b'::uuid, 'CJAMS-62458'::character varying );