/*
  Issue Description:  CDM-42388
   Category/ Module  : Payments
   Root cause: User request to change the end date
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

update adoptioncaseagreementrate 
set enddate  = '2025-09-10 00:00:00',
    updatedon = now(), 	
	updatedby = 'CDM-42388'
where
adoptionagreementid = 'e90243e6-ffd0-4c3f-bd32-0ec0e6dfca50' 
and adoptionagreementrateid = '6d4f2419-fe5f-4406-8c22-431b95f6c189'
and activeflag = 1;

update adoptioncaserevision 
set     enddate  = '2025-09-10 00:00:00',
    updatedon = now(), 	
	updatedby = 'CDM-42388'
where
adoptionagreementid = 'e90243e6-ffd0-4c3f-bd32-0ec0e6dfca50' and adoptionagreementrateid =  '6d4f2419-fe5f-4406-8c22-431b95f6c189'
and adoptionrevisionid = 'f8abcd06-1245-4bb8-b80b-3f7708ee00bc' and
activeflag = 1;


update adoptioncaseagreement 
set providerid = 5086736, 
	parent1providerid = 5086736, 
	parent1providername = 'Samantha Moats', 
	parent2providerid = 6161792,  
	parent2providername = 'Gary Moats', 
    effectiveswitchdate = null,
	switchproviderreason = null,
	updatedby = 'CDM-42388',
	updatedon = now()
where adoptioncaseid = 'e6ad3db7-aafb-431d-86ae-6768d22ecfcd' and adoptionagreementid = 'e90243e6-ffd0-4c3f-bd32-0ec0e6dfca50'
	and activeflag  = 1 ;