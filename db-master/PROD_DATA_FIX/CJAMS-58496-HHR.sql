/* 
    Issue Description: CJAMS-58429
   Category/ Module  : Assessment Health Report 
   Root cause: User requested to update Assessment Completed Date Time, Due to recent user story changes user is unable to update the date after Feb 2025
   Pull request# for code fix: 
   Reason why no related code fix: Code Fix, discussion is in progress 
*/

update  cjams.assessment set submissiondata = jsonb_set(submissiondata:: jsonb, '{datetimefield1}', '"2025-03-17T15:30:00.000Z"'),
updatedby ='CJAMS-58496', updatedon = now()
where assessmentid =  '42303e8f-c3ff-4b79-8c01-55f9cf8fff2a'  and activeflag = 1;