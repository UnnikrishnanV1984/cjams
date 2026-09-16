/*
   Issue Description: CJAMS-58455 
   Category/ Module  : User Management
   Root cause: User requested to data fix to update Assessment Completed Date Time and Signed Date/time is 02/25/2025 11:30am.
   Case# 20200490972
   Assessment: Home Health Report
   User list:  shalynn.chandler@maryland.gov
   Fix Provided: Data fix has been promoted to update the assessment completed date.
   Data/Code fix ticket#: 
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#:  CDM-44290 
*/
UPDATE assessment
SET submissiondata = jsonb_set(submissiondata, '{datetimefield1}', '"2025-02-25T16:30:00.000Z"')
WHERE assessmentid = 'afa548ef-4987-4bb7-93b2-f558679777a2';

update  cjams.assessment set submissiondata = jsonb_set(submissiondata:: jsonb, '{panel2980372465884724ColumnsSignedDateandTime}', '"2025-02-25T16:30:00.000Z"')
where assessmentid =  'afa548ef-4987-4bb7-93b2-f558679777a2' and activeflag = 1;