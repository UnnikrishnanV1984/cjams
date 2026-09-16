
/*
Issue: CJAMS-64796 Supervisor Decision not showing on Intake Details page
Category/Module: Intake Details
Root cause: Supervisor decision was not showing on intake details page as the DA Disposition and Supervisor Disposition were not updated in the database.
Fix provided:  Data fix has been done to update the DA Disposition and Supervisor Disposition
Data/Code fix ticket#: CJAMS-64796
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Issue is not replicable in stage 3 and QA team is trying to reproduce.
*/
update intakedastaging
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(jsondata ,'{DAType,DATypeDetail,0,DADisposition}','"ScreenOUT"',false ),
					'{DAType,DATypeDetail,0,supDisposition}','"ScreenOUT"',false),
				'{disposition,0,DADisposition}','"ScreenOUT"',false),
			'{disposition,0,supDisposition}','"ScreenOUT"',false),
		'{intakeDATypeDetails,0,DADisposition}','"ScreenOUT"',false),
	'{intakeDATypeDetails,0,supDisposition}','"ScreenOUT"',false), 
	updatedby = 'CJAMS-64796',
	updatedon = now()
where intakenumber = 'I261013815083' and activeflag = 1;