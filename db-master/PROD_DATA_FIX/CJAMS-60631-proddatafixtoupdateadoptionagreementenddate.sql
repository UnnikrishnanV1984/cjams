/*
   Issue Description: CJAMS-60631
   Category/ Module  : Prod data fix to update Agreement end date 
   Root cause:  
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



-- 2025-05-31 04:00:00.000
update adoptioncaseagreement 
set enddate = '2026-05-31 04:00:00.000',
	updatedby = 'CJAMS-60631',
	updatedon = now()
where adoptionagreementid='3aa160c6-29dc-46a4-92b4-8b838faf4a7d'
and activeflag = 1;


update adoptioncase 
set enddate = '2026-05-31 04:00:00.000',
	updatedby = 'CJAMS-60631',
	updatedon = now()
where adoptioncaseid ='2e8708a0-a1a1-4771-81c8-acd7801904b2'
and activeflag = 1;
