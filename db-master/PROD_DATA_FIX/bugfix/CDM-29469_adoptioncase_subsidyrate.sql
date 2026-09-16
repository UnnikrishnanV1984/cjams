/*
   Issue Description: CDM-29469
   Category/ Module  : Agreement Rate
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.adoptioncaseagreementrate
SET activeflag=0, updatedby='CDM-29469', updatedon=now()
WHERE adoptionagreementrateid='7887b183-0416-44bc-a881-a9c58cb19c8e' and adoptionagreementid='2bf955b4-41a7-405f-9803-b65455fda29d';

UPDATE cjams.adoptioncaserevision
SET activeflag=0, updatedby='CDM-29469', updatedon=now()
WHERE adoptionagreementrateid='7887b183-0416-44bc-a881-a9c58cb19c8e' and adoptionagreementid='2bf955b4-41a7-405f-9803-b65455fda29d';

UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-29469', updatedon=now()
WHERE objectid = '7887b183-0416-44bc-a881-a9c58cb19c8e';