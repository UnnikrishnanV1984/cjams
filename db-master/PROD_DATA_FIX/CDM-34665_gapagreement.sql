/*
   Issue Description: CDM-34665
   Category/ Module  : Gap Agreement
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

UPDATE cjams.gapagreement
SET startdate='2023-09-01 10:00:00.000', updatedby='CDM-34665', updatedon=now()
WHERE gapagreementid='0a6fe181-d731-415b-acec-4aea325abcd3'::uuid;
