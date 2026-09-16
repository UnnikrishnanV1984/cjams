/*
   Issue Description:CDM-33793
   Category/ Module  : Approval Inbox 
   Root cause: 
   Fix Provided: Did data fix to remove the record from approval inbox
   
*/

UPDATE cjams.routing
SET activeflag=0, updatedby='CDM-33793', updatedon=now()
WHERE routingid='53077ee8-017f-4a67-bfc9-740bcaca1ebf' and eventcode='PPLR' and objectid='21acd602-8def-459b-9c83-afb73fc1fc2a';
