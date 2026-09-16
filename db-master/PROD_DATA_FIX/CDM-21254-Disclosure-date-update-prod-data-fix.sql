/*
   Issue Description: CDM-21254
   Category/ Module  :  Updating Gap disclosure Date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/

UPDATE cjams.gapdisclosure
SET disclosuredate='2022-01-07 08:34:30.293', updatedon = now(),updatedby = 'CDM-21254'
WHERE gapid ='763b482f-6a7e-4010-9b86-29b2385c927f';


UPDATE cjams.gapdisclosure
SET disclosuredate='2022-01-25 08:34:30.293', updatedon = now(),updatedby = 'CDM-21254'
WHERE gapid ='a095766e-1648-436b-a521-9d7c6a411b74';


UPDATE cjams.gapdisclosure
SET disclosuredate='2022-04-08 08:34:30.293', updatedon = now(),updatedby = 'CDM-21254'
WHERE gapid ='ec764418-c8a3-4161-bcc2-a566fd12b533';

