/*
Issue Description:CIDM-10456 Safe-C- Bulk data fixes to add the Safety Approval Date & time with seconds
Category/Module: Safe-c 
Root cause:We are not capturing seconds in the approval date in the Web code and data fix is needed to add seconds to the approval date timestamp.
           Code fix is done to resolve this issue but exiting records with cases having same timestamp will need a data fix.
           Cases for which data fix is needed :
            personid    case number
            204115901 - 231030143055 
            204079635 - 221030013654 
            201014487 - 251030450523 
            204081013 - 231030189927 
            204085211 - 3253086 
            201446917 - 251030477009 
            204054463 -251030444304 
            202824403 - 251030452163 
Fix provided: Data fix to add seconds in the approval date time stamp. Reporting team needs to validate it from their end.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CIDM-10452
Reason why no related code fix: N/A
*/

--Safe-c assessements in Servicecase number 251030450523  (4edbbac7-94f3-456b-8512-228ea098d25e) 

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-03-21T14:45"' , 
'"safetyassessmentapprovaldate": "2025-03-21T14:45:32"')::json, updatedon = now()
where assessmentid = '116c95bf-a2fc-44a7-a756-f5f6c8d6d520' and activeflag = 1;



update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-03-21T14:45"' , 
'"safetyassessmentapprovaldate": "2025-03-21T14:46:03"')::json, updatedon = now()
where assessmentid = 'c5baea1e-d2f1-4ac0-bd08-ba5949b64163' and activeflag = 1;

--Safe-c assessements in Servicecase number 231030143055  (4edbbac7-94f3-456b-8512-228ea098d25e) 

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-04-21T12:24"' , 
'"safetyassessmentapprovaldate": "2025-04-21T12:24:47"')::json, updatedon = now()
where assessmentid = '2aa12630-ab24-4c6c-8b93-45251b2f4c3b' and activeflag = 1;



update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-04-21T12:24"' , 
'"safetyassessmentapprovaldate": "2025-04-21T12:25:02"')::json, updatedon = now()
where assessmentid = '44bc933c-976b-4fb4-be6e-5be414e19a96' and activeflag = 1;

--Safe-c assessements in Servicecase number 231030143055  (4edbbac7-94f3-456b-8512-228ea098d25e) CPS/Case ID -231021306414

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2023-12-05T13:51"' , 
'"safetyassessmentapprovaldate": "2023-12-05T14:27:30"')::json, updatedon = now()
where assessmentid = '9869df04-1751-4c8c-a715-a5e3422f7294' and activeflag = 1;



update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2023-12-05T13:51"' , 
'"safetyassessmentapprovaldate": "2023-12-05T14:27:33"')::json, updatedon = now()
where assessmentid = 'ed73174c-88ac-4c7a-95e0-d1c2b24523f2' and activeflag = 1;


--Safe-c assessements in Servicecase number 221030013654  (3fc992e7-95ca-44ec-ae54-e7609e4e9f30) 

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-03-25T10:39"' , 
'"safetyassessmentapprovaldate": "2025-03-25T10:39:33"')::json, updatedon = now()
where assessmentid = '7f04457f-0b95-435c-844d-1c6cd1f8dc1e' and activeflag = 1;



update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate":"2025-03-25T10:39"' , 
'"safetyassessmentapprovaldate": "2025-03-25T10:40:20"')::json, updatedon = now()
where assessmentid = 'a1cc25af-46d7-4d1f-87a3-df5a4d1c89f5' and activeflag = 1;


--Safe-c assessements in Servicecase number 231030189927  (11709250-c1ec-4e67-9514-73b37f9ecef7) 

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-03-17T12:16"' , 
'"safetyassessmentapprovaldate": "2025-03-17T12:16:18"')::json, updatedon = now()
where assessmentid = '35690c66-efb3-4649-87a7-b417993108a0' and activeflag = 1;



update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate":"2025-03-17T12:16"' , 
'"safetyassessmentapprovaldate": "2025-03-17T12:16:34"')::json, updatedon = now()
where assessmentid = '5eff4789-f33a-4301-9a1a-4ba719cd7a2b' and activeflag = 1;

--Safe-c assessements in Servicecase number 3253086  (8ead744f-3a7f-4be6-a063-290c805bd7ea) 

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-03-18T09:34"' , 
'"safetyassessmentapprovaldate": "2025-03-18T09:34:49"')::json, updatedon = now()
where assessmentid = '3550a549-23f5-4e97-bd38-988bdb1ca399' and activeflag = 1;



update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate":"2025-03-18T09:34"' , 
'"safetyassessmentapprovaldate": "2025-03-18T09:35:19"')::json, updatedon = now()
where assessmentid = '2eed3035-f55f-4a31-9867-75701df3e3bf' and activeflag = 1;

--Safe-c assessements in Servicecase number 251030477009  

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-03-13T08:15"' , 
'"safetyassessmentapprovaldate": "2025-03-13T08:15:35"')::json, updatedon = now()
where assessmentid = '857ad60e-6d49-4071-807d-2b481e69b71f' and activeflag = 1;



update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate":"2025-03-13T08:15"' , 
'"safetyassessmentapprovaldate": "2025-03-13T08:15:20"')::json, updatedon = now()
where assessmentid = '942a5aac-31bb-4443-b5f5-d3d76a3578eb' and activeflag = 1;

--Safe-c assessements in Servicecase number 251030444304 (ad2cceee-fa4f-44bc-94c2-61dd112145d8)  

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-02-24T12:14"' , 
'"safetyassessmentapprovaldate": "2025-02-24T12:14:23"')::json, updatedon = now()
where assessmentid = '34269bfb-5145-42a2-88a8-3a81186585e2' and activeflag = 1;



update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate":"2025-02-24T12:14"' , 
'"safetyassessmentapprovaldate": "2025-02-24T12:14:40"')::json, updatedon = now()
where assessmentid = 'a5ceea99-7ec1-4ea7-b7ae-c3ee922a8236' and activeflag = 1;

--Safe-c assessements in Servicecase number 251030452163 (c7743953-10bb-49a4-a0d5-0abf2a0fe573)  

update assessment 
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate": "2025-01-23T09:44"' , 
'"safetyassessmentapprovaldate": "2025-01-23T09:44:19"')::json, updatedon = now()
where assessmentid = '4fd81754-5d49-46a5-a7e5-a43904990ebe' and activeflag = 1;



update assessment
set submissiondata = replace(submissiondata::text, '"safetyassessmentapprovaldate":"2025-01-23T09:44"' , 
'"safetyassessmentapprovaldate": "2025-01-23T09:44:37"')::json, updatedon = now()
where assessmentid = '444b5284-0015-44ad-8042-c0753cedf55f' and activeflag = 1;