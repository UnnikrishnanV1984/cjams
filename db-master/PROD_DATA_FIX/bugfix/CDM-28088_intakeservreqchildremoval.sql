/*
   Issue Description: CDM-28088
   Category/ Module  : Child Removal
   Pull request# for code fix: 
   Reason why no related code fix: Fix should be done from corticon 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.intakeservreqchildremoval
SET updatedby='CDM-28088', updatedon=now(), vpayouthsigneddate='2021-09-15'
WHERE intakeservreqchildremovalid='d3527a52-0fa8-4776-8ad7-58626d7793e7' and removalid=253086;
