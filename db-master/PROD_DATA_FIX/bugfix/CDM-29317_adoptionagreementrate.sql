/*
   Issue Description: CDM-29317
   Category/ Module  : Agreement Rate
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.adoptioncaseagreementrate
SET activeflag=0, updatedby='CDM-29317', updatedon=now()
WHERE adoptionagreementrateid='ed841027-10ae-4bdc-92a6-1433a9248bb1' and adoptionagreementid='d344b83c-07ef-4b06-bdfc-8833a988ab1f';

UPDATE cjams.adoptioncaserevision
SET activeflag=0, updatedby='CDM-29317', updatedon=now()
WHERE adoptionagreementrateid='ed841027-10ae-4bdc-92a6-1433a9248bb1' and adoptionagreementid='d344b83c-07ef-4b06-bdfc-8833a988ab1f';

UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-29317', updatedon=now()
WHERE objectid = 'ed841027-10ae-4bdc-92a6-1433a9248bb1';

