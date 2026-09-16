
/*
Issue Description: CJAMS-67803 - intake inappropriately screened for ROA
Category/Module: Case Management
Root cause: Need data fix for removing the connected case# 3062463, keep the Intake# I261014029792 for Supervisor's approval to Screen Out
Fix provided: Data fix has been promoted to remove the connected case and update the routing for supervisor's approval to screen out
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update intakeservicerequest
set servicecaseid = null,
	updatedby = 'CJAMS-67803',
	updatedon = now() 
where intakenumber = 'I261014029792';


update intakeservicerequestservice
set activeflag=0,updatedby = 'CJAMS-67803',
	updatedon = now() 
where intakeserviceid = 'e5460f96-a72c-4b5e-b7db-8a98bc1d91ca' and activeflag=1;

-- We are not updating udatedby since submittedto/Approvedby name we are getting from uodating by column
update routing
set intakerecommendation='ScreenOUT',
supervisordecision = null,
routingstatustypeid = 1, 
tosecurityusersid='293dc438-7f04-41f7-8845-e87304274c6c', updatedon = now()
where objectid='I261014029792' and routingid='0b6a5b77-bac4-48cb-aa19-14ccc5d6a903';


update  intakedastatus
set status=1, updatedby = 'CJAMS-67803',
	updatedon = now()
where intakedastatusid='bf78c9a0-2f59-4088-bb80-9d8c9bba053d';


UPDATE intakedastaging
SET jsondata = jsonb_set(
                jsonb_set(
                jsonb_set(
                jsonb_set(jsondata, '{DAType,DATypeDetail,0,DADisposition}', '"ScreenOUT"'),
                '{DAType,DATypeDetail,0,dispositioncode}', '"ScreenOUT"'),
                '{disposition,0,DADisposition}', '"ScreenOUT"'),
                '{disposition,0,dispositioncode}', '"ScreenOUT"'),   
  status = 'pending',
  ispreintake = FALSE , updatedby = 'CJAMS-67803',
  updatedon = now()
WHERE intakenumber = 'I261014029792' AND activeflag = 1;



UPDATE intakesnapshot
SET jsondata = jsonb_set(
               jsonb_set(
               jsonb_set(
               jsonb_set(
               jsonb_set(
               jsonb_set(
               jsonb_set(
               jsonb_set(
               jsonb_set(jsondata, '{DAType,DATypeDetail,0,DADisposition}', '"ScreenOUT"'),
                                   '{DAType,DATypeDetail,0,supDisposition}', '"ScreenOUT"'),
                                   '{DAType,DATypeDetail,0,dispositioncode}', '"ScreenOUT"'),
                                   '{disposition,0,DADisposition}', '"ScreenOUT"'),
                                   '{disposition,0,dispositioncode}', '"ScreenOUT"'),
                                   '{disposition,0,supDisposition}', '"ScreenOUT"'),
                                   '{intakeDATypeDetails,0,DADisposition}', '"ScreenOUT"'),
                                   '{intakeDATypeDetails,0,supDisposition}', '"ScreenOUT"'),
                                   '{intakeDATypeDetails,0,dispositioncode}', '"ScreenOUT"'), updatedby = 'CJAMS-67803',
	updatedon = now()
WHERE intakenumber = 'I261014029792' AND activeflag = 1;


UPDATE intakesnapshot
SET jsondata = jsonb_set(
               jsonb_set(
               jsonb_set(
               jsonb_set(
               jsonb_set(
               jsonb_set(jsondata, '{DAType,DATypeDetail,0,DAStatus}', '"Review"'),
                                   '{DAType,DATypeDetail,0,supStatus}', '"Review"'),
                                   '{disposition,0,DAStatus}', '"Review"'),
                                   '{disposition,0,supStatus}', '"Review"'),
                                   '{intakeDATypeDetails,0,DAStatus}', '"Review"'),
                                   '{intakeDATypeDetails,0,supStatus}', '"Review"'), updatedby = 'CJAMS-67803',
	updatedon = now()
WHERE intakenumber = 'I261014029792' AND activeflag = 1;