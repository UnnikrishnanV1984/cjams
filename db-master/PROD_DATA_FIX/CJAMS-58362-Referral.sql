/*
Issue Description: User wanted to screen out the intake close the service case and intake
Category/Module: user error
Root cause: Due to data glitch ,AR case was created by mistake . now user can not change program of a case.
Fix provided: DB queries to screen the intake out, close it.
Data/Code fix ticket#: CJAMS-58362
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: user Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--updating intakesnapshot
update intakesnapshot
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
	updatedby = 'CJAMS-58362', updatedon = now()
where intakesnapshotid = '51b86f05-6315-45eb-bf3d-3b64a5ec7508' and activeflag = 1;



--updte routing
update routing 
set routingstatustypeid = 8 , updatedby = 'CJAMS-58362', updatedon = now(),supervisordecision = 'ScreenOUT'
where routingid = '2c70b590-b800-431f-a7ba-4bc8a545a2be';


update intakeservicerequest 
set servicerequestnumber = null,updatedby = 'CJAMS-58362', updatedon = now()
where intakeserviceid = '0972208d-d47d-41dd-bdd5-2d48b587a622' and activeflag =1;
