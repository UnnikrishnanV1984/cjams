/*
Issue: remove the case connect between intake I251013359318 and service case 211030009831. Screen out the intake #I251013359318.
Root Cause:As per system design, the Supervisor override is not available for a screened in RFS intake. User is asking to remove the case connect between intake I251013359318 and service case 211030009831.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table and  routing table..
Data/Code fix ticket#: CJAMS-62124
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/



update intakeservicerequest
set  servicecaseid = null,updatedby = 'CJAMS-62124',updatedon =now()
where intakeserviceid ='cdbc6818-d683-4f22-af3f-8da8e1219008' ;
--Do administrative override and screen out the intake.,Update Reason for delay
update intakedastaging
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(
								jsonb_set(jsondata ,'{DAType,DATypeDetail,0,DADisposition}','"ScreenOUT"',false ),
							'{DAType,DATypeDetail,0,reason}','"staffing/ supervisor delays"',false ),
					'{DAType,DATypeDetail,0,supDisposition}','"ScreenOUT"',false),
					'{DAType,DATypeDetail,0,dispositioncode}','"ScreenOUT"',false),
				'{disposition,0,DADisposition}','"ScreenOUT"',false),
			'{disposition,0,supDisposition}','"ScreenOUT"',false),
		'{intakeDATypeDetails,0,DADisposition}','"ScreenOUT"',false),
	'{intakeDATypeDetails,0,supDisposition}','"ScreenOUT"',false),
	updatedby = 'CJAMS-62124', updatedon = now()
where intakenumber = 'I251013359318' and activeflag = 1;

update intakesnapshot
set jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsonb_set(
					jsonb_set(
						jsonb_set(
							jsonb_set(
								jsonb_set(jsondata ,'{DAType,DATypeDetail,0,DADisposition}','"ScreenOUT"',false ),
							'{DAType,DATypeDetail,0,reason}','"staffing/ supervisor delays"',false ),
					'{DAType,DATypeDetail,0,supDisposition}','"ScreenOUT"',false),
					'{DAType,DATypeDetail,0,dispositioncode}','"ScreenOUT"',false),
				'{disposition,0,DADisposition}','"ScreenOUT"',false),
			'{disposition,0,supDisposition}','"ScreenOUT"',false),
		'{intakeDATypeDetails,0,DADisposition}','"ScreenOUT"',false),
	'{intakeDATypeDetails,0,supDisposition}','"ScreenOUT"',false),
	updatedby = 'CJAMS-62124', updatedon = now()
where intakenumber = 'I251013359318' and activeflag = 1;


update routing
set routingstatustypeid='8',activeflag =1,eventcode ='INTR',intakerecommendation='ScreenOUT',supervisordecision='ScreenOUT',updatedby='299210ac-c6df-4985-a02b-bdeda0cdad67'
where routingid in ('e49b16f6-b278-4a04-8475-fea6da977a83');



update routing
set routingstatustypeid='8',intakerecommendation='ScreenOUT',supervisordecision='ScreenOUT',activeflag =0
where routingid in ('584e44a5-1a35-4ea5-8dcb-0631d750b8ad');

update intakedastaging
set cruworkername = '299210ac-c6df-4985-a02b-bdeda0cdad67',updatedby = 'CJAMS-62124', updatedon = now()
where id = 13130324 and activeflag = 1;


update documentproperties
set servicecaseid  = null, updatedby = 'CJAMS-62124', updatedon = '2025-09-16 16:52:39.958'
where documentpropertiesid in ('922a0cb0-0e96-4bc3-ab7d-5bb98a1923e2','0261e8db-d8ae-4db3-8dc1-19ee049def1a') and activeflag =1;
