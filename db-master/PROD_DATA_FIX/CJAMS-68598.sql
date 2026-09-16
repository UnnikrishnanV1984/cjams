/*
Issue: CJAMS-68598 Referral stuck in assignment. 
Category/Module: screen out referral
Root cause: This issue is not replicable in staging environment, upon intake screen in we are able to create a case succesfully ,its some times happening in production and its a known issue and OPS BA team informed CW team to look on the exact root cause on this issue , 
            as of now  User wants to screenout this intake 
Fix provided:  Data fix is done to  screenout the intake  I261014112437
Data/Code fix ticket#: CJAMS-68598
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Not Replicable in staging environment
*/
UPDATE intakesnapshot
SET
updatedby = 'CJAMS-68598', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I261014112437' AND activeflag=1;


UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CJAMS-68598', updatedon = now()
WHERE intakenumber = 'I261014112437' AND activeflag=1;

--- We are not updating udatedby since submittedto/Approvedby name we are getting from uodating by column
Update routing set 
routingstatustypeid = 8, activeflag=0, supervisordecision = 'screenout', updatedon= now()
WHERE objectid = 'I261014112437' and routingid='cee5e959-61d2-4180-a655-6b303be0d4cd';

update intakeDAStatus set status = 8, updatedby = 'CJAMS-68598', updatedon = now() 
where intakenumber = 'I261014112437' and activeflag =1;