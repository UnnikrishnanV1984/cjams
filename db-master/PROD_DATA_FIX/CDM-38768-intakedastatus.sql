-- CDM-38768 - Referral issue
/*
-- Issue Description: 
   SDM blank
-- Category/ Module: Intake
-- Root cause: Updates are done on the intake after the intake approval by other user. 
-- Fix provided: Datafix has been done to update intake status with 2 value
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

UPDATE cjams.intakedastatus
SET status=2, updatedby='CDM-38768', updatedon=now()
WHERE intakenumber='I241012204686' and activeflag = 1;

UPDATE cjams.intakedastaging
SET updatedon=now(), updatedby='CDM-38768', activeflag =1
WHERE id=9468959 and intakenumber='I241012204686';

UPDATE cjams.intakedastaging
SET updatedon=now(), updatedby='CDM-38768', activeflag =0
WHERE id=9469087 and intakenumber='I241012204686';

