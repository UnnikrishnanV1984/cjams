/*
   Issue Description: CDM-31471
   Category/ Module  : Agreement Rate
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.adoptioncaserevision set activeflag =0, updatedby ='CDM-31471', updatedon = now()
where adoptionagreementrateid ='d124965b-cb60-4eba-9e07-934f47ed98d7' and adoptionagreementid ='b0f1166d-832f-4305-99f4-ff4c2ccdef1f';

UPDATE cjams.adoptioncaseagreementrate
set activeflag =0, updatedby ='CDM-31471', updatedon = now()
where adoptionagreementrateid ='d124965b-cb60-4eba-9e07-934f47ed98d7' and adoptionagreementid ='b0f1166d-832f-4305-99f4-ff4c2ccdef1f';

UPDATE cjams.routing
set activeflag =0, updatedby ='CDM-31471', updatedon = now()
WHERE objectid = 'd124965b-cb60-4eba-9e07-934f47ed98d7';