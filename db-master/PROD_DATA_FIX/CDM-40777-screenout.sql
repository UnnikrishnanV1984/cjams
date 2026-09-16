/*
 Issue Description: CDM-40777
 Category/ Module : Intake/Referral
 Root cause: Refer CIDM-9167 
 Fix: Data fix to record supervison decision and status.
 Pull request# for code fix: N/A
 Reason why no related code fix: Need to do data fix before CIDM-9167 goes to production
 */

-- Supervision ScreenOUT 
UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-40777', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012563207' AND activeflag=1;

-- Change the status to Approved
update routing set routingstatustypeid = 16, updatedby = 'CDM-40777',
updatedon = now() where objectid='I241012563207'and activeflag=1;

-- New record for submission history - By  Brittany N. Lee - Status - Closed
insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('INTR', '2917733d-a46f-429c-a438-f178ce4db044', '63fb46b7-bd92-407f-914a-2ffdc3c2d81f', 'CWIW', 'CWSP', 'I241012563207' , 8, 1, 'CDM-40777',now(),'CDM-40777', now());
