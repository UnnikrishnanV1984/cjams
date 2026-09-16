/*
Issue Description:CJAMS-62888
SAFE-C date needs to be corrected
Category/Module: Assessments: SAFE-C
Root cause: Data fix to update the Safe-c assessment completion date and time from 10/10/2025 1:00 pm to 09/29/2025 12.45 PM 
in a closed service case# 241030425065
Fix provided: Data fix to update the Safe-c assessment completion date and time from 10/10/2025 1:00 pm to 09/29/2025 12.45 PM 
in a closed service case# 241030425065
Data/Code fix ticket#: CDM-42918
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update  cjams.assessment set submissiondata = jsonb_set(submissiondata:: jsonb, '{safetyassessmentcompletiondate}', '"2025-09-29T12:45"'),
        updatedon = NOW()
  where assessmentid='77a281a2-2e42-4065-8093-869dfc5ef104'
  and activeflag =1 ;
