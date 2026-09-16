/* 
    Issue Description: CJAMS-58478
   Category/ Module  : Assessment Health Report 
   Root cause: User requested to update Assessment Completed Date Time, Due to recent user story changes user is unable to update the date after Feb 2025
   Pull request# for code fix: 
   Reason why no related code fix: Code Fix, discussion is in progress 
*/

update  cjams.assessment set submissiondata = jsonb_set(submissiondata:: jsonb, '{datetimefield1}', '"2025-03-12T14:00:00.000Z"'),
updatedby ='CJAMS-58478', updatedon = now()
where assessmentid =  '9f3d7ba7-0a6f-44f9-b6d1-2c778be6de12' and activeflag = 1;

update  cjams.assessment set submissiondata = jsonb_set(submissiondata:: jsonb, '{panel2980372465884724ColumnsSignedDateandTime}', '"2025-03-12T14:00:00.000Z"'),
updatedby ='CJAMS-58478', updatedon = now()
where assessmentid =  '9f3d7ba7-0a6f-44f9-b6d1-2c778be6de12' and activeflag = 1;