/*
   Issue Description: CDM-23395
   Category/ Module  : 181 issues
   Root cause: User requested to remove the Quartz brown from investigation findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE
    investigationallegation
SET
    activeflag = 0,
    updatedby = 'CDM-23395',
    updatedon = now()
where investigationallegationid ='8df38e53-e04c-4836-a456-3fd019969fc6';