/*
-- Issue Description: 
	CDM-29696-person removal
	 Category/ Module: 
     -- Root cause: User Request
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/


update actor set activeflag = 0, updatedby = 'CDM-29696', updatedon = now() 
where  personid ='42d7fd27-e14d-4dc3-848e-f71be2f7c93d'
and  actorid = 'c4bd5b4f-7947-4c85-9356-73b22511bf49';

update intakeservicerequestactor set activeflag = 0, updatedby = 'CDM-29696', updatedon = now() 
where  actorid ='c4bd5b4f-7947-4c85-9356-73b22511bf49'
and intakeservicerequestactorid = '0d8b2634-29e6-475b-9b6b-a91d0174eff1';

update personrole set activeflag = 0, updatedby = 'CDM-29696', updatedon = now() 
where  personid ='42d7fd27-e14d-4dc3-848e-f71be2f7c93d'
and intakenumber = 'I231010545421';

update personprogramarea set activeflag = 0, updatedby = 'CDM-29696', updatedon = now() 
where  personid ='42d7fd27-e14d-4dc3-848e-f71be2f7c93d'
and objectid = 'c7b414fc-ba0f-41db-91c4-bd59594351e1' ;