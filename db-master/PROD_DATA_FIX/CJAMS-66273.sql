
/*
Issue: Cannot approve the case 
Category/Module: Intake
Root cause: Referral #I261013954608 is unable to be approved by the supervisor it does not offer the approve option.
Fix provided: Data fix has been done to update the supervisor decision to 'Screen Out' for referral #I261013954608.
Data/Code fix ticket#: CJAMS-66273
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Screen Out fixed on the database.
Status of the code fix: Data fix completed, PR raised for documentation.
*/
update intakesnapshot
set
updatedby = 'CJAMS-66273', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I261013954608' AND activeflag=1;

update routing set routingstatustypeid = 8, supervisordecision = 'screenout'
where objectid='I261013954608' and routingid='3b79e840-6c7e-4f67-9cd2-22efb3eb558c';