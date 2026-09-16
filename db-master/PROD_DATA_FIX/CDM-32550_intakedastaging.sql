/*
   Issue Description: CDM-32550
   Category/ Module  : Duplicate Intake records
   Root cause: Duplicate active records in tntake table(both records got inserted with split second)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.intakedastaging
SET updatedon=now(), updatedby='CDM-32550', activeflag=0
WHERE id=6989276 and intakenumber='I231010688018';
