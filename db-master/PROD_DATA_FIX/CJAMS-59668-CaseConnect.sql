/*
Issue:251023007369:Greetings! The worker submitted a case connect request for this case in error. I can not seem to cancel it as it remains in my approval box. 
Root Cause: Due to lack of finctionality to cancel or reject submitted case connect request, any incorrect submission cannot be undone through the UI.
Fix Provided :updated tables into intakesnapshot,intakedastaging,intakeservicerequest.
Data/Code fix ticket#: CJAMS-59668
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: code fix not implemented because the system lacks built in functionality to cancel case connect request, and an immediate manula resolution was required.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/



update intakesnapshot
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
	'{intakeDATypeDetails, 0, dispositioncode}', '"ScreenOUT"', true), updatedby = 'CJAMS-59668', updatedon = now()
where intakenumber  = 'I251013235878' and activeflag = 1;



update intakedastaging
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
	'{intakeDATypeDetails, 0, dispositioncode}', '"ScreenOUT"', true), updatedby = 'CJAMS-59668', updatedon = now()
where intakenumber  = 'I251013235878' and activeflag = 1;

update intakeservicerequest 
set activeflag  = 0,updatedby  = 'CJAMS-59668' , updatedon  = now(),actiontype = null
where intakeserviceid = 'd047a1d3-bdad-429e-92eb-5e4de6a89e5d' and activeflag =1;


update routing 
set activeflag = 0 ,updatedby  = 'CJAMS-59668' , updatedon  = now()
where routingid = '63d653bd-f0c7-455f-9717-7827b43de4aa' and activeflag =1;