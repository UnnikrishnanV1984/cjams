/*
   Issue Description: CDM-29039
   Category/ Module  :As requested by user. Change already done on sailpoint
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Issue Description: User asked to revert AR Summary Status from Approve to Draft
*/

UPDATE cjams.userprofile
SET firstname='Katie', displayname='KatieSkinner', fullname='Katie Skinner', updatedby='CDM-29039', updatedon=now()
WHERE securityusersid='3dc5f025-9f68-4812-88e2-c7ef4fbde6c6' and email='katie.skinner@maryland.gov';

UPDATE cjams.muser
SET username='Katie Skinner', updatedby='CDM-29039', updatedon=now()
WHERE  securityusersid='3dc5f025-9f68-4812-88e2-c7ef4fbde6c6' and email='katie.skinner@maryland.gov';

