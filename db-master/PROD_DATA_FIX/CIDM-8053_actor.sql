/*
   Issue Description: CIDM-8053 person missing 
   Category/ Module  :  Person Module
   Root cause: Intake was connected to new servicecase then data fix was done to delete the old case and link to existing case, 
               Servicecaseid was not updated for one person.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: cisclientid=446060269, personidentifiervalue='MDT-136348895'
*/

UPDATE cjams.actor
SET servicecaseid='6f7e9069-5319-4a0e-b861-9fa852f814e5'::uuid, updatedby='CIDM-8053', updatedon=now()
WHERE actorid='44d62eac-185a-47b3-8a59-dbca2aee4f15'::uuid;
