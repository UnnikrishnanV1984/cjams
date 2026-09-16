/*
Issue Description:CIDM-10456 Safe-C-Data fix to add the seconds in in the Safe-c assessment
Category/Module: Safe-c
Root cause:We are not capturing seconds in the approval date in the Web code and data fix is needed to add seconds to the approval date timestamp.
           Code fix is done to resolve this issue but exiting records with cases having same timestamp will need a data fix.
           Cases for which data fix is needed :
            personid    case number
            204110827   251030486604
            204134479   221030016857
Fix provided: Data fix to add seconds in the approval date time stamp. Reporting team needs to validate it from their end.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10537
Reason why no related code fix: N/A
*/


--Safe-c assessements in Servicecase number 221030016857  (234c67a6-ca2e-4bb4-b828-0f2f853d539a) 
update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-05-07T09:56"' , 
'"safetyassessmentapprovaldate": "2025-05-07T09:56:37"')::json, updatedon = now()
where assessmentid = '80a107e9-3dab-4b8b-b202-b4f396c1d772' and activeflag = 1;

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-05-07T09:56"' , 
'"safetyassessmentapprovaldate": "2025-05-07T09:57:08"')::json, updatedon = now()
where assessmentid = 'e047bf1c-730f-420f-abc2-bf0b0f1d2df0' and activeflag = 1;


--Safe-c assessements in Servicecase number 251030486604  (7ecb6d4b-2f51-4899-89ae-ee47495095bc) 

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-05-06T08:44"' , 
'"safetyassessmentapprovaldate": "2025-05-06T08:44:09"')::json, updatedon = now()
where assessmentid = 'd864690e-8997-4460-a140-2e9d3558e270' and activeflag = 1;

update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-05-06T08:44"' , 
'"safetyassessmentapprovaldate": "2025-05-06T08:44:28"')::json, updatedon = now()
where assessmentid = '70de49e9-659f-4b0d-9f99-be1aba5d755c' and activeflag = 1;
