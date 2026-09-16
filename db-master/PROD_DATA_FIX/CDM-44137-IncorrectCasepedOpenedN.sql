
/*
Issue Description: User wanted to screen out the intake and remove the case connection then close the service case and intake.
Category/Module: user error
Root cause: user can not change program of a case.
Fix provided: DB queries to screen the intake out, close it, and remove the service case.
Data/Code fix ticket#: CDM-44137
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
	updatedby = 'CDM-44137', updatedon = now()
where intakesnapshotid = 'c229f3a9-f426-4902-ab6e-c933eda80890' and activeflag = 1;



update  intakedastaging
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(jsondata, '{DAType, DATypeDetail, 0, supDisposition}', '"ScreenOUT"', true),
					'{DAType, DATypeDetail, 0, dispositioncode}', '"ScreenOUT"', true),
				'{disposition, 0, supDisposition}', '"ScreenOUT"', true),
			'{disposition, 0, dispositioncode}', '"ScreenOUT"', true),
		'{intakeDATypeDetails, 0, supDisposition}', '"ScreenOUT"', true),
	'{intakeDATypeDetails, 0, dispositioncode}', '"ScreenOUT"', true),updatedby = 'CDM-44137', updatedon = now()
where id = 11680811 and activeflag = 1;

--updte routing
update routing 
set routingstatustypeid = 8 , updatedby = 'CDM-44137', updatedon = now(),supervisordecision = 'ScreenOUT'
where routingid = '7e2a5965-9d5d-4d18-9f35-6b864fba6cf1' and activeflag = 1;

--updte routing
update routing 
set activeflag = 0, updatedby = 'CDM-44137', updatedon = now()
where routingid = '7e2a5965-9d5d-4d18-9f35-6b864fba6cf1' and activeflag = 1;



--update servicecase
update servicecase 
set statustypekey = 'Closed',dispositioncode = 'Closed',updatedby = 'CDM-44137', updatedon = now(), startdate = '2025-01-31 16:17:36.160',
enddate = '2025-02-04 09:29:56.386'
where servicecaseid = '2b73424f-166c-432c-947b-c2002482a2c4' and activeflag = 1;

--update caseassignment
update caseassignment
set  updatedon = now() ,updatedby = 'CDM-44137',activeflag = 0
where caseassignmentid  = '086dfee7-a9b2-4ade-94de-d916b3d46f3d' and activeflag = 1; 


--update intakeservicerequest
update intakeservicerequest
set servicecaseid = null, updatedon = now(),updatedby = 'CDM-44137'
where intakeserviceid = '279dc701-b7d2-41bb-b9e5-fed0f0614dab';

--update servicecasedisposition 
update servicecasedisposition 
set activeflag = 0,  updatedon = now(),updatedby = 'CDM-44137'
where servicecasedispositionid in ('f1ee2c32-ee67-405c-b5e5-47ce7af2d080', '9c20aa58-c0d6-4b83-ba64-338878264501') and activeflag =1;
