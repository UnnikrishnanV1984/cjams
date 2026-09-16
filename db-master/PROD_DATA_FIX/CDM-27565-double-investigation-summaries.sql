/*
   Issue Description: CDM-27565
   Category/ Module  : duplicate findings
   Root cause: User requested to remove the role for the person ashley
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE
    investigationallegation
SET
    activeflag = 0,
    updatedby = 'CDM-27565',
    updatedon = now()
where investigationallegationid in ('95de9a04-e8b0-49b8-9553-d7fcca304be9','13af94c6-6dd7-42c6-abf0-fbe647d66420');