/*
   Issue Description: CDM-39161
   Category/ Module  : Persons
   Root cause:The Question " Was this child an active member of the household at the start of the case but not included on the referral? '' is marked as 'No' for the Alleged Victim and that needs to be changed to 'Yes'. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update
    personrole
set
    updatedby = 'CDM-39161',
    updatedon = now(),
    initialresponse = 1
where
    activeflag=1 and intakeserviceid='da6ff728-bac6-465a-89fc-7877f28459ba' and initialresponse is not null;

----To stop Timer
	
select * from cjams.cpsresponsetimerupdate( 'da6ff728-bac6-465a-89fc-7877f28459ba'::uuid, 'CDM-39161'::character varying ) ;