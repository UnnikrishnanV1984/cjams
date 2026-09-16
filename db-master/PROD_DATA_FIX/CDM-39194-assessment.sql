/*
   Issue Description: CDM-39194
   Category/ Module  : Safec-ohp 
   Root cause: Safec ohp after child selection client id field is editable 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix to update client id
*/

update assessment 
set submissiondata = replace(submissiondata::text, '"clientid": "201011051"' , '"clientid": "201011010"')::json
where assessmentid = '56820f7d-4263-4abf-88d2-2d4c9eccf740';

UPDATE cjams.assessmentactor
SET intakeservicerequestactorid='86c88cf0-630b-418a-8c32-52072b99cd75', updatedby='CDM-39194', updatedon=now()
WHERE assessmentid='56820f7d-4263-4abf-88d2-2d4c9eccf740' and activeflag=1;
