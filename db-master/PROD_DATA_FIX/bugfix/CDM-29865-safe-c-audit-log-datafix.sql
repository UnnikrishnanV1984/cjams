/*
   Issue Description: CDM-29865
   Category/ Module  : Audit Logs
   Root cause: Updated by is displaying wrong user
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- User requested to change the updated by to 'Alicia Snoots'
update assessment_history
set updatedby = '6af7a326-0572-4e9c-9d19-e15e2949c5fe'
where assessmenthistoryid = '989609b3-4f91-472c-acbb-572eb0fd9d66';