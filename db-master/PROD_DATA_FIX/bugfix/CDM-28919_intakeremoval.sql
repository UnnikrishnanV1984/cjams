/*
   Issue Description: CDM-28919
   Category/ Module  :Child Removal
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- CDM-26370 Previous data fix
UPDATE cjams.intakeservreqchildremoval
SET agencysigneddate='2021-09-30', updatedby='CDM-28919', updatedon=now()
 WHERE intakeservreqchildremovalid='4ba6f9ea-6de0-4de3-b07f-762b82bb9c2b';
