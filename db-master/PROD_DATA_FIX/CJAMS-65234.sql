/*
Issue: CJAMS-65234 Can't approval Intake
Category/Module: Intake Details
Root cause:  This intake I241013140805 doesn't allow the supervisor to approve. And unable to pick option in Supervisor decision dropdown in Decision tab.
Fix provided: Data fix has been done to update the Supervisor Disposition to ScreenOUT and update the approved on date.
Data/Code fix ticket#: CJAMS-65234
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is not replicable in stage 3 and QA team is trying to reproduce.
*/
update intakedastaging
set
updatedby = 'CJAMS-65234', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I241013140805' and activeflag=1;

update routing
set activeflag=1,
updatedon= '2024-09-17 20:46:05',
supervisordecision = 'ScreenOUT',
routingstatustypeid = 8,
updatedby = '5611119d-16d8-4a4e-b045-5ab9734e01ba'
where routingid = 'd4ce3999-4567-4d64-ad7f-bc1f32aab638'
and objectid='I241013140805';