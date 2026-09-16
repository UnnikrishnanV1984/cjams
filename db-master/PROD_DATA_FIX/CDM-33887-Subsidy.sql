/*
   Issue Description: CDM-33887
   Category/ Module  : Agreement Rate
   Root cause: As requested by user
   Fix Privided: Did data fix to remove that record 
*/

update cjams.adoptioncaseagreementrate set activeflag  =0, updatedby='CDM-33887' , updatedon  = now()
where adoptionagreementrateid  ='3fa8e91c-e4fb-4e31-8f8d-0f20a6bc63d9' and adoptionagreementid  ='8a46021f-b8aa-476c-94ef-264335bcd175';

update cjams.adoptioncaserevision set activeflag  =0, updatedby='CDM-33887' , updatedon  = now()
where adoptionagreementrateid  ='3fa8e91c-e4fb-4e31-8f8d-0f20a6bc63d9' and adoptionagreementid  ='8a46021f-b8aa-476c-94ef-264335bcd175';

UPDATE cjams.routing
set activeflag =0, updatedby ='CDM-33887', updatedon = now()
WHERE objectid = '3fa8e91c-e4fb-4e31-8f8d-0f20a6bc63d9';