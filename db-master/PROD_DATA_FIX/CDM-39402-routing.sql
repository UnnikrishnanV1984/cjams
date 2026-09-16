/*
   Issue Description: CDM-39402
   Category/ Module : Payment Approval
   Root cause: 
   Fix Provided: Did data fix to activate approval record
*/
UPDATE cjams.routing
SET  activeflag=1, updatedby='CDM-39402', updatedon=now()
WHERE routingid='8e5074d7-1413-43cb-89ce-450486f042c6' and objectid='3255649';
