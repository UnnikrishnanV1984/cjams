update intakesnapshot SET updatedby = 'CDM-10226', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'-> 0, '{supDisposition}', '"ScreenOUT"'))))
where intakenumber = 'I202000493666' and activeflag = 1;

update intakeservicerequest set activeflag = 0, updatedby = 'CDM-10226', updatedon = now() where intakenumber = 'I202000493666' 
	and  intakeserviceid = '96bed519-18d2-480a-9739-f7671a655a9f' and servicerequestnumber = '20200311050439';
update intakedastaging 	set status = 'Closed', updatedby = 'CDM-10226', updatedon = now() where intakenumber = 'I202000493666' and activeflag = 1;